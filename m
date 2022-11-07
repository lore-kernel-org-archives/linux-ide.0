Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED011C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 16:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiKGQKz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 11:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiKGQKo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 11:10:44 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC020363
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 08:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667837443; x=1699373443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=caKJkWRc/AXDgJppCja4vlDiaNvWRJ/36ThmslFZ9l8=;
  b=jYFAgpnUnEQsTf7POH/Wjczz57ybqaqqbAwqGTV1AFsrCnlBnFiYZxFc
   Rw5SIMFawmhCkD3RWY9Yzp4JJPrUKQov56xvcvjr0jPAEqNxe4mNDdJ9B
   MfGLhJVxgkB82j2XSKMJsp9h3UroxoYDOZr3melsB1yK6cdZ+kUV+Upnd
   itjYw6QtUw0h1vcpiPJb3VjtOArgz9tQ/gHkaGBkeQUHzEu4Ae4KN5alZ
   f1L4TfylkLmym1AxGo0uWULVWI/Pss3ciTU2FawI05hja6iHizQgX72G7
   aUNbbcPpkvwvI8eqO6CU+nqbDaosWoMjuGH5rTwz2K/XtxEgYm2zKOodZ
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="216017265"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 00:10:42 +0800
IronPort-SDR: IGeko97yL+6mgiP3/vhnpDO1E1VPKa1FinY76NuBHN7POFJpRkHTsXbIWv8SXaegWW/TicVjQt
 PBYQ9l0+8WiGt3+K1jd+RlSijuA7/9u3W6VjYFPt3jhg9XdZ4PqC053evPAloNHevDv+OSyiQH
 X7MRiP26xVEILNaNS4Fbk1/LsmVuFK0hZOce/G0JH/cTyKFbkFEMFq5AwgQrV8opY9UxKZx4kl
 R2Ete1IWyRwN5OV/DkL+42esGlPwrNsMs/aF6WPcJhm4Tp3lLrLp1xcpefIXkVbYR4/NpEd4f2
 ouM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 07:29:49 -0800
IronPort-SDR: IfLwRmZkkyFsIqBz3qwgc++WcfIUZ5cl0Xa0Ej+q3OBqIfckeUYVey3CBwnENBxNwpLwKlyWnl
 u1AjxI+wU4xjfYE2PRPlUzrlflcXKCTmmTCCFYJmLE+XImt0KvJ+kZINbe+N2CcgoSwC0+YF5t
 DE6tcWGRtd1rFnIT33fm3hsR4+wmXuWIjqpSzSx1ghWBeVAq7nAAw4ZIHrrjuKhPci+H3SRIuN
 vvMzhEgDf8B4mShZ4N9okMXj0t8tvrofLPWq0eSxSVDBv3RsUJnvCJzwfkLjZfCplnE4YAT6pw
 m/E=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2022 08:10:42 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     damien.lemoal@opensource.wdc.com, tj@kernel.org, hare@suse.de
Cc:     linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2] ata: libata-core: do not issue non-internal commands once EH is pending
Date:   Mon,  7 Nov 2022 17:10:36 +0100
Message-Id: <20221107161036.670237-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

scsi_queue_rq() will check if scsi_host_in_recovery() (state is
SHOST_RECOVERY), and if so, it will _not_ issue a command via:
scsi_dispatch_cmd() -> host->hostt->queuecommand() (ata_scsi_queuecmd())
-> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()

Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
when receiving a TFES error IRQ, this was the call chain:
ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)

Which meant that as soon as the error IRQ was serviced, no additional
commands sent from the block layer (scsi_queue_rq()) would be sent down
to the device. (ATA internal commands originating for ATA EH could of
course still be sent.)

However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
scsi_times_out() would instead result in a call to scsi_abort_command() ->
queue_delayed_work(). work function: scmd_eh_abort_handler() would call
scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVERY).

(It was possible to get the old behavior if host->hostt->no_async_abort
was set, but libata never used it, and this option was completely removed
in commit a06586325f37 ("scsi: make asynchronous aborts mandatory"))

Additionally, later in commit 358f70da49d7 ("blk-mq: make
blk_abort_request() trigger timeout path"), blk_abort_request() was changed
to also call the abort callback asynchronously.

So now, after the TFES error irq has been serviced, we need to wait for
two different workqueues to run their work, before the SHOST_RECOVERY
state gets set.

While the ATA specification states that a device should return command
aborted for all commands queued after the device has entered error state,
since ATA only keeps the sense data for the latest command (in non-NCQ
case), we really don't want to send block layer commands to the device
after it has entered error state. (Only ATA EH commands should be sent,
to read the sense data etc.)

While we could just call scsi_host_set_state(shost, SHOST_RECOVERY) from
ata_qc_schedule_eh() directly, that might be a layering violation.
So instead of doing that, add an additional check against the libata's own
EH flag(s) before calling the qc_defer callback.

Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Changes since v1:
-Implemented review comments from Damien.

 drivers/ata/libata-scsi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4cb914103382..383a208f5f99 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1736,6 +1736,26 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	if (xlat_func(qc))
 		goto early_finish;
 
+	/*
+	 * scsi_queue_rq() will defer commands when in state SHOST_RECOVERY.
+	 *
+	 * When getting an error interrupt, ata_port_abort() will be called,
+	 * which ends up calling ata_qc_schedule_eh() on all QCs.
+	 *
+	 * ata_qc_schedule_eh() will call ata_eh_set_pending() and then call
+	 * blk_abort_request() on the given QC. blk_abort_request() will
+	 * asynchronously end up calling scsi_eh_scmd_add(), which will set
+	 * the state to SHOST_RECOVERY and wake up SCSI EH.
+	 *
+	 * In order to avoid requests from being issued to the device from the
+	 * time ata_eh_set_pending() is called, to the time scsi_eh_scmd_add()
+	 * sets the state to SHOST_RECOVERY, we defer requests here as well.
+	 */
+	if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
+		rc = ATA_DEFER_LINK;
+		goto defer;
+	}
+
 	if (ap->ops->qc_defer) {
 		if ((rc = ap->ops->qc_defer(qc)))
 			goto defer;
-- 
2.38.1

