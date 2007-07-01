From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/16] libata-link: update hotplug to handle PMP links
Date: Sun, 1 Jul 2007 19:06:01 +0900
Message-ID: <11832843613281-git-send-email-htejun@gmail.com>
References: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:53081 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234AbXGAKGM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879713wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:11 -0700 (PDT)
In-Reply-To: <11832843581399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Update hotplug to handle PMP links.  When PMP is attached, the PMP
number corresponds to I of SCSI C:H:I:L.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    7 ++-
 drivers/ata/libata-scsi.c |  123 ++++++++++++++++++++++++++++++---------------
 2 files changed, 87 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7992f1a..ed6c5ed 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6529,6 +6529,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 void ata_port_detach(struct ata_port *ap)
 {
 	unsigned long flags;
+	struct ata_link *link;
 	struct ata_device *dev;
 
 	if (!ap->ops->error_handler)
@@ -6546,8 +6547,10 @@ void ata_port_detach(struct ata_port *ap)
 	 */
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_link_for_each_dev(dev, &ap->link)
-		ata_dev_disable(dev);
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link)
+			ata_dev_disable(dev);
+	}
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a5a62b9..f7a9dc8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2425,8 +2425,14 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
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
 
@@ -2951,22 +2957,32 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 {
 	int tries = 5;
 	struct ata_device *last_failed_dev = NULL;
+	struct ata_link *link;
 	struct ata_device *dev;
 
 	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 
  repeat:
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
 
-		sdev = __scsi_add_device(ap->scsi_host, 0, dev->devno, 0, NULL);
-		if (!IS_ERR(sdev)) {
-			dev->sdev = sdev;
-			scsi_device_put(sdev);
+			if (ata_is_host_link(link))
+				devno = dev->devno;
+			else
+				devno = link->pmp;
+
+			sdev = __scsi_add_device(ap->scsi_host, 0, devno, 0,
+						 NULL);
+			if (!IS_ERR(sdev)) {
+				dev->sdev = sdev;
+				scsi_device_put(sdev);
+			}
 		}
 	}
 
@@ -2974,11 +2990,14 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 	 * failure occurred, scan would have failed silently.  Check
 	 * whether all devices are attached.
 	 */
-	ata_link_for_each_dev(dev, &ap->link) {
-		if (ata_dev_enabled(dev) && !dev->sdev)
-			break;
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link) {
+			if (ata_dev_enabled(dev) && !dev->sdev)
+				goto exit_loop;
+		}
 	}
-	if (!dev)
+ exit_loop:
+	if (!link)
 		return;
 
 	/* we're missing some SCSI devices */
@@ -3092,6 +3111,25 @@ static void ata_scsi_remove_dev(struct ata_device *dev)
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
  *	@work: Pointer to ATA port to perform SCSI hotplug on
@@ -3108,7 +3146,7 @@ void ata_scsi_hotplug(struct work_struct *work)
 {
 	struct ata_port *ap =
 		container_of(work, struct ata_port, hotplug_task.work);
-	struct ata_device *dev;
+	int i;
 
 	if (ap->pflags & ATA_PFLAG_UNLOADING) {
 		DPRINTK("ENTER/EXIT - unloading\n");
@@ -3117,19 +3155,14 @@ void ata_scsi_hotplug(struct work_struct *work)
 
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
 	ata_scsi_scan_host(ap, 0);
@@ -3157,7 +3190,6 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, unsigned int lun)
 {
 	struct ata_port *ap = ata_shost_to_port(shost);
-	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned long flags;
 	int rc = 0;
 
@@ -3171,12 +3203,18 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 	spin_lock_irqsave(ap->lock, flags);
 
 	if (id == SCAN_WILD_CARD) {
-		ehi->probe_mask |= (1 << ata_link_max_devices(&ap->link)) - 1;
-		ehi->action |= ATA_EH_SOFTRESET;
+		struct ata_link *link;
+
+		ata_port_for_each_link(link, ap) {
+			struct ata_eh_info *ehi = &link->eh_info;
+			ehi->probe_mask |= (1 << ata_link_max_devices(link)) - 1;
+			ehi->action |= ATA_EH_SOFTRESET;
+		}
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, id);
 
 		if (dev) {
+			struct ata_eh_info *ehi = &dev->link->eh_info;
 			ehi->probe_mask |= 1 << dev->devno;
 			ehi->action |= ATA_EH_SOFTRESET;
 			ehi->flags |= ATA_EHI_RESUME_LINK;
@@ -3210,23 +3248,26 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 {
 	struct ata_port *ap =
 		container_of(work, struct ata_port, scsi_rescan_task);
+	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_link_for_each_dev(dev, &ap->link) {
-		struct scsi_device *sdev = dev->sdev;
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link) {
+			struct scsi_device *sdev = dev->sdev;
 
-		if (!ata_dev_enabled(dev) || !sdev)
-			continue;
-		if (scsi_device_get(sdev))
-			continue;
+			if (!ata_dev_enabled(dev) || !sdev)
+				continue;
+			if (scsi_device_get(sdev))
+				continue;
 
-		spin_unlock_irqrestore(ap->lock, flags);
-		scsi_rescan_device(&(sdev->sdev_gendev));
-		scsi_device_put(sdev);
-		spin_lock_irqsave(ap->lock, flags);
+			spin_unlock_irqrestore(ap->lock, flags);
+			scsi_rescan_device(&(sdev->sdev_gendev));
+			scsi_device_put(sdev);
+			spin_lock_irqsave(ap->lock, flags);
+		}
 	}
 
 	spin_unlock_irqrestore(ap->lock, flags);
-- 
1.5.0.3


