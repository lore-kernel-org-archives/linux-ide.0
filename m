From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata-ncq: implement NCQ command translation and exclusion
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <1147358683157-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:13740 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751812AbWEKOoz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:55 -0400
Received: by py-out-1112.google.com with SMTP id f28so269346pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:54 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch implements NCQ command translation and exclusion.  Note
that NCQ commands don't use ata_rwcmd_protocol() to choose ATA
command.  This is because, unlike non-NCQ RW commands, NCQ commands
can only be used for NCQ protocol and FUA handling is done with a flag
rather than separate command.

NCQ enabled device will have queue depth larger than one but no two
non-NCQ commands can be issued simultaneously, neither can a non-NCQ
command and NCQ commands.  This patch makes ata_scsi_translate()
return SCSI_MLQUEUE_DEVICE_BUSY if such exclusion is necessary.  SCSI
midlayer will retry the command later.

As SCSI midlayer always retries once a command completes, this doesn't
incur unnecessary delays and as most commands will be NCQ ones for NCQ
device, so the overhead should be negligible.

Initial implementation is from Jens Axboe and using
SCSI_MLQUEUE_DEVICE_BUSY for exclusion is suggested by Jeff Garzik.

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-scsi.c |   72 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletions(-)

350c9937c660b34043c1384e730b3075052bc788
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0c2550e..3e3d3d1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4415,6 +4415,7 @@ static inline int ata_should_dma_map(str
 	struct ata_port *ap = qc->ap;
 
 	switch (qc->tf.protocol) {
+	case ATA_PROT_NCQ:
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
 		return 1;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 96517ca..9bef68c 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1103,7 +1103,36 @@ static unsigned int ata_scsi_rw_xlat(str
 		 */
 		goto nothing_to_do;
 
-	if (dev->flags & ATA_DFLAG_LBA) {
+	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
+		/* yay, NCQ */
+		if (!lba_48_ok(block, n_block))
+			goto out_of_range;
+
+		tf->protocol = ATA_PROT_NCQ;
+		tf->flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
+
+		if (tf->flags & ATA_TFLAG_WRITE)
+			tf->command = ATA_CMD_FPDMA_WRITE;
+		else
+			tf->command = ATA_CMD_FPDMA_READ;
+
+		qc->nsect = n_block;
+
+		tf->nsect = qc->tag << 3;
+		tf->hob_feature = (n_block >> 8) & 0xff;
+		tf->feature = n_block & 0xff;
+
+		tf->hob_lbah = (block >> 40) & 0xff;
+		tf->hob_lbam = (block >> 32) & 0xff;
+		tf->hob_lbal = (block >> 24) & 0xff;
+		tf->lbah = (block >> 16) & 0xff;
+		tf->lbam = (block >> 8) & 0xff;
+		tf->lbal = block & 0xff;
+
+		tf->device = 1 << 6;
+		if (tf->flags & ATA_TFLAG_FUA)
+			tf->device |= 1 << 7;
+	} else if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |= ATA_TFLAG_LBA;
 
 		if (lba_28_ok(block, n_block)) {
@@ -1227,6 +1256,39 @@ static void ata_scsi_qc_complete(struct 
 }
 
 /**
+ *	ata_scmd_need_defer - Check whether we need to defer scmd
+ *	@dev: ATA device to which the command is addressed
+ *	@is_io: Is the command IO (and thus possibly NCQ)?
+ *
+ *	NCQ and non-NCQ commands cannot run together.  As upper layer
+ *	only knows the queue depth, we are responsible for maintaining
+ *	exclusion.  This function checks whether a new command can be
+ *	issued to @dev.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	1 if deferring is needed, 0 otherwise.
+ */
+static int ata_scmd_need_defer(struct ata_device *dev, int is_io)
+{
+	struct ata_port *ap = dev->ap;
+
+	if (!(dev->flags & ATA_DFLAG_NCQ))
+		return 0;
+
+	if (is_io) {
+		if (!ata_tag_valid(ap->active_tag))
+			return 0;
+	} else {
+		if (!ata_tag_valid(ap->active_tag) && !ap->sactive)
+			return 0;
+	}
+	return 1;
+}
+
+/**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@dev: ATA device to which the command is addressed
  *	@cmd: SCSI command to execute
@@ -1259,9 +1321,13 @@ static int ata_scsi_translate(struct ata
 {
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
+	int is_io = xlat_func == ata_scsi_rw_xlat;
 
 	VPRINTK("ENTER\n");
 
+	if (unlikely(ata_scmd_need_defer(dev, is_io)))
+		goto defer;
+
 	qc = ata_scsi_qc_new(dev, cmd, done);
 	if (!qc)
 		goto err_mem;
@@ -1308,6 +1374,10 @@ err_mem:
 	done(cmd);
 	DPRINTK("EXIT - internal\n");
 	return 0;
+
+defer:
+	DPRINTK("EXIT - defer\n");
+	return SCSI_MLQUEUE_DEVICE_BUSY;
 }
 
 /**
-- 
1.2.4


