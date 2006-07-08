From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] libata-pmp-prep: add @new_class to ata_dev_revalidate()
Date: Sat, 8 Jul 2006 14:51:17 +0900
Message-ID: <1152337877970-git-send-email-htejun@gmail.com>
References: <11523378773934-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:6514 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964790AbWGHFu0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:50:26 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484430wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:50:26 -0700 (PDT)
In-Reply-To: <11523378773934-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Consider newly found class code while revalidating.  PMP resetting
always results in valid class code and issuing PMP commands to
ATA/ATAPI device isn't very attractive.  Add @new_class to
ata_dev_revalidate() and check class code for revalidation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   20 +++++++++++++++-----
 drivers/scsi/libata-eh.c   |    2 +-
 include/linux/libata.h     |    3 ++-
 3 files changed, 18 insertions(+), 7 deletions(-)

34beb969ad3952cf7a1cc77e5b21f3f1b563ee86
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a887522..f004675 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2115,7 +2115,7 @@ static int ata_dev_set_mode(struct ata_d
 		return -EIO;
 	}
 
-	rc = ata_dev_revalidate(dev, 0);
+	rc = ata_dev_revalidate(dev, ATA_DEV_UNKNOWN, 0);
 	if (rc)
 		return rc;
 
@@ -2985,6 +2985,7 @@ static int ata_dev_same_device(struct at
 /**
  *	ata_dev_revalidate - Revalidate ATA device
  *	@dev: device to revalidate
+ *	@new_class: new class code
  *	@post_reset: is this revalidation after reset?
  *
  *	Re-read IDENTIFY page and make sure @dev is still attached to
@@ -2996,9 +2997,9 @@ static int ata_dev_same_device(struct at
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
 
@@ -3007,13 +3008,22 @@ int ata_dev_revalidate(struct ata_device
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
index 076badd..55d43c1 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1717,7 +1717,7 @@ static int ata_eh_revalidate_and_attach(
 			}
 
 			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
-			rc = ata_dev_revalidate(dev,
+			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
 					ehc->i.flags & ATA_EHI_DID_RESET);
 			if (rc)
 				break;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b6715c1..d65bb05 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -693,7 +693,8 @@ extern int sata_std_hardreset(struct ata
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
1.3.2


