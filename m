From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Success(?) with SiI + Seagate pessimistic fix disabled.
Date: Mon, 12 Jan 2004 08:14:50 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040112161450.GA11636@Mayonaise>
References: <20040109054800.GA32112@Mayonaise> <20040109090003.GA3032@Mayonaise> <400105E6.6060008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from user-0c8gj4g.cable.mindspring.com ([24.136.76.144]:16533 "EHLO
	mayonaise.dyndns.org") by vger.kernel.org with ESMTP
	id S266198AbUALQOf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jan 2004 11:14:35 -0500
Content-Disposition: inline
In-Reply-To: <400105E6.6060008@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
> Eric Wong wrote:
> >Eric Wong <normalperson@yhbt.net> wrote:
> 
> Well, if you're motivated, there is a blacklist...
> 
> google for "mod15write" and click on the first link.

Cool.  I found some info on the Maxtor problem as well.  The blacklist
is ready for the Maxtor fix, but I chickened out and kept the original
pessimistic fix for those drives for the time being.  Seagates should be
correct, however.

--- a/drivers/scsi/sata_sil.c	2004-01-11 22:47:39.000000000 -0800
+++ b/drivers/scsi/sata_sil.c	2004-01-12 01:56:28.231405184 -0800
@@ -37,6 +37,9 @@
 #define DRV_NAME	"ata_sil"
 #define DRV_VERSION	"0.51"
 
+#define SIL_QUIRK_MOD15WRITE	0x01
+#define SIL_QUIRK_UDMA5MAX	0x02
+
 enum {
 	sil_3112		= 0,
 
@@ -65,6 +68,28 @@ static struct pci_device_id sil_pci_tbl[
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
+	{ "Maxtor 4D060H3                          DAK05GK0",
+		SIL_QUIRK_UDMA5MAX },
+	{ }
+};
+
 static struct pci_driver sil_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sil_pci_tbl,
@@ -182,16 +207,52 @@ static void sil_scr_write (struct ata_po
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
 
+	for (n = 0; sil_blacklist[n].product; n++) 
+		if ( ( strlen(sil_blacklist[n].product) == len )
+		&& strncmp(sil_blacklist[n].product,s,len) )
+			quirks = sil_blacklist[n].quirk;
+	
+	/* limit requests to 15 sectors */
+	if ( (class_rev <= 0x01) && (quirks & SIL_QUIRK_MOD15WRITE) ) {
+		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
+		       ap->id, dev->devno);
+		ap->host->max_sectors = 15;
+		ap->host->hostt->max_sectors = 15;
+		return;
+	}
+
+	/* limit to udma5 */
+	/* is this for (class_rev <= 0x01) only, too? */
+	if ( quirks & SIL_QUIRK_UDMA5MAX ) {
+		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
+		       ap->id, dev->devno, s);
+		ap->udma_mask &= ATA_UDMA5;
+		return;
+	}
+
 	/* limit to udma5 */
 	if (!memcmp(s, "Maxtor ", 7)) {
 		printk(KERN_INFO "ata%u(%u): applying pessimistic Maxtor errata fix\n",
@@ -199,18 +260,6 @@ static void sil_dev_config(struct ata_po
 		ap->udma_mask &= ATA_UDMA5;
 		return;
 	}
-
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
-	}
 }
 
 static void sil_set_piomode (struct ata_port *ap, struct ata_device *adev,

-- 
Eric Wong
