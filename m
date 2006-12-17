From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: kill qc->nsect and cursect
Date: Sun, 17 Dec 2006 10:48:27 +0900
Message-ID: <20061217014827.GK5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:48424 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbWLQBsg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 20:48:36 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1550268nfa
        for <linux-ide@vger.kernel.org>; Sat, 16 Dec 2006 17:48:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com, carlosmarcelomartinez@gmail.com

libata used two separate sets of variables to record request size and
current offset for ATA and ATAPI.  This is confusing and fragile.
This patch replaces qc->nsect/cursect with qc->nbytes/curbytes and
kills them.  Also, ata_pio_sector() is updated to use bytes for
qc->cursg_ofs instead of sectors.  The field used to be used in bytes
for ATAPI and in sectors for ATA.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c       |   15 ++++++++-------
 drivers/ata/libata-eh.c         |    7 +------
 drivers/ata/libata-scsi.c       |    4 ++--
 drivers/ata/pata_pdc202xx_old.c |    5 +----
 drivers/ata/sata_qstor.c        |    2 +-
 include/linux/libata.h          |    6 +-----
 6 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fd20e7a..2a496d0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1249,7 +1249,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 			buflen += sg[i].length;
 
 		ata_sg_init(qc, sg, n_elem);
-		qc->nsect = buflen / ATA_SECT_SIZE;
+		qc->nbytes = buflen;
 	}
 
 	qc->private_data = &wait;
@@ -4031,11 +4031,11 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	unsigned int offset;
 	unsigned char *buf;
 
-	if (qc->cursect == (qc->nsect - 1))
+	if (qc->curbytes == qc->nbytes - ATA_SECT_SIZE)
 		ap->hsm_task_state = HSM_ST_LAST;
 
 	page = sg[qc->cursg].page;
-	offset = sg[qc->cursg].offset + qc->cursg_ofs * ATA_SECT_SIZE;
+	offset = sg[qc->cursg].offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
 	page = nth_page(page, (offset >> PAGE_SHIFT));
@@ -4060,10 +4060,10 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		ap->ops->data_xfer(qc->dev, buf + offset, ATA_SECT_SIZE, do_write);
 	}
 
-	qc->cursect++;
-	qc->cursg_ofs++;
+	qc->curbytes += ATA_SECT_SIZE;
+	qc->cursg_ofs += ATA_SECT_SIZE;
 
-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
+	if (qc->cursg_ofs == (&sg[qc->cursg])->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -4088,7 +4088,8 @@ static void ata_pio_sectors(struct ata_queued_cmd *qc)
 
 		WARN_ON(qc->dev->multi_count == 0);
 
-		nsect = min(qc->nsect - qc->cursect, qc->dev->multi_count);
+		nsect = min((qc->nbytes - qc->curbytes) / ATA_SECT_SIZE,
+			    qc->dev->multi_count);
 		while (nsect--)
 			ata_pio_sector(qc);
 	} else
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 08ad44b..dee403c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1443,15 +1443,10 @@ static void ata_eh_report(struct ata_port *ap)
 		};
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 		struct ata_taskfile *cmd = &qc->tf, *res = &qc->result_tf;
-		unsigned int nbytes;
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
 			continue;
 
-		nbytes = qc->nbytes;
-		if (!nbytes)
-			nbytes = qc->nsect << 9;
-
 		ata_dev_printk(qc->dev, KERN_ERR,
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
 			"tag %d cdb 0x%x data %u %s\n         "
@@ -1461,7 +1456,7 @@ static void ata_eh_report(struct ata_port *ap)
 			cmd->lbal, cmd->lbam, cmd->lbah,
 			cmd->hob_feature, cmd->hob_nsect,
 			cmd->hob_lbal, cmd->hob_lbam, cmd->hob_lbah,
-			cmd->device, qc->tag, qc->cdb[0], nbytes,
+			cmd->device, qc->tag, qc->cdb[0], qc->nbytes,
 			dma_str[qc->dma_dir],
 			res->command, res->feature, res->nsect,
 			res->lbal, res->lbam, res->lbah,
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 836947d..b4faaa4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1321,7 +1321,7 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 		goto nothing_to_do;
 
 	qc->flags |= ATA_QCFLAG_IO;
-	qc->nsect = n_block;
+	qc->nbytes = n_block * ATA_SECT_SIZE;
 
 	rc = ata_build_rw_tf(&qc->tf, qc->dev, block, n_block, tf_flags,
 			     qc->tag);
@@ -2623,7 +2623,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
-	qc->nsect = scmd->request_bufflen / ATA_SECT_SIZE;
+	qc->nbytes = scmd->request_bufflen;
 
 	/* request result TF */
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index ad691b9..ba982ba 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -189,10 +189,7 @@ static void pdc2026x_bmdma_start(struct ata_queued_cmd *qc)
 	/* Cases the state machine will not complete correctly without help */
 	if ((tf->flags & ATA_TFLAG_LBA48) ||  tf->protocol == ATA_PROT_ATAPI_DMA)
 	{
-		if (tf->flags & ATA_TFLAG_LBA48)
-			len = qc->nsect * 512;
-		else
-			len = qc->nbytes;
+		len = qc->nbytes;
 
 		if (tf->flags & ATA_TFLAG_WRITE)
 			len |= 0x06000000;
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 710909d..0292a79 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -325,7 +325,7 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 	/* host control block (HCB) */
 	buf[ 0] = QS_HCB_HDR;
 	buf[ 1] = hflags;
-	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
+	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nbytes);
 	*(__le32 *)(&buf[ 8]) = cpu_to_le32(nelem);
 	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
 	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9356322..b7c86b4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -430,9 +430,6 @@ struct ata_queued_cmd {
 
 	unsigned int		pad_len;
 
-	unsigned int		nsect;
-	unsigned int		cursect;
-
 	unsigned int		nbytes;
 	unsigned int		curbytes;
 
@@ -1145,8 +1142,7 @@ static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
 {
 	qc->__sg = NULL;
 	qc->flags = 0;
-	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
-	qc->nsect = 0;
+	qc->cursg = qc->cursg_ofs = 0;
 	qc->nbytes = qc->curbytes = 0;
 	qc->err_mask = 0;
 
-- 
1.4.4.2


