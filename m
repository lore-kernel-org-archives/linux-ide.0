From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/17] libata-link: update hotplug to handle PMP links
Date: Sat, 8 Jul 2006 14:45:38 +0900
Message-ID: <11523375383786-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:47471 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964775AbWGHFox (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:53 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484132wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:53 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update hotplug to handle PMP links.  When PMP is attached, the PMP
number corresponds to I of SCSI C:H:I:L.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    7 ++-
 drivers/scsi/libata-scsi.c |  109 +++++++++++++++++++++++++++++++-------------
 2 files changed, 81 insertions(+), 35 deletions(-)

ca948d6e6db6fa8c27ea7f8bd72ff276b9a7f774
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3604fce..4088498 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5694,6 +5694,7 @@ err_free_ret:
 void ata_port_detach(struct ata_port *ap)
 {
 	unsigned long flags;
+	struct ata_link *link;
 	struct ata_device *dev;
 
 	if (!ap->ops->error_handler)
@@ -5711,8 +5712,10 @@ void ata_port_detach(struct ata_port *ap
 	 */
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_link_for_each_dev(dev, &ap->link)
-		ata_dev_disable(dev);
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link)
+			ata_dev_disable(dev);
+	}
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 8c0229b..7e33506 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2466,8 +2466,14 @@ static unsigned int atapi_xlat(struct at
 
 static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
 {
-	if (likely(id < ata_link_max_devices(&ap->link)))
-		return &ap->link.device[id];
+	if (ap->nr_pmp_links == 0) {
+		if (likely(id < ata_link_max_devices(&ap->link)))
+			return &ap->link.device[id];
+	} else {
+		if (likely(id < ap->nr_pmp_links))
+			return &ap->pmp_link[id].device[0];
+	}
+
 	return NULL;
 }
 
@@ -2920,21 +2926,30 @@ void ata_scsi_simulate(struct ata_device
 
 void ata_scsi_scan_host(struct ata_port *ap)
 {
+	struct ata_link *link;
 	struct ata_device *dev;
 
 	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 
-	ata_link_for_each_dev(dev, &ap->link) {
-		struct scsi_device *sdev;
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link) {
+			struct scsi_device *sdev;
+			int devno;
 
-		if (!ata_dev_enabled(dev) || dev->sdev)
-			continue;
+			if (!ata_dev_enabled(dev) || dev->sdev)
+				continue;
+
+			if (ata_is_host_link(link))
+				devno = dev->devno;
+			else
+				devno = link->pmp;
 
-		sdev = __scsi_add_device(ap->host, 0, dev->devno, 0, NULL);
-		if (!IS_ERR(sdev)) {
-			dev->sdev = sdev;
-			scsi_device_put(sdev);
+			sdev = __scsi_add_device(ap->host, 0, devno, 0, NULL);
+			if (!IS_ERR(sdev)) {
+				dev->sdev = sdev;
+				scsi_device_put(sdev);
+			}
 		}
 	}
 }
@@ -3022,6 +3037,25 @@ static void ata_scsi_remove_dev(struct a
 	}
 }
 
+static void ata_scsi_handle_link_detach(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_device *dev;
+
+	ata_link_for_each_dev(dev, link) {
+		unsigned long flags;
+
+		if (!(dev->flags & ATA_DFLAG_DETACHED))
+			continue;
+
+		spin_lock_irqsave(ap->lock, flags);
+		dev->flags &= ~ATA_DFLAG_DETACHED;
+		spin_unlock_irqrestore(ap->lock, flags);
+
+		ata_scsi_remove_dev(dev);
+	}
+}
+
 /**
  *	ata_scsi_hotplug - SCSI part of hotplug
  *	@data: Pointer to ATA port to perform SCSI hotplug on
@@ -3037,7 +3071,9 @@ static void ata_scsi_remove_dev(struct a
 void ata_scsi_hotplug(void *data)
 {
 	struct ata_port *ap = data;
+	struct ata_link *link;
 	struct ata_device *dev;
+	int i;
 
 	if (ap->pflags & ATA_PFLAG_UNLOADING) {
 		DPRINTK("ENTER/EXIT - unloading\n");
@@ -3046,19 +3082,14 @@ void ata_scsi_hotplug(void *data)
 
 	DPRINTK("ENTER\n");
 
-	/* unplug detached devices */
-	ata_link_for_each_dev(dev, &ap->link) {
-		unsigned long flags;
-
-		if (!(dev->flags & ATA_DFLAG_DETACHED))
-			continue;
-
-		spin_lock_irqsave(ap->lock, flags);
-		dev->flags &= ~ATA_DFLAG_DETACHED;
-		spin_unlock_irqrestore(ap->lock, flags);
-
-		ata_scsi_remove_dev(dev);
-	}
+	/* Unplug detached devices.  We cannot use link iterator here
+	 * because PMP links have to be scanned even if PMP is
+	 * currently not attached.  Iterate manually.
+	 */
+	ata_scsi_handle_link_detach(&ap->link);
+	if (ap->pmp_link)
+		for (i = 0; i < SATA_PMP_MAX_PORTS; i++)
+			ata_scsi_handle_link_detach(&ap->pmp_link[i]);
 
 	/* scan for new ones */
 	ata_scsi_scan_host(ap);
@@ -3067,12 +3098,16 @@ void ata_scsi_hotplug(void *data)
 	 * failed silently.  Requeue if there are enabled but
 	 * unattached devices.
 	 */
-	ata_link_for_each_dev(dev, &ap->link) {
-		if (ata_dev_enabled(dev) && !dev->sdev) {
-			queue_delayed_work(ata_aux_wq, &ap->hotplug_task, HZ);
-			break;
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link) {
+			if (ata_dev_enabled(dev) && !dev->sdev) {
+				queue_delayed_work(ata_aux_wq,
+						   &ap->hotplug_task, HZ);
+				goto exit_loop;
+			}
 		}
 	}
+ exit_loop:
 
 	DPRINTK("EXIT\n");
 }
@@ -3097,7 +3132,6 @@ static int ata_scsi_user_scan(struct Scs
 			      unsigned int id, unsigned int lun)
 {
 	struct ata_port *ap = ata_shost_to_port(shost);
-	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned long flags;
 	int rc = 0;
 
@@ -3111,12 +3145,18 @@ static int ata_scsi_user_scan(struct Scs
 	spin_lock_irqsave(ap->lock, flags);
 
 	if (id == SCAN_WILD_CARD) {
-		ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
-		ehi->action |= ATA_EH_SOFTRESET;
+		struct ata_link *link;
+
+		ata_port_for_each_link(link, ap) {
+			struct ata_eh_info *ehi = &link->eh_info;
+			ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
+			ehi->action |= ATA_EH_SOFTRESET;
+		}
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, id);
 
 		if (dev) {
+			struct ata_eh_info *ehi = &dev->link->eh_info;
 			ehi->probe_mask |= 1 << dev->devno;
 			ehi->action |= ATA_EH_SOFTRESET;
 			ehi->flags |= ATA_EHI_RESUME_LINK;
@@ -3147,10 +3187,13 @@ static int ata_scsi_user_scan(struct Scs
 void ata_scsi_dev_rescan(void *data)
 {
 	struct ata_port *ap = data;
+	struct ata_link *link;
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, &ap->link) {
-		if (ata_dev_enabled(dev) && dev->sdev)
-			scsi_rescan_device(&(dev->sdev->sdev_gendev));
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link) {
+			if (ata_dev_enabled(dev) && dev->sdev)
+				scsi_rescan_device(&(dev->sdev->sdev_gendev));
+		}
 	}
 }
-- 
1.3.2


