From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4 #upstream] ahci: make ahci_asus_m2a_vm_32bit_only() quirk
 more generic
Date: Sun, 16 Aug 2009 21:03:57 +0900
Message-ID: <4A87F5AD.7040508@gmail.com>
References: <4A87F512.3080802@kernel.org> <4A87F55C.3020103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:62535 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbZHPMES (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Aug 2009 08:04:18 -0400
Received: by pxi34 with SMTP id 34so843232pxi.4
        for <linux-ide@vger.kernel.org>; Sun, 16 Aug 2009 05:04:19 -0700 (PDT)
In-Reply-To: <4A87F55C.3020103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sandor Bodo-Merle <sbodomerle@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

It turns out ASUS M2A-VM isn't the only one with the 32bit DMA
problem.  Make ahci_asus_m2a_vm_32bit_only() more generic using the
new dmi_get_date() and rename it to ahci_sb600_32bit_only().  Cut off
date is now pointed to by dmi_system_id->driver_data in "yyyymmdd"
format and it's now also allowed to be omitted.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc: Shane Huang <shane.huang@amd.com>
---
 drivers/ata/ahci.c |   55 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

Index: ata/drivers/ata/ahci.c
===================================================================
--- ata.orig/drivers/ata/ahci.c
+++ ata/drivers/ata/ahci.c
@@ -2603,14 +2603,18 @@ static void ahci_p5wdh_workaround(struct
 }
 
 /*
- * SB600 ahci controller on ASUS M2A-VM can't do 64bit DMA with older
- * BIOS.  The oldest version known to be broken is 0901 and working is
- * 1501 which was released on 2007-10-26.  Force 32bit DMA on anything
- * older than 1501.  Please read bko#9412 for more info.
+ * SB600 ahci controller on certain boards can't do 64bit DMA with
+ * older BIOS.
  */
-static bool ahci_asus_m2a_vm_32bit_only(struct pci_dev *pdev)
+static bool ahci_sb600_32bit_only(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id sysids[] = {
+		/*
+		 * The oldest version known to be broken is 0901 and
+		 * working is 1501 which was released on 2007-10-26.
+		 * Force 32bit DMA on anything older than 1501.
+		 * Please read bko#9412 for more info.
+		 */
 		{
 			.ident = "ASUS M2A-VM",
 			.matches = {
@@ -2618,31 +2622,32 @@ static bool ahci_asus_m2a_vm_32bit_only(
 					  "ASUSTeK Computer INC."),
 				DMI_MATCH(DMI_BOARD_NAME, "M2A-VM"),
 			},
+			.driver_data = "20071026",	/* yyyymmdd */
 		},
 		{ }
 	};
-	const char *cutoff_mmdd = "10/26";
-	const char *date;
-	int year;
+	const struct dmi_system_id *match;
 
+	match = dmi_first_match(sysids);
 	if (pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(0x12, 0) ||
-	    !dmi_check_system(sysids))
-		return false;
-
-	/*
-	 * Argh.... both version and date are free form strings.
-	 * Let's hope they're using the same date format across
-	 * different versions.
-	 */
-	date = dmi_get_system_info(DMI_BIOS_DATE);
-	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
-	if (date && strlen(date) >= 10 && date[2] == '/' && date[5] == '/' &&
-	    (year > 2007 ||
-	     (year == 2007 && strncmp(date, cutoff_mmdd, 5) >= 0)))
+	    !match)
 		return false;
 
-	dev_printk(KERN_WARNING, &pdev->dev, "ASUS M2A-VM: BIOS too old, "
-		   "forcing 32bit DMA, update BIOS\n");
+	if (match->driver_data) {
+		int year, month, date;
+		char buf[9];
+
+		dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
+		snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
+
+		if (strcmp(buf, match->driver_data) >= 0)
+			return false;
+
+		dev_printk(KERN_WARNING, &pdev->dev, "%s: BIOS too old, "
+			   "forcing 32bit DMA, update BIOS\n", match->ident);
+	} else
+		dev_printk(KERN_WARNING, &pdev->dev, "%s: this board can't "
+			   "do 64bit DMA, forcing 32bit\n", match->ident);
 
 	return true;
 }
@@ -2857,8 +2862,8 @@ static int ahci_init_one(struct pci_dev
 	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
 		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
 
-	/* apply ASUS M2A_VM quirk */
-	if (ahci_asus_m2a_vm_32bit_only(pdev))
+	/* apply sb600 32bit only quirk */
+	if (ahci_sb600_32bit_only(pdev))
 		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
 
 	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
