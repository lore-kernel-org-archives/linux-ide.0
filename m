From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata-pmp-prep: add @new_class to ata_dev_revalidate()
Date: Sun, 1 Jul 2007 19:26:07 +0900
Message-ID: <11832855672308-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:25349 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbXGAK0N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884678wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:12 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
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
index f4863b6..d366ac2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2790,7 +2790,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
 	}
 
 	ehc->i.flags |= ATA_EHI_POST_SETMODE;
-	rc = ata_dev_revalidate(dev, 0);
+	rc = ata_dev_revalidate(dev, ATA_DEV_UNKNOWN, 0);
 	ehc->i.flags &= ~ATA_EHI_POST_SETMODE;
 	if (rc)
 		return rc;
@@ -3699,6 +3699,7 @@ int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
 /**
  *	ata_dev_revalidate - Revalidate ATA device
  *	@dev: device to revalidate
+ *	@new_class: new class code
  *	@readid_flags: read ID flags
  *
  *	Re-read IDENTIFY page, make sure @dev is still attached to the
@@ -3710,7 +3711,8 @@ int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
+int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
+		       unsigned int readid_flags)
 {
 	u64 n_sectors = dev->n_sectors;
 	int rc;
@@ -3718,6 +3720,15 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
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
index eb51b76..7e8ec17 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1966,7 +1966,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			}
 
 			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
-			rc = ata_dev_revalidate(dev, readid_flags);
+			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
+						readid_flags);
 			if (rc)
 				goto err;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 6d85ede..4153817 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -76,7 +76,8 @@ extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
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


