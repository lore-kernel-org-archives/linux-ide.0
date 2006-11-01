From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3 #upstream] libata: implement ATA_EHI_PRINTINFO
Date: Wed, 1 Nov 2006 18:38:52 +0900
Message-ID: <20061101093852.GS13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:45009 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946735AbWKAJjB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 04:39:01 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1669329ugm
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 01:39:00 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Implement ehi flag ATA_EHI_PRINTINFO.  This flag is set when device
configuration needs to print out device info.  This used to be handled
by @print_info argument to ata_dev_configure() but LLDs also need to
know about it in ->dev_config() callback.

This patch replaces @print_info w/ ATA_EHI_PRINTINFO and make sata_sil
print workaround messages only on the initial configuration.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this is respin of patches #1-3 of the following patchset.

    http://thread.gmane.org/gmane.linux.ide/13570/focus=13570

All three patches have been ACKed by you.  They're simply regenerated
against the current #upstream.

Thanks.

 drivers/ata/libata-core.c |   10 ++++++----
 drivers/ata/libata-eh.c   |    7 +++++--
 drivers/ata/libata.h      |    2 +-
 drivers/ata/sata_sil.c    |   11 +++++++----
 include/linux/libata.h    |    1 +
 5 files changed, 20 insertions(+), 11 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -1377,7 +1377,6 @@ static void ata_set_port_max_cmd_len(str
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
- *	@print_info: Enable device info printout
  *
  *	Configure @dev according to @dev->id.  Generic and low-level
  *	driver specific fixups are also applied.
@@ -1388,9 +1387,10 @@ static void ata_set_port_max_cmd_len(str
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
@@ -1638,7 +1638,9 @@ int ata_bus_probe(struct ata_port *ap)
 		if (rc)
 			goto fail;
 
-		rc = ata_dev_configure(dev, 1);
+		ap->eh_context.i.flags |= ATA_EHI_PRINTINFO;
+		rc = ata_dev_configure(dev);
+		ap->eh_context.i.flags &= ~ATA_EHI_PRINTINFO;
 		if (rc)
 			goto fail;
 	}
@@ -3045,7 +3047,7 @@ int ata_dev_revalidate(struct ata_device
 	memcpy(dev->id, id, sizeof(id[0]) * ATA_ID_WORDS);
 
 	/* configure device according to the new ID */
-	rc = ata_dev_configure(dev, 0);
+	rc = ata_dev_configure(dev);
 	if (rc == 0)
 		return 0;
 
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
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
Index: work/drivers/ata/libata.h
===================================================================
--- work.orig/drivers/ata/libata.h
+++ work/drivers/ata/libata.h
@@ -54,7 +54,7 @@ extern unsigned int ata_do_simple_cmd(st
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
-extern int ata_dev_configure(struct ata_device *dev, int print_info);
+extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -283,6 +283,7 @@ enum {
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
+	ATA_EHI_PRINTINFO	= (1 << 17), /* print configuration info */
 
 	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
 
Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
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
