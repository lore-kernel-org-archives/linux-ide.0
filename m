From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/7] libata-pm-prep: add @new_class to ata_dev_revalidate()
Date: Fri, 12 May 2006 01:37:50 +0900
Message-ID: <11473654703989-git-send-email-htejun@gmail.com>
References: <11473654703440-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:50067 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030335AbWEKQh5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:37:57 -0400
Received: by wr-out-0506.google.com with SMTP id i12so407147wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:37:56 -0700 (PDT)
In-Reply-To: <11473654703440-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Consider newly found class code while revalidating.  PM resetting
always results in valid class code and issuing PM commands to
ATA/ATAPI devices isn't a very attractive idea.  Add @new_class to
ata_dev_revalidate() and check class during revalidation.

---

 drivers/scsi/libata-core.c |   20 +++++++++++++++-----
 drivers/scsi/libata-eh.c   |    2 +-
 include/linux/libata.h     |    3 ++-
 3 files changed, 18 insertions(+), 7 deletions(-)

e9ad06f7ef8413f1027baad8b64bc860b85fa85e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 32ea394..71f9ea7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2052,7 +2052,7 @@ static int ata_dev_set_mode(struct ata_d
 		return -EIO;
 	}
 
-	rc = ata_dev_revalidate(dev, 0);
+	rc = ata_dev_revalidate(dev, ATA_DEV_UNKNOWN, 0);
 	if (rc)
 		return rc;
 
@@ -2813,6 +2813,7 @@ static int ata_dev_same_device(struct at
 /**
  *	ata_dev_revalidate - Revalidate ATA device
  *	@dev: device to revalidate
+ *	@new_class: new class code
  *	@post_reset: is this revalidation after reset?
  *
  *	Re-read IDENTIFY page and make sure @dev is still attached to
@@ -2824,9 +2825,9 @@ static int ata_dev_same_device(struct at
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
 
@@ -2835,13 +2836,22 @@ int ata_dev_revalidate(struct ata_device
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
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index ecfb9c5..7abeb11 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1570,7 +1570,7 @@ static int ata_eh_revalidate_and_attach(
 			}
 
 			ata_eh_about_to_do(link, ATA_EH_REVALIDATE);
-			rc = ata_dev_revalidate(dev,
+			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
 						ehc->flags & ATA_EHC_DID_RESET);
 			if (rc)
 				break;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7db9b80..1fec322 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -633,7 +633,8 @@ extern int ata_std_prereset(struct ata_l
 extern int ata_std_softreset(struct ata_link *link, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_link *link, unsigned int *class);
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
-extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
+extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
+			      int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
-- 
1.2.4


