From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 08/09] NCQ: remove/unexport unused/unnecessary functions
Date: Mon, 27 Jun 2005 00:21:47 +0900 (KST)
Message-ID: <20050626152106.76B6F095@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:53534 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261323AbVFZPVw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:52 -0400
Received: by wproxy.gmail.com with SMTP id 57so220781wri
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:52 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

08_NCQ_remove-or-unexport-unused-functions.patch

	This patch removes ata_scsi_block_requests() and
	ata_scsi_unblock_requests(), and makes ata_read_log_page() and
	ata_to_sense_error() static.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |    8 +++-----
 drivers/scsi/libata-scsi.c |   19 ++-----------------
 drivers/scsi/libata.h      |    1 -
 include/linux/libata.h     |    4 ----
 4 files changed, 5 insertions(+), 27 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-27 00:20:30.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-27 00:20:32.000000000 +0900
@@ -1334,8 +1334,9 @@ static void ata_read_log_page_timeout(un
  *	Grabs host_set lock.
  */
 
-int ata_read_log_page(struct ata_port *ap, unsigned int device, char page,
-		      char *buffer, unsigned int sectors, unsigned int timeout)
+static int ata_read_log_page(struct ata_port *ap, unsigned int device,
+			     char page, char *buffer, unsigned int sectors,
+			     unsigned int timeout)
 {
 	struct ata_device *dev = &ap->device[device];
 	DECLARE_COMPLETION(wait);
@@ -4862,10 +4863,7 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(ata_scsi_block_requests);
-EXPORT_SYMBOL_GPL(ata_scsi_unblock_requests);
 EXPORT_SYMBOL_GPL(ata_scsi_requeue);
-EXPORT_SYMBOL_GPL(ata_read_log_page);
 EXPORT_SYMBOL_GPL(ata_ncq_complete);
 EXPORT_SYMBOL_GPL(ata_ncq_abort);
 EXPORT_SYMBOL_GPL(ata_ncq_recover);
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-06-27 00:20:30.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-06-27 00:20:32.000000000 +0900
@@ -204,7 +204,8 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_to_sense_error(struct scsi_cmnd *cmd, int apid, u8 drv_stat, u8 drv_err)
+static void ata_to_sense_error(struct scsi_cmnd *cmd, int apid,
+			       u8 drv_stat, u8 drv_err)
 {
 	unsigned char *sb = cmd->sense_buffer;
 	/* Based on the 3ware driver translation table */
@@ -445,22 +446,6 @@ void ata_scsi_requeue(struct ata_queued_
 		ata_qc_complete(qc, ATA_ERR);
 }
 
-void ata_scsi_block_requests(struct ata_port *ap)
-{
-	struct Scsi_Host *host = ap->host;
-
-	scsi_block_requests(host);
-}
-
-void ata_scsi_unblock_requests(struct ata_port *ap)
-{
-	struct Scsi_Host *host = ap->host;
-
-	scsi_unblock_requests(host);
-}
-
-
-
 /**
  *	ata_scsi_error - SCSI layer error handler callback
  *	@host: SCSI host on which error occurred
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-06-27 00:20:30.000000000 +0900
+++ work/include/linux/libata.h	2005-06-27 00:20:32.000000000 +0900
@@ -453,11 +453,7 @@ extern int ata_std_bios_param(struct scs
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *, int);
-extern void ata_scsi_block_requests(struct ata_port *);
-extern void ata_scsi_unblock_requests(struct ata_port *);
 extern void ata_scsi_requeue(struct ata_queued_cmd *);
-extern int ata_read_log_page(struct ata_port *, unsigned int, char, char *,
-			     unsigned int, unsigned int);
 extern int ata_ncq_complete(struct ata_port *);
 extern int ata_ncq_abort(struct ata_port *);
 extern void ata_ncq_recover(struct ata_port *, int);
Index: work/drivers/scsi/libata.h
===================================================================
--- work.orig/drivers/scsi/libata.h	2005-06-27 00:20:30.000000000 +0900
+++ work/drivers/scsi/libata.h	2005-06-27 00:20:32.000000000 +0900
@@ -51,7 +51,6 @@ extern void swap_buf_le16(u16 *buf, unsi
 
 
 /* libata-scsi.c */
-extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);

