From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: ATA_EHI_LPM should be ATA_EH_LPM
Date: Thu, 27 Mar 2008 18:37:14 +0900
Message-ID: <47EB6ACA.2030507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:25177 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbYC0JhY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 05:37:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4722598wah.23
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 02:37:21 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

EH actions are ATA_EH_* not ATA_EHI_*.  Rename ATA_EHI_LPM to
ATA_EH_LPM.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/ata/libata-core.c |    2 +-
 drivers/ata/libata-eh.c   |    2 +-
 include/linux/libata.h    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -972,7 +972,7 @@ static void ata_dev_disable_pm(struct at
 void ata_lpm_schedule(struct ata_port *ap, enum link_pm policy)
 {
 	ap->pm_policy = policy;
-	ap->link.eh_info.action |= ATA_EHI_LPM;
+	ap->link.eh_info.action |= ATA_EH_LPM;
 	ap->link.eh_info.flags |= ATA_EHI_NO_AUTOPSY;
 	ata_port_schedule_eh(ap);
 }
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2748,7 +2748,7 @@ int ata_eh_recover(struct ata_port *ap, 
 			ehc->i.flags &= ~ATA_EHI_SETMODE;
 		}
 
-		if (ehc->i.action & ATA_EHI_LPM)
+		if (ehc->i.action & ATA_EH_LPM)
 			ata_link_for_each_dev(dev, link)
 				ata_dev_enable_pm(dev, ap->pm_policy);
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -295,6 +295,7 @@ enum {
 	ATA_EH_SOFTRESET	= (1 << 1),
 	ATA_EH_HARDRESET	= (1 << 2),
 	ATA_EH_ENABLE_LINK	= (1 << 3),
+	ATA_EH_LPM		= (1 << 4),  /* link power management action */
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
@@ -304,7 +305,6 @@ enum {
 	ATA_EHI_RESUME_LINK	= (1 << 1),  /* resume link (reset modifier) */
 	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
-	ATA_EHI_LPM		= (1 << 4),  /* link power management action */
 
 	ATA_EHI_DID_SOFTRESET	= (1 << 16), /* already soft-reset this port */
 	ATA_EHI_DID_HARDRESET	= (1 << 17), /* already soft-reset this port */
