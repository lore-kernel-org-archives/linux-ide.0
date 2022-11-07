Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B7BC43217
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 09:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiKGJve (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiKGJv3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 04:51:29 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD717A84
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667814687; x=1699350687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MXNnwjMmGV0ISX54K1NQBfiafegtug2n5OorMDE35fw=;
  b=kvBUQluj/eoCEJ1LpVfk9su8oD5v47P3FqPDr5VCxh6gjHaTZ77Zfetm
   OEG6s/46kTwMjdraGjtl0TqBhilfg9g1kqb9u8rNZ3P9M22Wz5PK9qd9e
   9fCXpxpnJIDDtgEFAImIj5MKTqxaSJob0Brq8Hdt3BulZ4sBvyfH8Flcd
   mMlpVNVTPLWccvPTtHusEp7TaRLRpmmiR2nny9nIK2nuugTJ5+ilRQQgl
   Fh+XaG7yrExkMDPrGxu/h7B1OnIkUzEUVAZXZ7f/tw60xaIMq4O/WlByB
   v6CnQ+fQFO0pc+SSl2/5IrqZ9g5+CSqQBkZd5976WlhYimVSvI8TBMCFQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="213940453"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 17:51:24 +0800
IronPort-SDR: wc+cu+OFMttg0MDqvrEZr2Ciwrg4w+9pApl/XZpXZg77+cbPHL+S0KYbTvaUZ8QAgXeivyB9N9
 Z7L6G5DK2D9yiuCVhQbOl3G4TqNBudsbfpzT7N+LW8iO5JCsz+hwqJrVU62zbpyh9OmSJvuUHd
 MunT8F55QahRiE/4ih57rLp4CBofnYEYi5oR4E0Fju0Jqf3Jwelg/270aY+YRDEYCKbs+CZbuD
 qDkVlMv/f0yv2KTHDHKvq6orHMA0PghxJZ/e5kk65sEqzbM0R3FfMnNnT1pD3lEfvS6trwQ7xe
 9qg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 01:10:27 -0800
IronPort-SDR: vBJ02DBYALYm1eHSMaElNQGbzFiVCnQ5grCjPKNsVWrImvETAdG23yDnRIlzfBn4bxSYgcrPav
 SksV5gx94//6fO9zERVYVqkBSADbeJ+wOPk6TQFS9jJY5AS4ZTJp9Ms3JWxPAUMZcvtT23lIB+
 PovIsBok8PwUrYbb6bJXtkTm9kDkALIzmETQQacb21uxc0Pd/8gfXXcKwx4mhL63PweK+z/hwg
 DaNwMEJNeXDrIqJGS1YTprMN+q8st2ZODFrgqLS1XdLq08SuCHFbhJAVfPZTVPVYDVhXXcbxqh
 dJE=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2022 01:51:18 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     damien.lemoal@opensource.wdc.com, tj@kernel.org, hare@suse.de
Cc:     linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] ata: libata-core: do not issue non-internal commands once EH is pending
Date:   Mon,  7 Nov 2022 10:51:04 +0100
Message-Id: <20221107095104.625519-1-niklas.cassel@wdc.com>
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
when receiving a TFES error IRQ, this is the call chain:
ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)

Which meant that as soon as the error IRQ was serviced, no additional
commands sent from the block layer (scsi_queue_rq()) would be sent
down to the device. (ATA internal commands originating for ATA EH
could of course still be sent.)

However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
scsi_times_out() would instead result in a call to scsi_abort_command() ->
queue_delayed_work(). work function: scmd_eh_abort_handler() would call
scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVERY).

(It was possible to get the old behavior if host->hostt->no_async_abort
was set, but libata never used it, and this option was completely removed
in commit a06586325f37 ("scsi: make asynchronous aborts mandatory"))

Additionally, later in commit 358f70da49d7 ("blk-mq: make
blk_abort_request() trigger timeout path") blk_abort_request() was changed
to also call the abort callback asynchronously.

Tejun mentioned that:
"Note that this makes blk_abort_request() asynchronous - it initiates
abortion but the actual termination will happen after a short while,
even when the caller owns the request.  AFAICS, SCSI and ATA should be
fine with that and I think mtip32xx and dasd should be safe but not
completely sure."

So now, after the TFES irq has been serviced, we need to wait for two
different workqueues to run their work, before the SHOST_RECOVERY state
gets set.

While the ATA specification states that a device should return command
aborted for all commands queued after the device has entered error state,
since ATA only keeps the sense data for the latest command (in non-NCQ
case), we really don't want to send block layer commands to the device
after it has entered error state. (Only ATA EH commands should be sent,
to read the sense data etc.)

While we could just call scsi_host_set_state(shost, SHOST_RECOVERY) from
ata_qc_schedule_eh() directly, that smells like a layering violation,
So instead of doing that, add an additional check against the libata's
own EH flag(s) in the existing qc_defer callback.

Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..ab6c69be3d4a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4458,6 +4458,9 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
 {
 	struct ata_link *link = qc->dev->link;
 
+	if (qc->ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS))
+		return ATA_DEFER_LINK;
+
 	if (ata_is_ncq(qc->tf.protocol)) {
 		if (!ata_tag_valid(link->active_tag))
 			return 0;
-- 
2.38.1

