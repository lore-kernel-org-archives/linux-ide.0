From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 17/17] libata-link: update Power Management to handle PMP links
Date: Sat, 8 Jul 2006 14:45:38 +0900
Message-ID: <1152337538606-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.202]:975 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964781AbWGHFox (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:53 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1205853wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:53 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update Power Management to consider PMP links.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   20 +++++++++++++-------
 drivers/scsi/libata-eh.c   |   16 ++++++++++------
 2 files changed, 23 insertions(+), 13 deletions(-)

e65868d12527ea6e764aed3b996d103df352dac1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4088498..a887522 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5106,6 +5106,7 @@ static int ata_host_set_request_pm(struc
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
+		struct ata_link *link;
 
 		/* Previous resume operation might still be in
 		 * progress.  Wait for PM_PENDING to clear.
@@ -5125,8 +5126,10 @@ static int ata_host_set_request_pm(struc
 		}
 
 		ap->pflags |= ATA_PFLAG_PM_PENDING;
-		ap->link.eh_info.action |= action;
-		ap->link.eh_info.flags |= ehi_flags;
+		__ata_port_for_each_link(link, ap) {
+			link->eh_info.action |= action;
+			link->eh_info.flags |= ehi_flags;
+		}
 
 		ata_port_schedule_eh(ap);
 
@@ -5173,15 +5176,18 @@ int ata_host_set_suspend(struct ata_host
 	 */
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
+		struct ata_link *link;
 		struct ata_device *dev;
 
-		ata_link_for_each_dev(dev, &ap->link) {
-			if (ata_dev_ready(dev)) {
-				ata_port_printk(ap, KERN_WARNING,
+		ata_port_for_each_link(link, ap) {
+			ata_link_for_each_dev(dev, link) {
+				if (ata_dev_ready(dev)) {
+					ata_port_printk(ap, KERN_WARNING,
 						"suspend failed, device %d "
 						"still active\n", dev->devno);
-				rc = -EBUSY;
-				goto fail;
+					rc = -EBUSY;
+					goto fail;
+				}
 			}
 		}
 	}
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 1805769..076badd 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -2356,17 +2356,21 @@ static void ata_eh_handle_port_resume(st
 	/* give devices time to request EH */
 	timeout = jiffies + HZ; /* 1s max */
 	while (1) {
+		struct ata_link *link;
 		struct ata_device *dev;
 
-		ata_link_for_each_dev(dev, &ap->link) {
-			unsigned int action = ata_eh_dev_action(dev);
+		ata_port_for_each_link(link, ap) {
+			ata_link_for_each_dev(dev, link) {
+				unsigned int action = ata_eh_dev_action(dev);
 
-			if ((dev->flags & ATA_DFLAG_SUSPENDED) &&
-			    !(action & ATA_EH_RESUME))
-				break;
+				if ((dev->flags & ATA_DFLAG_SUSPENDED) &&
+				    !(action & ATA_EH_RESUME))
+					goto out_of_loop;
+			}
 		}
+	out_of_loop:
 
-		if (dev == NULL || time_after(jiffies, timeout))
+		if (link == NULL || time_after(jiffies, timeout))
 			break;
 		msleep(10);
 	}
-- 
1.3.2


