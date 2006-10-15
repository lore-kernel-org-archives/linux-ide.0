From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 18/18] [PATCH] libata-link: update Power Management to handle PMP links
Date: Mon, 16 Oct 2006 07:54:42 +0900
Message-ID: <11609528823596-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:2229 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422942AbWJOWy7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:59 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626618nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:58 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update Power Management to consider PMP links.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   20 +++++++++++++-------
 drivers/ata/libata-eh.c   |   16 ++++++++++------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cc21698..0c94b65 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5195,6 +5195,7 @@ static int ata_host_request_pm(struct at
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		struct ata_link *link;
 
 		/* Previous resume operation might still be in
 		 * progress.  Wait for PM_PENDING to clear.
@@ -5214,8 +5215,10 @@ static int ata_host_request_pm(struct at
 		}
 
 		ap->pflags |= ATA_PFLAG_PM_PENDING;
-		ap->link.eh_info.action |= action;
-		ap->link.eh_info.flags |= ehi_flags;
+		__ata_port_for_each_link(link, ap) {
+			link->eh_info.action |= action;
+			link->eh_info.flags |= ehi_flags;
+		}
 
 		ata_port_schedule_eh(ap);
 
@@ -5262,15 +5265,18 @@ int ata_host_suspend(struct ata_host *ho
 	 */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
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
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1389a1f..ead460b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2378,17 +2378,21 @@ static void ata_eh_handle_port_resume(st
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
1.4.2.3


