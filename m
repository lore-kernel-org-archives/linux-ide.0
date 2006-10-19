From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: implement ATA_EHI_PRINTINFO
Date: Thu, 19 Oct 2006 14:51:38 +0900
Message-ID: <1161237098999-git-send-email-htejun@gmail.com>
References: <1161237098656-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:64169 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161175AbWJSFvs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Oct 2006 01:51:48 -0400
Received: by nf-out-0910.google.com with SMTP id c2so923950nfe
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 22:51:47 -0700 (PDT)
In-Reply-To: <1161237098656-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ehi flag ATA_EHI_PRINTINFO.  This flag is set when device
configuration needs to print out device info.  This used to be handled
by @print_info argument to ata_dev_configure() but LLDs also need to
know about it in ->dev_config() callback.

This patch replaces @print_info w/ ATA_EHI_PRINTINFO and make sata_sil
print workaround messages only on the initial configuration.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   10 ++++++----
 drivers/ata/libata-eh.c   |    7 +++++--
 drivers/ata/libata.h      |    2 +-
 drivers/ata/sata_sil.c    |   11 +++++++----
 include/linux/libata.h    |    1 +
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c127d6f..e9f76c6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1374,7 +1374,6 @@ static void ata_set_port_max_cmd_len(str
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
- *	@print_info: Enable device info printout
  *
  *	Configure @dev according to @dev->id.  Generic and low-level
  *	driver specific fixups are also applied.
@@ -1385,9 +1384,10 @@ static void ata_set_port_max_cmd_len(str
  *	RETURNS:
  *	0 on success, -errno otherwise
  */
-int ata_dev_configure(struct ata_device *dev, int print_info)
+int ata_dev_configure(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->ap;
+	int print_info = ap->eh_context.i.flags & ATA_EHI_PRINTINFO;
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
 	char revbuf[7];		/* XYZ-99\0 */
@@ -1635,7 +1635,9 @@ int ata_bus_probe(struct ata_port *ap)
 		if (rc)
 			goto fail;
 
-		rc = ata_dev_configure(dev, 1);
+		ap->eh_context.i.flags |= ATA_EHI_PRINTINFO;
+		rc = ata_dev_configure(dev);
+		ap->eh_context.i.flags &= ~ATA_EHI_PRINTINFO;
 		if (rc)
 			goto fail;
 	}
@@ -3005,7 +3007,7 @@ int ata_dev_revalidate(struct ata_device
 	memcpy(dev->id, id, sizeof(id[0]) * ATA_ID_WORDS);
 
 	/* configure device according to the new ID */
-	rc = ata_dev_configure(dev, 0);
+	rc = ata_dev_configure(dev);
 	if (rc == 0)
 		return 0;
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 02b2b27..7c44644 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1661,8 +1661,11 @@ static int ata_eh_revalidate_and_attach(
 			dev->class = ehc->classes[dev->devno];
 
 			rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
-			if (rc == 0)
-				rc = ata_dev_configure(dev, 1);
+			if (rc == 0) {
+				ehc->i.flags |= ATA_EHI_PRINTINFO;
+				rc = ata_dev_configure(dev);
+				ehc->i.flags &= ~ATA_EHI_PRINTINFO;
+			}
 
 			if (rc) {
 				dev->class = ATA_DEV_UNKNOWN;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a5ecb71..9bc267d 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -53,7 +53,7 @@ extern unsigned ata_exec_internal(struct
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
-extern int ata_dev_configure(struct ata_device *dev, int print_info);
+extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index ca8d993..f844a1f 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -534,6 +534,7 @@ static void sil_thaw(struct ata_port *ap
  */
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
+	int print_info = ap->eh_context.i.flags & ATA_EHI_PRINTINFO;
 	unsigned int n, quirks = 0;
 	unsigned char model_num[41];
 
@@ -549,16 +550,18 @@ static void sil_dev_config(struct ata_po
 	if (slow_down ||
 	    ((ap->flags & SIL_FLAG_MOD15WRITE) &&
 	     (quirks & SIL_QUIRK_MOD15WRITE))) {
-		ata_dev_printk(dev, KERN_INFO, "applying Seagate errata fix "
-			       "(mod15write workaround)\n");
+		if (print_info)
+			ata_dev_printk(dev, KERN_INFO, "applying Seagate "
+				       "errata fix (mod15write workaround)\n");
 		dev->max_sectors = 15;
 		return;
 	}
 
 	/* limit to udma5 */
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
-		ata_dev_printk(dev, KERN_INFO,
-			       "applying Maxtor errata fix %s\n", model_num);
+		if (print_info)
+			ata_dev_printk(dev, KERN_INFO, "applying Maxtor "
+				       "errata fix %s\n", model_num);
 		dev->udma_mask &= ATA_UDMA5;
 		return;
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b03d5a3..d71971e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -283,6 +283,7 @@ enum {
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
+	ATA_EHI_PRINTINFO	= (1 << 17), /* print configuration info */
 
 	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
 
-- 
1.4.2.3


