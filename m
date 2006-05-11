From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] libata-link: update hotplug to handle PM links
Date: Fri, 12 May 2006 01:30:24 +0900
Message-ID: <11473650243839-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:49436 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030241AbWEKQam (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:42 -0400
Received: by nf-out-0910.google.com with SMTP id g2so145743nfe
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:42 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update hotplug to handle PM links.  When PM is attached, the PMP
number corresponds to I of SCSI C:H:I:L.

---

 drivers/scsi/libata-eh.c   |   43 +++++++++++++++++++++++++--------------
 drivers/scsi/libata-scsi.c |   49 +++++++++++++++++++++++++++++++-------------
 2 files changed, 62 insertions(+), 30 deletions(-)

314e603ad221c11cea7e123706d8c4c492466ab0
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 24b5dc8..ecfb9c5 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1875,6 +1875,25 @@ static void ata_eh_finish(struct ata_por
 	}
 }
 
+static void ata_eh_scsi_handle_link_detach(struct ata_link *link)
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
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		dev->flags &= ~ATA_DFLAG_DETACHED;
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		ata_scsi_remove_dev(dev);
+	}
+}
+
 /**
  *	ata_eh_scsi_hotplug - SCSI part of hotplug
  *	@data: Pointer to ATA port to perform SCSI hotplug on
@@ -1891,8 +1910,7 @@ void ata_eh_scsi_hotplug(void *data)
 {
 	struct ata_port *ap = data;
 	unsigned long timeout;
-	struct ata_device *dev;
-	int requeue = 0;
+	int i, requeue = 0;
 
 	DPRINTK("ENTER\n");
 
@@ -1912,19 +1930,14 @@ void ata_eh_scsi_hotplug(void *data)
 	if (scsi_host_in_recovery(ap->host))
 		requeue = 1;
 
-	/* unplug detached devices */
-	ata_link_for_each_dev(dev, &ap->link) {
-		unsigned long flags;
-
-		if (!(dev->flags & ATA_DFLAG_DETACHED))
-			continue;
-
-		spin_lock_irqsave(&ap->host_set->lock, flags);
-		dev->flags &= ~ATA_DFLAG_DETACHED;
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-		ata_scsi_remove_dev(dev);
-	}
+	/* Unplug detached devices.  We cannot use link iterator here
+	 * because PM links have to be scanned even if PM is currently
+	 * not attached.  Iterate manually.
+	 */
+	ata_eh_scsi_handle_link_detach(&ap->link);
+	if (ap->pm_link)
+		for (i = 0; i < ATA_PM_MAX_PORTS; i++)
+			ata_eh_scsi_handle_link_detach(&ap->pm_link[i]);
 
 	/* scan for new ones */
 	ata_scsi_scan_host(ap);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index facde9e..021e4a3 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2347,8 +2347,14 @@ static unsigned int atapi_xlat(struct at
 
 static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
 {
-	if (likely(id == 0 || (id == 1 && ap->flags & ATA_FLAG_SLAVE_POSS)))
-		return &ap->link.device[id];
+	if (ap->nr_pm_links == 0) {
+		if (likely(id < ata_link_max_devices(&ap->link)))
+			return &ap->link.device[id];
+	} else {
+		if (likely(id < ap->nr_pm_links))
+			return &ap->pm_link[id].device[0];
+	}
+
 	return NULL;
 }
 
@@ -2775,21 +2781,30 @@ void ata_scsi_simulate(struct ata_device
 
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
 
-		sdev = __scsi_add_device(ap->host, 0, dev->devno, 0, NULL);
-		if (!IS_ERR(sdev)) {
-			dev->sdev = sdev;
-			scsi_device_put(sdev);
+			if (ata_is_host_link(link))
+				devno = dev->devno;
+			else
+				devno = link->pmp;
+
+			sdev = __scsi_add_device(ap->host, 0, devno, 0, NULL);
+			if (!IS_ERR(sdev)) {
+				dev->sdev = sdev;
+				scsi_device_put(sdev);
+			}
 		}
 	}
 }
@@ -2897,6 +2912,7 @@ static int ata_scsi_user_scan(struct Scs
 			      unsigned int id, unsigned int lun)
 {
 	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ata_link *link;
 	unsigned long flags;
 	int rc = 0;
 
@@ -2910,15 +2926,18 @@ static int ata_scsi_user_scan(struct Scs
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
 	if (id == SCAN_WILD_CARD) {
-		ap->link.eh_info.probe_mask |=
-			(1 << ata_link_max_devices(&ap->link)) - 1;
-		ap->link.eh_info.action |= ATA_EH_SOFTRESET;
+		ata_port_for_each_link(link, ap) {
+			link->eh_info.probe_mask |=
+				(1 << ata_link_max_devices(link)) - 1;
+			link->eh_info.action |= ATA_EH_SOFTRESET;
+		}
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, id);
 
 		if (dev) {
-			ap->link.eh_info.probe_mask |= 1 << dev->devno;
-			ap->link.eh_info.action |= ATA_EH_SOFTRESET;
+			link = dev->link;
+			link->eh_info.probe_mask |= 1 << dev->devno;
+			link->eh_info.action |= ATA_EH_SOFTRESET;
 		} else
 			rc = -EINVAL;
 	}
-- 
1.2.4


