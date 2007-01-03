From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: kill qc->nsect and cursect
Date: Wed, 3 Jan 2007 17:30:39 +0900
Message-ID: <20070103083039.GG10987@htj.dyndns.org>
References: <20061217014827.GK5400@htj.dyndns.org> <20061217015008.GL5400@htj.dyndns.org> <20061220062546.GA4823@htj.dyndns.org> <45899560.8090401@pobox.com> <459B66BA.2010405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:49899 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755032AbXACIas (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 03:30:48 -0500
Content-Disposition: inline
In-Reply-To: <459B66BA.2010405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com, carlosmarcelomartinez@gmail.com

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

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -1249,7 +1249,7 @@ unsigned ata_exec_internal_sg(struct ata
 			buflen += sg[i].length;
 
 		ata_sg_init(qc, sg, n_elem);
-		qc->nsect = buflen / ATA_SECT_SIZE;
+		qc->nbytes = buflen;
 	}
 
 	qc->private_data = &wait;
@@ -4031,11 +4031,11 @@ static void ata_pio_sector(struct ata_qu
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
@@ -4060,10 +4060,10 @@ static void ata_pio_sector(struct ata_qu
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
@@ -4088,7 +4088,8 @@ static void ata_pio_sectors(struct ata_q
 
 		WARN_ON(qc->dev->multi_count == 0);
 
-		nsect = min(qc->nsect - qc->cursect, qc->dev->multi_count);
+		nsect = min((qc->nbytes - qc->curbytes) / ATA_SECT_SIZE,
+			    qc->dev->multi_count);
 		while (nsect--)
 			ata_pio_sector(qc);
 	} else
Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -1323,7 +1323,7 @@ static unsigned int ata_scsi_rw_xlat(str
 		goto nothing_to_do;
 
 	qc->flags |= ATA_QCFLAG_IO;
-	qc->nsect = n_block;
+	qc->nbytes = n_block * ATA_SECT_SIZE;
 
 	rc = ata_build_rw_tf(&qc->tf, qc->dev, block, n_block, tf_flags,
 			     qc->tag);
@@ -2626,7 +2626,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
-	qc->nsect = scmd->request_bufflen / ATA_SECT_SIZE;
+	qc->nbytes = scmd->request_bufflen;
 
 	/* request result TF */
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -430,9 +430,6 @@ struct ata_queued_cmd {
 
 	unsigned int		pad_len;
 
-	unsigned int		nsect;
-	unsigned int		cursect;
-
 	unsigned int		nbytes;
 	unsigned int		curbytes;
 
@@ -1145,8 +1142,7 @@ static inline void ata_qc_reinit(struct 
 {
 	qc->__sg = NULL;
 	qc->flags = 0;
-	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
-	qc->nsect = 0;
+	qc->cursg = qc->cursg_ofs = 0;
 	qc->nbytes = qc->curbytes = 0;
 	qc->err_mask = 0;
 
Index: work/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- work.orig/drivers/ata/pata_pdc202xx_old.c
+++ work/drivers/ata/pata_pdc202xx_old.c
@@ -189,10 +189,7 @@ static void pdc2026x_bmdma_start(struct 
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
Index: work/drivers/ata/sata_qstor.c
===================================================================
--- work.orig/drivers/ata/sata_qstor.c
+++ work/drivers/ata/sata_qstor.c
@@ -325,7 +325,7 @@ static void qs_qc_prep(struct ata_queued
 	/* host control block (HCB) */
 	buf[ 0] = QS_HCB_HDR;
 	buf[ 1] = hflags;
-	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
+	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nbytes);
 	*(__le32 *)(&buf[ 8]) = cpu_to_le32(nelem);
 	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
 	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1443,15 +1443,10 @@ static void ata_eh_report(struct ata_por
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
@@ -1461,7 +1456,7 @@ static void ata_eh_report(struct ata_por
 			cmd->lbal, cmd->lbam, cmd->lbah,
 			cmd->hob_feature, cmd->hob_nsect,
 			cmd->hob_lbal, cmd->hob_lbam, cmd->hob_lbah,
-			cmd->device, qc->tag, qc->cdb[0], nbytes,
+			cmd->device, qc->tag, qc->cdb[0], qc->nbytes,
 			dma_str[qc->dma_dir],
 			res->command, res->feature, res->nsect,
 			res->lbal, res->lbam, res->lbah,
