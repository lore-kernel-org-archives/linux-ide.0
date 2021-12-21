Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30043C43219
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhLUHWy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhLUHWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0B8AE1F3BF;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hdRFbcvRNiAxUkjJ6wF5Br6yTxBWsNBPZ8NoeiIP5Mw=;
        b=kM7bOE6MjCQvpFUf5AcaWKbCT/jkkzt/6DGIGhT5MY/MtScegVRSqUuZneDQD7I5GowVdE
        KtFsgB0Mw/ObCCaAonLwbxtebHcX+4hDj/Z3XyE/k6xe9Zk21jzrVMBFjlj9F9W8zZgEHk
        YjTV89TjET4PiSiNbmhRMgoTGD4NdVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hdRFbcvRNiAxUkjJ6wF5Br6yTxBWsNBPZ8NoeiIP5Mw=;
        b=KtbmQqLXm75z8mzepBWGYwqQyF0DmOgJILcZSrQOgfyT96cFmLhd7fQKqun1+Tn6uXJZNy
        VV0/06OLO+C2I0Aw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 06846A3B9B;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0552E51923A0; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 23/68] libata: remove pointless VPRINTK() calls
Date:   Tue, 21 Dec 2021 08:20:46 +0100
Message-Id: <20211221072131.46673-24-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Most of the information is already covered by tracepoints
(if not downright pointless), so remove the VPRINTK() calls.
And while we're at it, remove ata_scsi_dump_cdb(), too,
as this information can be retrieved from scsi tracing.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c |  3 ---
 drivers/ata/libata-sata.c |  2 --
 drivers/ata/libata-scsi.c | 42 ---------------------------------------
 drivers/ata/libata-sff.c  |  4 ----
 drivers/ata/libata.h      |  1 -
 5 files changed, 52 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 05a52e683593..3a532af172e0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4503,8 +4503,6 @@ static void ata_sg_clean(struct ata_queued_cmd *qc)
 
 	WARN_ON_ONCE(sg == NULL);
 
-	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
-
 	if (qc->n_elem)
 		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
 
@@ -4534,7 +4532,6 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	if (n_elem < 1)
 		return -1;
 
-	VPRINTK("%d sg elements mapped\n", n_elem);
 	qc->orig_n_elem = qc->n_elem;
 	qc->n_elem = n_elem;
 	qc->flags |= ATA_QCFLAG_DMAMAP;
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index d9b5744a3b06..bfe9595d4f33 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1258,8 +1258,6 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 {
 	int rc = 0;
 
-	ata_scsi_dump_cdb(ap, cmd);
-
 	if (likely(ata_dev_enabled(ap->link.device)))
 		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
 	else {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bfbb4cca4c17..11fb046e3035 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1299,8 +1299,6 @@ static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len;
 
-	VPRINTK("six-byte command\n");
-
 	lba |= ((u64)(cdb[1] & 0x1f)) << 16;
 	lba |= ((u64)cdb[2]) << 8;
 	lba |= ((u64)cdb[3]);
@@ -1326,8 +1324,6 @@ static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len = 0;
 
-	VPRINTK("ten-byte command\n");
-
 	lba |= ((u64)cdb[2]) << 24;
 	lba |= ((u64)cdb[3]) << 16;
 	lba |= ((u64)cdb[4]) << 8;
@@ -1355,8 +1351,6 @@ static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len = 0;
 
-	VPRINTK("sixteen-byte command\n");
-
 	lba |= ((u64)cdb[2]) << 56;
 	lba |= ((u64)cdb[3]) << 48;
 	lba |= ((u64)cdb[4]) << 40;
@@ -1706,8 +1700,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	struct ata_queued_cmd *qc;
 	int rc;
 
-	VPRINTK("ENTER\n");
-
 	qc = ata_scsi_qc_new(dev, cmd);
 	if (!qc)
 		goto err_mem;
@@ -1738,7 +1730,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
-	VPRINTK("EXIT\n");
 	return 0;
 
 early_finish:
@@ -1851,8 +1842,6 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		2
 	};
 
-	VPRINTK("ENTER\n");
-
 	/* set scsi removable (RMB) bit per ata bit, or if the
 	 * AHCI port says it's external (Hotplug-capable, eSATA).
 	 */
@@ -2287,8 +2276,6 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 	u8 dpofua, bp = 0xff;
 	u16 fp;
 
-	VPRINTK("ENTER\n");
-
 	six_byte = (scsicmd[0] == MODE_SENSE);
 	ebd = !(scsicmd[1] & 0x8);      /* dbd bit inverted == edb */
 	/*
@@ -2406,8 +2393,6 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 	log2_per_phys = ata_id_log2_per_physical_sector(dev->id);
 	lowest_aligned = ata_id_logical_sector_offset(dev->id, log2_per_phys);
 
-	VPRINTK("ENTER\n");
-
 	if (args->cmd->cmnd[0] == READ_CAPACITY) {
 		if (last_lba >= 0xffffffffULL)
 			last_lba = 0xffffffff;
@@ -2474,7 +2459,6 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
  */
 static unsigned int ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *rbuf)
 {
-	VPRINTK("ENTER\n");
 	rbuf[3] = 8;	/* just one lun, LUN 0, size 8 bytes */
 
 	return 0;
@@ -2570,8 +2554,6 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
 
-	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
-
 	/* handle completion from new EH */
 	if (unlikely(qc->ap->ops->error_handler &&
 		     (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))) {
@@ -3680,8 +3662,6 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 	u8 buffer[64];
 	const u8 *p = buffer;
 
-	VPRINTK("ENTER\n");
-
 	six_byte = (cdb[0] == MODE_SELECT);
 	if (six_byte) {
 		if (scmd->cmd_len < 5) {
@@ -3979,26 +3959,6 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 	return NULL;
 }
 
-/**
- *	ata_scsi_dump_cdb - dump SCSI command contents to dmesg
- *	@ap: ATA port to which the command was being sent
- *	@cmd: SCSI command to dump
- *
- *	Prints the contents of a SCSI command via printk().
- */
-
-void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd)
-{
-#ifdef ATA_VERBOSE_DEBUG
-	struct scsi_device *scsidev = cmd->device;
-
-	VPRINTK("CDB (%u:%d,%d,%lld) %9ph\n",
-		ap->print_id,
-		scsidev->channel, scsidev->id, scsidev->lun,
-		cmd->cmnd);
-#endif
-}
-
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 {
 	u8 scsi_op = scmd->cmnd[0];
@@ -4077,8 +4037,6 @@ int ata_scsi_queuecmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 
 	spin_lock_irqsave(ap->lock, irq_flags);
 
-	ata_scsi_dump_cdb(ap, cmd);
-
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
 		rc = __ata_scsi_queuecmd(cmd, dev);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b544bdc6d0a3..d5dbeb68b2bf 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -877,8 +877,6 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 	if (unlikely(!bytes))
 		goto atapi_check;
 
-	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
-
 	if (unlikely(__atapi_pio_bytes(qc, bytes)))
 		goto err_out;
 	ata_sff_sync(ap); /* flush */
@@ -2586,7 +2584,6 @@ static void ata_bmdma_fill_sg(struct ata_queued_cmd *qc)
 
 			prd[pi].addr = cpu_to_le32(addr);
 			prd[pi].flags_len = cpu_to_le32(len & 0xffff);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
 
 			pi++;
 			sg_len -= len;
@@ -2646,7 +2643,6 @@ static void ata_bmdma_fill_sg_dumb(struct ata_queued_cmd *qc)
 				prd[++pi].addr = cpu_to_le32(addr + 0x8000);
 			}
 			prd[pi].flags_len = cpu_to_le32(blen);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
 
 			pi++;
 			sg_len -= len;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 2144065e762c..51e01acdd241 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -148,7 +148,6 @@ extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, u64 lun);
 void ata_scsi_sdev_config(struct scsi_device *sdev);
 int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev);
-void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd);
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
 
 /* libata-eh.c */
-- 
2.29.2

