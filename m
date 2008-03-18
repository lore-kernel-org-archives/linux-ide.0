From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 1/2] libata: implement ata_qc_raw_nbytes()
Date: Tue, 18 Mar 2008 17:47:43 +0900
Message-ID: <47DF81AF.7080000@gmail.com>
References: <47D5EFD4.2090801@gmail.com> <47DE63C8.2000006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:21874 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYCRIrx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Mar 2008 04:47:53 -0400
Received: by wa-out-1112.google.com with SMTP id v27so6826086wah.23
        for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2008 01:47:52 -0700 (PDT)
In-Reply-To: <47DE63C8.2000006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>

Implement ata_qc_raw_nbytes() which determines the raw user-requested
size of a PC command.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   14 +++++++++++---
 include/linux/libata.h    |    8 +++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -527,6 +527,14 @@ static struct ata_queued_cmd *ata_scsi_q
 	return qc;
 }
 
+static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *scmd = qc->scsicmd;
+
+	qc->extrabytes = scmd->request->extra_len;
+	qc->nbytes = scsi_bufflen(scmd) + qc->extrabytes;
+}
+
 /**
  *	ata_dump_status - user friendly display of error info
  *	@id: id of the port in question
@@ -2539,7 +2547,7 @@ static unsigned int atapi_xlat(struct at
 	}
 
 	qc->tf.command = ATA_CMD_PACKET;
-	qc->nbytes = scsi_bufflen(scmd) + scmd->request->extra_len;
+	ata_qc_set_pc_nbytes(qc);
 
 	/* check whether ATAPI DMA is safe */
 	if (!using_pio && ata_check_atapi_dma(qc))
@@ -2550,7 +2558,7 @@ static unsigned int atapi_xlat(struct at
 	 * want to set it properly, and for DMA where it is
 	 * effectively meaningless.
 	 */
-	nbytes = min(scmd->request->data_len, (unsigned int)63 * 1024);
+	nbytes = min(ata_qc_raw_nbytes(qc), (unsigned int)63 * 1024);
 
 	/* Most ATAPI devices which honor transfer chunk size don't
 	 * behave according to the spec when odd chunk size which
@@ -2876,7 +2884,7 @@ static unsigned int ata_scsi_pass_thru(s
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
-	qc->nbytes = scsi_bufflen(scmd) + scmd->request->extra_len;
+	ata_qc_set_pc_nbytes(qc);
 
 	/* request result TF and be quiet about device error */
 	qc->flags |= ATA_QCFLAG_RESULT_TF | ATA_QCFLAG_QUIET;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -463,6 +463,7 @@ struct ata_queued_cmd {
 	unsigned int		sect_size;
 
 	unsigned int		nbytes;
+	unsigned int		extrabytes;
 	unsigned int		curbytes;
 
 	struct scatterlist	*cursg;
@@ -1336,6 +1337,11 @@ static inline struct ata_queued_cmd *ata
 	return NULL;
 }
 
+static inline unsigned int ata_qc_raw_nbytes(struct ata_queued_cmd *qc)
+{
+	return qc->nbytes - min(qc->extrabytes, qc->nbytes);
+}
+
 static inline void ata_tf_init(struct ata_device *dev, struct ata_taskfile *tf)
 {
 	memset(tf, 0, sizeof(*tf));
@@ -1354,7 +1360,7 @@ static inline void ata_qc_reinit(struct 
 	qc->flags = 0;
 	qc->cursg = NULL;
 	qc->cursg_ofs = 0;
-	qc->nbytes = qc->curbytes = 0;
+	qc->nbytes = qc->extrabytes = qc->curbytes = 0;
 	qc->n_elem = 0;
 	qc->err_mask = 0;
 	qc->sect_size = ATA_SECT_SIZE;
