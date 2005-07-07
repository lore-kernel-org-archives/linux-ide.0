From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 09/11] libata: remove unused functions
Date: Thu,  7 Jul 2005 22:09:59 +0900 (KST)
Message-ID: <20050707130840.3B41F658@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:45679 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261491AbVGGNKI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:10:08 -0400
Received: by wproxy.gmail.com with SMTP id i30so188607wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:10:04 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

09_libata_remove-unused-eh-functions.patch

	This patch removes ata_scsi_requeue(),
	ata_scsi_block_requests() and ata_scsi_unblock_requests().

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |    3 ---
 drivers/scsi/libata-scsi.c |   32 --------------------------------
 include/linux/libata.h     |    3 ---
 3 files changed, 38 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-07-07 22:08:36.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-07-07 22:08:37.000000000 +0900
@@ -4947,9 +4947,6 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(ata_scsi_block_requests);
-EXPORT_SYMBOL_GPL(ata_scsi_unblock_requests);
-EXPORT_SYMBOL_GPL(ata_scsi_requeue);
 EXPORT_SYMBOL_GPL(ata_read_log_page);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-07-07 22:08:36.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-07-07 22:08:37.000000000 +0900
@@ -421,38 +421,6 @@ int ata_scsi_change_queue_depth(struct s
 	return queue_depth;
 }
 
-void ata_scsi_requeue(struct ata_queued_cmd *qc)
-{
-	struct scsi_cmnd *scmd = qc->scsicmd;
-
-	if (scmd) {
-		request_queue_t *q = scmd->device->request_queue;
-
-		scmd->request->flags &= ~REQ_DONTPREP;
-		scsi_delete_timer(scmd);
-		blk_requeue_request(q, scmd->request);
-
-		ata_qc_free(qc);
-	} else
-		ata_qc_complete(qc);
-}
-
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
--- work.orig/include/linux/libata.h	2005-07-07 22:08:36.000000000 +0900
+++ work/include/linux/libata.h	2005-07-07 22:08:37.000000000 +0900
@@ -456,9 +456,6 @@ extern int ata_std_bios_param(struct scs
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *, int);
-extern void ata_scsi_block_requests(struct ata_port *);
-extern void ata_scsi_unblock_requests(struct ata_port *);
-extern void ata_scsi_requeue(struct ata_queued_cmd *);
 extern int ata_read_log_page(struct ata_port *, unsigned int, char, char *,
 			     unsigned int);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);

