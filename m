Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB5C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 23:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiKHXPp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKHXPn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 18:15:43 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC991ADA7
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 15:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667949341; x=1699485341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OOKhhSw/PPHD6kzTa/cAGibiDQ03PKOBobvsmwsXV0c=;
  b=I3i+y2wOdNcjufej2ERET2/G+04AAvRO4CdIySyzrSp1w2HKWdXkvfW4
   dd6noC0nPrIq2Q7A0RozyNr/I6URnHoYq6/f5KbLUZyFqAahoiLzsl0rz
   6ShbjSFIScuKscXJTdQNY5pS7URcIN7nyzI9bSp9dTstwQMTTTQhzcbNF
   Jhere8CQgNZ8rD/KtS4+0DovSemDruh3XFmo+/AHNYOG0aLuSFqGmbp4+
   d8a1UfoEUv8DxUdUCzHdEMEHsKcUkF8jpNq8/hqHiQLOaWerYWKPkXb0G
   NRJcWHYAV6ymvOYEdGojN8X5Q5JANFuBAju+L2HDgqqmH7f/CSyUAB4cl
   A==;
X-IronPort-AV: E=Sophos;i="5.96,149,1665417600"; 
   d="scan'208";a="220963217"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 07:15:40 +0800
IronPort-SDR: 7cjWEe+YUR7mo0SMatjxUpmg+PaIuUFIt0Pg6KjSZ6WMawaNbwmA4PvBwkViXkZ/Xml0YcLVVQ
 aC8MekmcFOcHAAN1uSzvNa991ptJM1ryjOQV0GS5FnX5B9EEC2bRGJ1cepKRW/TWko1UIvQF8o
 5ubRtUnjschFd/YvldX4pznlBYkm2rw/JOdnCI2AfE3MpgEC10RfzKT3jFGvyxX1OqCGZMCXgF
 d0jI35SsjtH+Axp7w041BuaqyodW/FlygnCBzPLVZno32ncgbo2r+EDRaGyg6hiZrKgfgrd4lm
 UTA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 14:29:01 -0800
IronPort-SDR: 4IplWqIlN64LXjVqww9DFagjgnLcCtDEJzWDi7yEd4zpH0uKTetpifHEwT4oz5MumB8mZ6gRuN
 b2qGbAwqLllQnnTbZcDdk8GJwZhodNM3S96McsZ4U2pW3N6o9G6RGe0WNYSY8Nis4CauToDyHk
 SVw9N0TJ95BNa2qs9T7RblHbQXkcgzpAxO2CWLa55ivuu6xdN47OATWWhrBDtwtQK7eiTj42Kv
 hhLX1nHp4AmxJQPtwpxDgyhSncX4SS+hAEe95zersklnLI3TMSbrQ2q23nXqp16PS19zZR5Avn
 p3k=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Nov 2022 15:15:40 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     damien.lemoal@opensource.wdc.com, tj@kernel.org, hare@suse.de
Cc:     linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3] ata: libata-core: do not issue non-internal commands once EH is pending
Date:   Wed,  9 Nov 2022 00:15:34 +0100
Message-Id: <20221108231534.982516-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

While the ATA specification states that a device should return command
aborted for all commands queued after the device has entered error state,
since ATA only keeps the sense data for the latest command (in non-NCQ
case), we really don't want to send block layer commands to the device
after it has entered error state. (Only ATA EH commands should be sent,
to read the sense data etc.)

Currently, scsi_queue_rq() will check if scsi_host_in_recovery()
(state is SHOST_RECOVERY), and if so, it will _not_ issue a command via:
scsi_dispatch_cmd() -> host->hostt->queuecommand() (ata_scsi_queuecmd())
-> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()

Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
when receiving a TFES error IRQ, the call chain looked like this:
ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)

Which meant that as soon as an error IRQ was serviced, SHOST_RECOVERY
would be set.

However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
scsi_times_out() will instead call scsi_abort_command() which will queue
delayed work, and the worker function scmd_eh_abort_handler() will call
scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVERY).

So now, after the TFES error IRQ has been serviced, we need to wait for
the SCSI workqueue to run its work before SHOST_RECOVERY gets set.

It is worth noting that, even before commit e494f6a72839 ("[SCSI] improved
eh timeout handler"), we could receive an error IRQ from the time when
scsi_queue_rq() checks scsi_host_in_recovery(), to the time when
ata_scsi_queuecmd() is actually called.

In order to handle both the delayed setting of SHOST_RECOVERY and the
window where we can receive an error IRQ, add a check against
ATA_PFLAG_EH_PENDING (which gets set when servicing the error IRQ),
inside ata_scsi_queuecmd() itself, while holding the ap->lock.
(Since the ap->lock is held while servicing IRQs.)

Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Changes since v2:
-Improve commit message and the comment inside the code.
-Move the check to __ata_scsi_queuecmd().

 drivers/ata/libata-scsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4cb914103382..93ebcdf2e354 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3978,9 +3978,19 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 {
+	struct ata_port *ap = dev->link->ap;
 	u8 scsi_op = scmd->cmnd[0];
 	ata_xlat_func_t xlat_func;
 
+	/*
+	 * scsi_queue_rq() will defer commands if scsi_host_in_recovery().
+	 * However, this check is done without holding the ap->lock (a libata
+	 * specific lock), so we can have received an error irq since then,
+	 * therefore we must check if EH is pending, while holding ap->lock.
+	 */
+	if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS))
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+
 	if (unlikely(!scmd->cmd_len))
 		goto bad_cdb_len;
 
-- 
2.38.1

