From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Success(?) with SiI + Seagate pessimistic fix disabled.
Date: Wed, 14 Jan 2004 18:20:21 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4005CEB5.7020902@pobox.com>
References: <20040109054800.GA32112@Mayonaise> <20040109090003.GA3032@Mayonaise> <400105E6.6060008@pobox.com> <20040112161450.GA11636@Mayonaise>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050909080603050207060706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40583 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263510AbUANXUf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2004 18:20:35 -0500
In-Reply-To: <20040112161450.GA11636@Mayonaise>
List-Id: linux-ide@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050909080603050207060706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, here's what I checked in.

Anyone with an errata'd drive, that can help test this patch?

	Jeff




--------------050909080603050207060706
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1510  -> 1.1511 
#	drivers/scsi/sata_sil.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/14	normalperson@yhbt.net	1.1511
# [libata sata_sil] cleaner, better version of errata workarounds
# 
# No longer unfairly punishes non-errata Seagate and Maxtor drives.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	Wed Jan 14 18:19:53 2004
+++ b/drivers/scsi/sata_sil.c	Wed Jan 14 18:19:53 2004
@@ -64,6 +64,9 @@
 	SIL_IDE3_CTL		= 0x2CA,
 	SIL_IDE3_BMDMA		= 0x208,
 	SIL_IDE3_SCR		= 0x380,
+
+	SIL_QUIRK_MOD15WRITE	= (1 << 0),
+	SIL_QUIRK_UDMA5MAX	= (1 << 1),
 };
 
 static void sil_set_piomode (struct ata_port *ap, struct ata_device *adev,
@@ -82,6 +85,27 @@
 	{ }	/* terminate list */
 };
 
+
+/* TODO firmware versions should be added - eric */
+struct sil_drivelist {
+	const char * product;
+	unsigned int quirk;
+} sil_blacklist [] = {
+	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
+	{ }
+};
+
 static struct pci_driver sil_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sil_pci_tbl,
@@ -207,34 +231,52 @@
  *	information on these errata, I will create a more exhaustive
  *	list, and apply the fixups to only the specific
  *	devices/hosts/firmwares that need it.
+ *
+ *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
+ *	The Maxtor quirk is in the blacklist, but I'm keeping the original
+ *	pessimistic fix for the following reasons:
+ *	- There seems to be less info on it, only one device gleaned off the
+ *	Windows	driver, maybe only one is affected.  More info would be greatly
+ *	appreciated.
+ *	- But then again UDMA5 is hardly anything to complain about
  */
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
+	unsigned int n, quirks = 0;
+	u32 class_rev = 0;
 	const char *s = &dev->product[0];
 	unsigned int len = strnlen(s, sizeof(dev->product));
 
+	pci_read_config_dword(ap->host_set->pdev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+
 	/* ATAPI specifies that empty space is blank-filled; remove blanks */
 	while ((len > 0) && (s[len - 1] == ' '))
 		len--;
 
-	/* limit to udma5 */
-	if (!memcmp(s, "Maxtor ", 7)) {
-		printk(KERN_INFO "ata%u(%u): applying pessimistic Maxtor errata fix\n",
+	for (n = 0; sil_blacklist[n].product; n++) 
+		if (!memcmp(sil_blacklist[n].product, s,
+			    strlen(sil_blacklist[n].product))) {
+			quirks = sil_blacklist[n].quirk;
+			break;
+		}
+	
+	/* limit requests to 15 sectors */
+	if ((class_rev <= 0x01) && (quirks & SIL_QUIRK_MOD15WRITE)) {
+		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
 		       ap->id, dev->devno);
-		ap->udma_mask &= ATA_UDMA5;
+		ap->host->max_sectors = 15;
+		ap->host->hostt->max_sectors = 15;
 		return;
 	}
 
-	/* limit requests to 15 sectors */
-	if ((len > 4) && (!memcmp(s, "ST", 2))) {
-		if ((!memcmp(s + len - 2, "AS", 2)) ||
-		    (!memcmp(s + len - 3, "ASL", 3))) {
-			printk(KERN_INFO "ata%u(%u): applying pessimistic Seagate errata fix\n",
-			       ap->id, dev->devno);
-			ap->host->max_sectors = 15;
-			ap->host->hostt->max_sectors = 15;
-			return;
-		}
+	/* limit to udma5 */
+	/* is this for (class_rev <= 0x01) only, too? */
+	if (quirks & SIL_QUIRK_UDMA5MAX) {
+		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
+		       ap->id, dev->devno, s);
+		ap->udma_mask &= ATA_UDMA5;
+		return;
 	}
 }
 

--------------050909080603050207060706--

