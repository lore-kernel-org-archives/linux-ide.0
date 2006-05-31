From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/13] libata-hp: implement SCSI part of hotplug
Date: Wed, 31 May 2006 20:25:44 +0900
Message-ID: <11490747442153-git-send-email-htejun@gmail.com>
References: <11490747443727-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:52880 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964975AbWEaLZx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:25:53 -0400
Received: by wx-out-0102.google.com with SMTP id h27so5387wxd
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:25:52 -0700 (PDT)
In-Reply-To: <11490747443727-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement SCSI part of hotplug.

This must be done in a separate context as SCSI makes use of EH during
probing.  SCSI scan fails silently if EH is in progress.  In such
cases, libata pauses briefly and retries until every device is
attached.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 
 drivers/scsi/libata-eh.c   |    6 ++
 drivers/scsi/libata-scsi.c |  116 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    1 
 include/linux/libata.h     |    2 -
 5 files changed, 124 insertions(+), 2 deletions(-)

580b2102327ab8444af5bde4e70b50d268a1d558
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c965eea..8df8ecc 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5370,6 +5370,7 @@ static void ata_host_init(struct ata_por
 	ap->msg_enable = ATA_MSG_DRV;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
+	INIT_WORK(&ap->hotplug_task, ata_scsi_hotplug, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index b53e2e7..733dfa5 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -287,9 +287,13 @@ void ata_scsi_error(struct Scsi_Host *ho
 	/* clean up */
 	spin_lock_irqsave(hs_lock, flags);
 
+	if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
+		queue_work(ata_aux_wq, &ap->hotplug_task);
+
 	if (ap->flags & ATA_FLAG_RECOVERED)
 		ata_port_printk(ap, KERN_INFO, "EH complete\n");
-	ap->flags &= ~ATA_FLAG_RECOVERED;
+
+	ap->flags &= ~(ATA_FLAG_SCSI_HOTPLUG | ATA_FLAG_RECOVERED);
 
 	/* tell wait_eh that we're done */
 	ap->flags &= ~ATA_FLAG_EH_IN_PROGRESS;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 3dc6188..1256399 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2786,3 +2786,119 @@ int ata_scsi_offline_dev(struct ata_devi
 	}
 	return 0;
 }
+
+/**
+ *	ata_scsi_remove_dev - remove attached SCSI device
+ *	@dev: ATA device to remove attached SCSI device for
+ *
+ *	This function is called from ata_eh_scsi_hotplug() and
+ *	responsible for removing the SCSI device attached to @dev.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+static void ata_scsi_remove_dev(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->ap;
+	struct scsi_device *sdev;
+	unsigned long flags;
+
+	/* Alas, we need to grab scan_mutex to ensure SCSI device
+	 * state doesn't change underneath us and thus
+	 * scsi_device_get() always succeeds.  The mutex locking can
+	 * be removed if there is __scsi_device_get() interface which
+	 * increments reference counts regardless of device state.
+	 */
+	mutex_lock(&ap->host->scan_mutex);
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	/* clearing dev->sdev is protected by host_set lock */
+	sdev = dev->sdev;
+	dev->sdev = NULL;
+
+	if (sdev) {
+		/* If user initiated unplug races with us, sdev can go
+		 * away underneath us after the host_set lock and
+		 * scan_mutex are released.  Hold onto it.
+		 */
+		if (scsi_device_get(sdev) == 0) {
+			/* The following ensures the attached sdev is
+			 * offline on return from ata_scsi_offline_dev()
+			 * regardless it wins or loses the race
+			 * against this function.
+			 */
+			scsi_device_set_state(sdev, SDEV_OFFLINE);
+		} else {
+			WARN_ON(1);
+			sdev = NULL;
+		}
+	}
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	mutex_unlock(&ap->host->scan_mutex);
+
+	if (sdev) {
+		ata_dev_printk(dev, KERN_INFO, "detaching (SCSI %s)\n",
+			       sdev->sdev_gendev.bus_id);
+
+		scsi_remove_device(sdev);
+		scsi_device_put(sdev);
+	}
+}
+
+/**
+ *	ata_scsi_hotplug - SCSI part of hotplug
+ *	@data: Pointer to ATA port to perform SCSI hotplug on
+ *
+ *	Perform SCSI part of hotplug.  It's executed from a separate
+ *	workqueue after EH completes.  This is necessary because SCSI
+ *	hot plugging requires working EH and hot unplugging is
+ *	synchronized with hot plugging with a mutex.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_scsi_hotplug(void *data)
+{
+	struct ata_port *ap = data;
+	int i;
+
+	if (ap->flags & ATA_FLAG_UNLOADING) {
+		DPRINTK("ENTER/EXIT - unloading\n");
+		return;
+	}
+
+	DPRINTK("ENTER\n");
+
+	/* unplug detached devices */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		unsigned long flags;
+
+		if (!(dev->flags & ATA_DFLAG_DETACHED))
+			continue;
+
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		dev->flags &= ~ATA_DFLAG_DETACHED;
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		ata_scsi_remove_dev(dev);
+	}
+
+	/* scan for new ones */
+	ata_scsi_scan_host(ap);
+
+	/* If we scanned while EH was in progress, scan would have
+	 * failed silently.  Requeue if there are enabled but
+	 * unattached devices.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		if (ata_dev_enabled(dev) && !dev->sdev) {
+			queue_delayed_work(ata_aux_wq, &ap->hotplug_task, HZ);
+			break;
+		}
+	}
+
+	DPRINTK("EXIT\n");
+}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e38759f..0586b0c 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -76,6 +76,7 @@ extern struct scsi_transport_template at
 
 extern void ata_scsi_scan_host(struct ata_port *ap);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
+extern void ata_scsi_hotplug(void *data);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5697194..4071156 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -521,7 +521,7 @@ struct ata_port {
 	struct ata_host_set	*host_set;
 	struct device 		*dev;
 
-	struct work_struct	port_task;
+	struct work_struct	port_task, hotplug_task;
 
 	unsigned int		hsm_task_state;
 
-- 
1.3.2


