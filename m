From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Thu, 25 May 2006 17:02:43 +0800
Message-ID: <1148547763.23979.15.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34577 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965093AbWEYJOH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 May 2006 05:14:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, htejun@gmail.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Hi, all

This patch makes libata "Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE
command" and clean the things up(e.g. revalidate and rescan). 

Here is the processing path:

1 in ata_scsi_qc_complete(), if we find that a "SET FEATURES - WRITE CACHE
ENABLE/DISABLE" command is executed successfully, we schedule the according
port to do revalidation
2 in ata_dev_revalidate(), if we find that the "write cahce enable bit" was
changed, set port flags in order to schedule scsi_rescan_device() later in
ata_scsi_error()
3 in ata_scsi_error(), if ATA_FLAG_SCSI_RESCAN is set for ap->flags, we
queue the ata_scsi_dev_rescan() to work_queue "ata_scsi_wq"
4 at last, scsi_rescan_device() is invoked, so the current state of "write
cahce enable bit" is propogated to SCSI layer.

The patch is against the curretn #upstream. Your comments are welcome.

Thanks,
Forrest

Signed-off-by: Zhao, Forrest <forrest.zhao@intel.com>


---

 drivers/scsi/libata-core.c |   17 +++++++++++++++++
 drivers/scsi/libata-eh.c   |    5 ++++-
 drivers/scsi/libata-scsi.c |   35 ++++++++++++++++++++++++++++++++++-
 drivers/scsi/libata.h      |    2 ++
 include/linux/ata.h        |    3 +++
 include/linux/libata.h     |    4 +++-
 6 files changed, 63 insertions(+), 3 deletions(-)

bc7324f8b2629241df4120743618d5454ea1834a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 074a46e..889a15e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -69,6 +69,8 @@ static void ata_dev_xfermask(struct ata_
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+struct workqueue_struct *ata_scsi_wq;
+
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
@@ -2911,6 +2913,13 @@ int ata_dev_revalidate(struct ata_device
 		goto fail;
 	}
 
+	/* if the write cahce enable bit is changed, set port flags
+	 * in order to schedule scsi_rescan_device() later in
+	 * ata_scsi_error()
+	 */
+	if ((dev->id[85] & (1 << 5)) != (id[85] & (1 << 5)))
+		dev->ap->flags |= ATA_FLAG_SCSI_RESCAN;
+
 	memcpy(dev->id, id, sizeof(id[0]) * ATA_ID_WORDS);
 
 	/* configure device according to the new ID */
@@ -5160,6 +5169,7 @@ static void ata_host_init(struct ata_por
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
+	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
 	/* set cable type */
@@ -5565,6 +5575,12 @@ static int __init ata_init(void)
 	if (!ata_wq)
 		return -ENOMEM;
 
+	ata_scsi_wq = create_singlethread_workqueue("ata_scsi");
+	if (!ata_scsi_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 }
@@ -5572,6 +5588,7 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_scsi_wq);
 }
 
 module_init(ata_init);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 71b45ad..241aa49 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -286,9 +286,12 @@ void ata_scsi_error(struct Scsi_Host *ho
 	/* clean up */
 	spin_lock_irqsave(hs_lock, flags);
 
+	if (ap->flags & ATA_FLAG_SCSI_RESCAN)
+		queue_work(ata_scsi_wq, &ap->scsi_rescan_task);
+
 	if (ap->flags & ATA_FLAG_RECOVERED)
 		ata_port_printk(ap, KERN_INFO, "EH complete\n");
-	ap->flags &= ~ATA_FLAG_RECOVERED;
+	ap->flags &= ~(ATA_FLAG_RECOVERED | ATA_FLAG_SCSI_RESCAN);
 
 	spin_unlock_irqrestore(hs_lock, flags);
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 9e5cb9f..c49b9bd 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1269,6 +1269,18 @@ static void ata_scsi_qc_complete(struct 
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (qc->err_mask != 0);
 
+	/* We snoop the SET_FEATURES - Write Cache ON/OFF command, and
+	 * schedule EH_REVALIDATE operation to update the IDENTIFY DEVICE
+	 * cache
+	 */
+	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
+	    (!(cdb[2] & 0x20)) && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
+	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
+	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
+		qc->ap->eh_info.action = ATA_EH_REVALIDATE;
+		ata_port_schedule_eh(qc->ap);
+	}
+
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
 	 * generate because the user forced us to, a check condition
@@ -2744,9 +2756,30 @@ void ata_scsi_scan_host(struct ata_port 
 		return;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct scsi_device *sdev;
+		dev = &ap->device[i];
+
+		if (!ata_dev_enabled(dev) || dev->sdev)
+			continue;
+		sdev = __scsi_add_device(ap->host, 0, i, 0, NULL);
+		if(!IS_ERR(sdev)){
+			dev->sdev = sdev;
+			scsi_device_put(sdev);
+		}
+	}
+}
+
+void ata_scsi_dev_rescan(void *data)
+{
+	struct ata_port *ap = data;
+	struct ata_device *dev;
+	unsigned int i;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
 
 		if (ata_dev_enabled(dev))
-			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
+			scsi_rescan_device(&(dev->sdev->sdev_gendev));
 	}
 }
+
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index b76ad7d..352d332 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,6 +39,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern struct workqueue_struct *ata_scsi_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
@@ -99,6 +100,7 @@ extern void ata_scsi_rbuf_fill(struct at
                         unsigned int (*actor) (struct ata_scsi_args *args,
                                            u8 *rbuf, unsigned int buflen));
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
+extern void ata_scsi_dev_rescan(void *data);
 
 /* libata-eh.c */
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
diff --git a/include/linux/ata.h b/include/linux/ata.h
index c494e1c..3671af8 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -181,6 +181,9 @@ enum {
 	XFER_PIO_0		= 0x08,
 	XFER_PIO_SLOW		= 0x00,
 
+	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
+	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9c60b4a..687564d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -159,6 +159,7 @@ enum {
 	ATA_FLAG_EH_PENDING	= (1 << 16), /* EH pending */
 	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
 	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
+	ATA_FLAG_SCSI_RESCAN	= (1 << 19), /* scsi device rescan is scheduled */
 
 	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
@@ -402,6 +403,7 @@ struct ata_device {
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
+	struct scsi_device	*sdev;		/* attached SCSI device */
 	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
@@ -484,7 +486,7 @@ struct ata_port {
 	struct ata_host_set	*host_set;
 	struct device 		*dev;
 
-	struct work_struct	port_task;
+	struct work_struct	port_task, scsi_rescan_task;
 
 	unsigned int		hsm_task_state;
 
-- 
1.2.6

