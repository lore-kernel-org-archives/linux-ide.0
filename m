From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH v4] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Fri, 02 Jun 2006 16:49:45 +0800
Message-ID: <1149238185.13451.86.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4363 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751342AbWFBJB3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 05:01:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, htejun@gmail.com, liml@rtr.ca, ric@emc.com
Cc: linux-ide@vger.kernel.org

Hi, Tejun

Sorry, my brain turned dull after one-day work......
I should have fixed that in take 3.

Thanks,
Forrest

Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>


diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 11df827..7efe991 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -69,6 +69,8 @@ static void ata_dev_xfermask(struct ata_
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+struct workqueue_struct *ata_aux_wq;
+
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices
(0=off, 1=on)");
@@ -5188,6 +5190,8 @@ static void ata_host_init(struct ata_por
 	ap->msg_enable = ATA_MSG_DRV;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
+	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan, ap);
+
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
 	/* set cable type */
@@ -5593,6 +5597,12 @@ static int __init ata_init(void)
 	if (!ata_wq)
 		return -ENOMEM;
 
+	ata_aux_wq = create_singlethread_workqueue("ata_aux");
+	if (!ata_aux_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 }
@@ -5600,6 +5610,8 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_aux_wq);
+
 }
 
 module_init(ata_init);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 71b45ad..0622ad5 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1356,6 +1356,8 @@ static int ata_eh_revalidate(struct ata_
 			if (rc)
 				break;
 
+			/* schedule the scsi_rescan_device() here */
+			queue_work(ata_scsi_wq, &(ap->scsi_rescan_task));
 			ehc->i.action &= ~ATA_EH_REVALIDATE;
 		}
 	}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 9e5cb9f..4e86807 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1269,6 +1269,17 @@ static void ata_scsi_qc_complete(struct 
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (qc->err_mask != 0);
 
+	/* We snoop the SET_FEATURES - Write Cache ON/OFF command, and
+	 * schedule EH_REVALIDATE operation to update the IDENTIFY DEVICE
+	 * cache
+	 */
+	if (!need_sense && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
+	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
+	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
+		qc->ap->eh_info.action |= ATA_EH_REVALIDATE;
+		ata_port_schedule_eh(qc->ap);
+	}
+
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
 	 * generate because the user forced us to, a check condition
@@ -2744,9 +2755,31 @@ void ata_scsi_scan_host(struct ata_port 
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
+
 		dev = &ap->device[i];
 
 		if (ata_dev_enabled(dev))
-			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
+			scsi_rescan_device(&(dev->sdev->sdev_gendev));
 	}
 }
+
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index b76ad7d..f4482fd 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,6 +39,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
@@ -99,6 +100,7 @@ extern void ata_scsi_rbuf_fill(struct at
                         unsigned int (*actor) (struct ata_scsi_args
*args,
                                            u8 *rbuf, unsigned int
buflen));
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
+extern void ata_scsi_dev_rescan(void *data);
 
 /* libata-eh.c */
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd
*cmd);
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
index b0ee1c1..9cccb22 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -402,6 +402,7 @@ struct ata_device {
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
+	struct scsi_device	*sdev;		/* attached SCSI device */
 	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
@@ -484,7 +485,7 @@ struct ata_port {
 	struct ata_host_set	*host_set;
 	struct device 		*dev;
 
-	struct work_struct	port_task;
+	struct work_struct	port_task, scsi_rescan_task;
 
 	unsigned int		hsm_task_state;
 
