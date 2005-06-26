From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 01/09] NCQ: add ata_qc_complete_err() and @drv_err to functions
Date: Mon, 27 Jun 2005 00:21:12 +0900 (KST)
Message-ID: <20050626152105.F111F420@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:64339 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261308AbVFZPVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:18 -0400
Received: by zproxy.gmail.com with SMTP id o1so109903nzf
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:18 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

01_NCQ_add-ata_qc_complete_err.patch

	In the error path, the error register is read in the later
	stage during sense buffer construction.  However, w/ NCQ, we
	need to get the error register value from the log page and use
	it for sense buffer construction.  This patch adds
	ata_qc_complete_err() and adds @drv_err to functions in the
	error path.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |   35 +++++++++++++++++++++++----
 drivers/scsi/libata-scsi.c |   57 +++++++++++++++++++++++++--------------------
 include/linux/libata.h     |    3 +-
 3 files changed, 64 insertions(+), 31 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-27 00:20:28.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-27 00:20:29.000000000 +0900
@@ -63,7 +63,8 @@ static struct ata_queued_cmd *ata_qc_new
 					      struct ata_device *dev);
 static struct ata_queued_cmd *ata_eh_qc_new_init(struct ata_port *ap,
 						 struct ata_device *dev);
-static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
+static int ata_qc_complete_noop(struct ata_queued_cmd *qc,
+				u8 drv_stat, u8 drv_err);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
@@ -3100,7 +3101,8 @@ static struct ata_queued_cmd *ata_eh_qc_
 	return qc;
 }
 
-static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
+static int ata_qc_complete_noop(struct ata_queued_cmd *qc,
+				u8 drv_stat, u8 drv_err)
 {
 	return 0;
 }
@@ -3152,9 +3154,10 @@ void ata_qc_free(struct ata_queued_cmd *
 }
 
 /**
- *	ata_qc_complete - Complete an active ATA command
+ *	ata_qc_complete_err - Complete an active ATA command
  *	@qc: Command to complete
  *	@drv_stat: ATA Status register contents
+ *	@drv_err: ATA Error register contents
  *
  *	Indicate to the mid and upper layers that an ATA
  *	command has completed, with either an ok or not-ok status.
@@ -3164,7 +3167,7 @@ void ata_qc_free(struct ata_queued_cmd *
  *
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_qc_complete_err(struct ata_queued_cmd *qc, u8 drv_stat, u8 drv_err)
 {
 	int rc;
 
@@ -3175,7 +3178,7 @@ void ata_qc_complete(struct ata_queued_c
 		ata_sg_clean(qc);
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, drv_stat);
+	rc = qc->complete_fn(qc, drv_stat, drv_err);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3188,6 +3191,27 @@ void ata_qc_complete(struct ata_queued_c
 	VPRINTK("EXIT\n");
 }
 
+/**
+ *	ata_qc_complete - Complete an active ATA command
+ *	@qc: Command to complete
+ *	@drv_stat: ATA Status register contents
+ *
+ *	This function reads the Error register if necessary and call
+ *	ata_qc_complete_err().
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ */
+
+void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	u8 drv_err = 0;
+	if ((drv_stat & (ATA_ERR | ATA_BUSY)) == ATA_ERR)
+		drv_err = ata_chk_err(qc->ap);
+	ata_qc_complete_err(qc, drv_stat, drv_err);
+}
+
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -4579,6 +4603,7 @@ EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
+EXPORT_SYMBOL_GPL(ata_qc_complete_err);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-06-27 00:20:28.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-06-27 00:20:29.000000000 +0900
@@ -188,8 +188,10 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
- *	@qc: Command that we are erroring out
+ *	@cmd: SCSI command in question
+ *	@apid: ap->id of the port in question (for logging)
  *	@drv_stat: value contained in ATA status register
+ *	@drv_err: value contained in ATA error register
  *
  *	Converts an ATA error into a SCSI error. While we are at it
  *	we decode and dump the ATA error for the user so that they
@@ -200,10 +202,8 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_to_sense_error(struct scsi_cmnd *cmd, int apid, u8 drv_stat, u8 drv_err)
 {
-	struct scsi_cmnd *cmd = qc->scsicmd;
-	u8 err = 0;
 	unsigned char *sb = cmd->sense_buffer;
 	/* Based on the 3ware driver translation table */
 	static unsigned char sense_table[][4] = {
@@ -253,17 +253,23 @@ void ata_to_sense_error(struct ata_queue
 	 *	Is this an error we can process/parse
 	 */
 
-	if(drv_stat & ATA_ERR)
-		/* Read the err bits */
-		err = ata_chk_err(qc->ap);
+	if (drv_stat == 0xff && drv_err == 0xff) {
+		/* This is a request to invoke eh.  Returning
+		 * CHECK_CONDITION without actual sense data will make
+		 * SCSI midlayer invoke eh. */
+		return;
+	}
+
+	if(!(drv_stat & ATA_ERR))
+		drv_err = 0;
 
 	/* Display the ATA level error info */
 
-	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
+	printk(KERN_WARNING "ata%u: status=0x%02x { ", apid, drv_stat);
 	if(drv_stat & 0x80)
 	{
 		printk("Busy ");
-		err = 0;	/* Data is not valid in this case */
+		drv_err = 0;	/* Data is not valid in this case */
 	}
 	else {
 		if(drv_stat & 0x40)	printk("DriveReady ");
@@ -276,21 +282,21 @@ void ata_to_sense_error(struct ata_queue
 	}
 	printk("}\n");
 
-	if(err)
+	if(drv_err)
 	{
-		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
-		if(err & 0x04)		printk("DriveStatusError ");
-		if(err & 0x80)
+		printk(KERN_WARNING "ata%u: error=0x%02x { ", apid, drv_err);
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
@@ -301,7 +307,7 @@ void ata_to_sense_error(struct ata_queue
 	while(sense_table[i][0] != 0xFF)
 	{
 		/* Look for best matches first */
-		if((sense_table[i][0] & err) == sense_table[i][0])
+		if((sense_table[i][0] & drv_err) == sense_table[i][0])
 		{
 			sb[0] = 0x70;
 			sb[2] = sense_table[i][1];
@@ -313,8 +319,8 @@ void ata_to_sense_error(struct ata_queue
 		i++;
 	}
 	/* No immediate match */
-	if(err)
-		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
+	if(drv_err)
+		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", apid, drv_err);
 
 	i = 0;
 	/* Fall back to interpreting status bits */
@@ -332,7 +338,7 @@ void ata_to_sense_error(struct ata_queue
 		i++;
 	}
 	/* No error ?? */
-	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, drv_stat);
+	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", apid, drv_stat);
 	/* additional-sense-code[-qualifier] */
 
 	sb[0] = 0x70;
@@ -753,12 +759,13 @@ static unsigned int ata_scsi_rw_xlat(str
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static int ata_scsi_qc_complete(struct ata_queued_cmd *qc,
+				u8 drv_stat, u8 drv_err)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
-		ata_to_sense_error(qc, drv_stat);
+		ata_to_sense_error(cmd, qc->ap->id, drv_stat, drv_err);
 	else
 		cmd->result = SAM_STAT_GOOD;
 
@@ -1391,7 +1398,7 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat, u8 drv_err)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-06-27 00:20:28.000000000 +0900
+++ work/include/linux/libata.h	2005-06-27 00:20:29.000000000 +0900
@@ -180,7 +180,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat, u8 drv_err);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -439,6 +439,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_port *ap);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
+extern void ata_qc_complete_err(struct ata_queued_cmd *qc, u8 drv_stat, u8 drv_err);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,

