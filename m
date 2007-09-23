From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata-pmp-prep: add @new_class to ata_dev_revalidate()
Date: Sun, 23 Sep 2007 13:14:12 +0900
Message-ID: <11905208522777-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:63937 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbXIWEOV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1545849wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:20 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Consider newly found class code while revalidating.  PMP resetting
always results in valid class code and issuing PMP commands to
ATA/ATAPI device isn't very attractive.  Add @new_class to
ata_dev_revalidate() and check class code for revalidation.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   15 +++++++++++++--
 drivers/ata/libata-eh.c   |    3 ++-
 drivers/ata/libata.h      |    3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 63274b6..bcddc93 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2848,7 +2848,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
 	}
 
 	ehc->i.flags |= ATA_EHI_POST_SETMODE;
-	rc = ata_dev_revalidate(dev, 0);
+	rc = ata_dev_revalidate(dev, ATA_DEV_UNKNOWN, 0);
 	ehc->i.flags &= ~ATA_EHI_POST_SETMODE;
 	if (rc)
 		return rc;
@@ -3752,6 +3752,7 @@ int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
 /**
  *	ata_dev_revalidate - Revalidate ATA device
  *	@dev: device to revalidate
+ *	@new_class: new class code
  *	@readid_flags: read ID flags
  *
  *	Re-read IDENTIFY page, make sure @dev is still attached to the
@@ -3763,7 +3764,8 @@ int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
+int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
+		       unsigned int readid_flags)
 {
 	u64 n_sectors = dev->n_sectors;
 	int rc;
@@ -3771,6 +3773,15 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
 	if (!ata_dev_enabled(dev))
 		return -ENODEV;
 
+	/* fail early if !ATA && !ATAPI to avoid issuing [P]IDENTIFY to PMP */
+	if (ata_class_enabled(new_class) &&
+	    new_class != ATA_DEV_ATA && new_class != ATA_DEV_ATAPI) {
+		ata_dev_printk(dev, KERN_INFO, "class mismatch %u != %u\n",
+			       dev->class, new_class);
+		rc = -ENODEV;
+		goto fail;
+	}
+
 	/* re-read ID */
 	rc = ata_dev_reread_id(dev, readid_flags);
 	if (rc)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index daa2f74..eb087bb 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2104,7 +2104,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			}
 
 			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
-			rc = ata_dev_revalidate(dev, readid_flags);
+			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
+						readid_flags);
 			if (rc)
 				goto err;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 11f64a4..3457048 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -77,7 +77,8 @@ extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   unsigned int flags, u16 *id);
 extern int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags);
-extern int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags);
+extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
+			      unsigned int readid_flags);
 extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link);
 extern int sata_set_spd_needed(struct ata_link *link);
-- 
1.5.0.3


