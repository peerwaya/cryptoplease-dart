import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'cancelable_job.dart';
import 'payment_watcher.dart';
import 'repository.dart';

/// Watches for [OSKPStatus.cancelTxSent] payments and waits for the tx to be
/// confirmed.
@injectable
class CancelTxSentWatcher extends PaymentWatcher {
  CancelTxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingSplitKeyPayment> createJob(
    OutgoingSplitKeyPayment payment,
  ) =>
      _Job(payment, _sender);

  @override
  Stream<IList<OutgoingSplitKeyPayment>> watchPayments(
    OSKPRepository repository,
  ) =>
      repository.watchCancelTxSent();
}

class _Job extends CancelableJob<OutgoingSplitKeyPayment> {
  _Job(this.payment, this.sender);

  final OutgoingSplitKeyPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! OSKPStatusCancelTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx);

    final OSKPStatus? newStatus = tx.map(
      success: (_) => OSKPStatus.canceled(txId: status.tx.id),
      failure: (tx) => OSKPStatus.cancelTxFailure(
        reason: tx.reason,
        escrow: status.escrow,
      ),
      networkError: (_) => null,
    );

    if (newStatus == null) {
      return null;
    }

    return payment.copyWith(status: newStatus);
  }
}