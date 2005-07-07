From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 05/11] libata: add drv_err argument to ata_to_sense_error()
Date: Thu,  7 Jul 2005 22:09:38 +0900 (KST)
Message-ID: <20050707130840.D5F1DDD5@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:17000 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261482AbVGGNJu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:09:50 -0400
Received: by wproxy.gmail.com with SMTP id i6so201609wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:09:48 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

05_libata_add-drv_err-to-ata_to_sense_error.patch

	During NCQ error handling, drv_stat and drv_err values are
	obtained from log page 10h.  This patch adds drv_err argument
	to ata_to_sense_error() such that it can be used with values
	obtained from log page 10h.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 libata-core.c |   10 ++++++----
 libata-scsi.c |   36 +++++++++++++++++-------------------
 libata.h      |    2 +-
 3 files changed, 24 insertions(+), 24 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-07-07 22:08:36.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-07-07 22:08:36.000000000 +0900
@@ -3003,7 +3003,7 @@ static void atapi_request_sense(struct a
 void ata_error_handler(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
-	u8 host_stat = 0, drv_stat;
+	u8 host_stat = 0, drv_stat, drv_err;
 
 	DPRINTK("ENTER\n");
 
@@ -3014,9 +3014,10 @@ void ata_error_handler(struct ata_port *
 		goto out;
 	}
 
-	if (qc->flags & ATA_QCFLAG_ERROR)
+	if (qc->flags & ATA_QCFLAG_ERROR) {
 		drv_stat = ata_chk_status(ap);
-	else {
+		drv_err = ata_chk_err(ap);
+	} else {
 		/*
 		 * Okay, command has timed out.  Currently all we do
 		 * is stopping the dma engine.  Maybe performing
@@ -3038,6 +3039,7 @@ void ata_error_handler(struct ata_port *
 		default:
 			ata_altstatus(ap);
 			drv_stat = ata_chk_status(ap);
+			drv_err = ata_chk_err(ap);
 
 			/* ack bmdma irq events */
 			ap->ops->irq_clear(ap);
@@ -3051,7 +3053,7 @@ void ata_error_handler(struct ata_port *
 	if (qc->scsicmd) {
 		if (qc->dev->class == ATA_DEV_ATA ||
 		    !(qc->flags & ATA_QCFLAG_ERROR))
-			ata_to_sense_error(qc, drv_stat);
+			ata_to_sense_error(qc, drv_stat, drv_err);
 		else
 			atapi_request_sense(ap, qc->dev, qc->scsicmd);
 	}
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-07-07 22:08:36.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-07-07 22:08:36.000000000 +0900
@@ -192,6 +192,7 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@qc: Command that we are erroring out
  *	@drv_stat: value contained in ATA status register
+ *	@drv_err: value contained in ATA error register
  *
  *	Converts an ATA error into a SCSI error. While we are at it
  *	we decode and dump the ATA error for the user so that they
@@ -202,10 +203,9 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat, u8 drv_err)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
-	u8 err = 0;
 	unsigned char *sb = cmd->sense_buffer;
 	/* Based on the 3ware driver translation table */
 	static unsigned char sense_table[][4] = {
@@ -254,10 +254,8 @@ void ata_to_sense_error(struct ata_queue
 	/*
 	 *	Is this an error we can process/parse
 	 */
-
-	if(drv_stat & ATA_ERR)
-		/* Read the err bits */
-		err = ata_chk_err(qc->ap);
+	if(!(drv_stat & ATA_ERR))
+		drv_err = 0;
 
 	/* Display the ATA level error info */
 
@@ -265,7 +263,7 @@ void ata_to_sense_error(struct ata_queue
 	if(drv_stat & 0x80)
 	{
 		printk("Busy ");
-		err = 0;	/* Data is not valid in this case */
+		drv_err = 0;	/* Data is not valid in this case */
 	}
 	else {
 		if(drv_stat & 0x40)	printk("DriveReady ");
@@ -278,21 +276,21 @@ void ata_to_sense_error(struct ata_queue
 	}
 	printk("}\n");
 
-	if(err)
+	if(drv_err)
 	{
-		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
-		if(err & 0x04)		printk("DriveStatusError ");
-		if(err & 0x80)
+		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, drv_err);
+		if(drv_err & 0x04)	printk("DriveStatusError ");
+		if(drv_err & 0x80)
 		{
-			if(err & 0x04)
+			if(drv_err & 0x04)
 				printk("BadCRC ");
 			else
 				printk("Sector ");
 		}
-		if(err & 0x40)		printk("UncorrectableError ");
-		if(err & 0x10)		printk("SectorIdNotFound ");
-		if(err & 0x02)		printk("TrackZeroNotFound ");
-		if(err & 0x01)		printk("AddrMarkNotFound ");
+		if(drv_err & 0x40)	printk("UncorrectableError ");
+		if(drv_err & 0x10)	printk("SectorIdNotFound ");
+		if(drv_err & 0x02)	printk("TrackZeroNotFound ");
+		if(drv_err & 0x01)	printk("AddrMarkNotFound ");
 		printk("}\n");
 
 		/* Should we dump sector info here too ?? */
@@ -303,7 +301,7 @@ void ata_to_sense_error(struct ata_queue
 	while(sense_table[i][0] != 0xFF)
 	{
 		/* Look for best matches first */
-		if((sense_table[i][0] & err) == sense_table[i][0])
+		if((sense_table[i][0] & drv_err) == sense_table[i][0])
 		{
 			sb[0] = 0x70;
 			sb[2] = sense_table[i][1];
@@ -315,8 +313,8 @@ void ata_to_sense_error(struct ata_queue
 		i++;
 	}
 	/* No immediate match */
-	if(err)
-		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
+	if(drv_err)
+		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, drv_err);
 
 	i = 0;
 	/* Fall back to interpreting status bits */
Index: work/drivers/scsi/libata.h
===================================================================
--- work.orig/drivers/scsi/libata.h	2005-07-07 22:08:34.000000000 +0900
+++ work/drivers/scsi/libata.h	2005-07-07 22:08:36.000000000 +0900
@@ -47,7 +47,7 @@ extern void swap_buf_le16(u16 *buf, unsi
 
 
 /* libata-scsi.c */
-extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
+extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat, u8 drv_err);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);

