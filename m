From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] [PATCH] libata-pmp-prep: add @new_class to ata_dev_revalidate()
Date: Mon, 16 Oct 2006 08:17:47 +0900
Message-ID: <11609542673688-git-send-email-htejun@gmail.com>
References: <11609542672061-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:52915 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750822AbWJOXRy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:17:54 -0400
Received: by py-out-1112.google.com with SMTP id n25so2078413pyg
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:17:53 -0700 (PDT)
In-Reply-To: <11609542672061-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Consider newly found class code while revalidating.  PMP resetting
always results in valid class code and issuing PMP commands to
ATA/ATAPI device isn't very attractive.  Add @new_class to
ata_dev_revalidate() and check class code for revalidation.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   20 +++++++++++++++-----
 drivers/ata/libata-eh.c   |    2 +-
 include/linux/libata.h    |    3 ++-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c94b65..d7b28f6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2169,7 +2169,7 @@ static int ata_dev_set_mode(struct ata_d
 		return -EIO;
 	}
 
-	rc = ata_dev_revalidate(dev, 0);
+	rc = ata_dev_revalidate(dev, ATA_DEV_UNKNOWN, 0);
 	if (rc)
 		return rc;
 
@@ -3073,6 +3073,7 @@ static int ata_dev_same_device(struct at
 /**
  *	ata_dev_revalidate - Revalidate ATA device
  *	@dev: device to revalidate
+ *	@new_class: new class code
  *	@post_reset: is this revalidation after reset?
  *
  *	Re-read IDENTIFY page and make sure @dev is still attached to
@@ -3084,9 +3085,9 @@ static int ata_dev_same_device(struct at
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_dev_revalidate(struct ata_device *dev, int post_reset)
+int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
+		       int post_reset)
 {
-	unsigned int class = dev->class;
 	u16 *id = (void *)dev->link->ap->sector_buf;
 	int rc;
 
@@ -3095,13 +3096,22 @@ int ata_dev_revalidate(struct ata_device
 		goto fail;
 	}
 
+	if (ata_class_enabled(new_class)) {
+		/* sometimes wrong class is reported, let it retry */
+		if (new_class != ATA_DEV_ATA && new_class != ATA_DEV_ATAPI) {
+			rc = -EIO;
+			goto fail;
+		}
+	} else
+		new_class = dev->class;
+
 	/* read ID data */
-	rc = ata_dev_read_id(dev, &class, post_reset, id);
+	rc = ata_dev_read_id(dev, &new_class, post_reset, id);
 	if (rc)
 		goto fail;
 
 	/* is the device still there? */
-	if (!ata_dev_same_device(dev, class, id)) {
+	if (!ata_dev_same_device(dev, new_class, id)) {
 		rc = -ENODEV;
 		goto fail;
 	}
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ead460b..8ee4674 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1738,7 +1738,7 @@ static int ata_eh_revalidate_and_attach(
 			}
 
 			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
-			rc = ata_dev_revalidate(dev,
+			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
 					ehc->i.flags & ATA_EHI_DID_RESET);
 			if (rc)
 				break;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e09dfe6..676e1d9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -729,7 +729,8 @@ extern int sata_std_hardreset(struct ata
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern void sata_std_hp_poll_activate(struct ata_port *ap);
 extern int sata_std_hp_poll(struct ata_port *ap);
-extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
+extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
+			      int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
-- 
1.4.2.3


