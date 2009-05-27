From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] Restore SB600 SATA controller 64 bit DMA
Date: Wed, 27 May 2009 15:04:43 +0800
Message-ID: <1243407883.3220.10.camel@brienza-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:41833 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758931AbZE0HEy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2009 03:04:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Community reported one SB600 SATA issue(BZ #9412), which led to 64 bit
DMA disablement for all SB600 revisions by driver maintainers with
commits c7a42156d99bcea7f8173ba7a6034bbaa2ecb77c and
4cde32fc4b32e96a99063af3183acdfd54c563f0.

But the root cause is ASUS M2A-VM system BIOS bug in old revisions
like 0901, while forcing into 32bit DMA happens to work as workaround.
Now it's time to withdraw 4cde32fc4b32e96a99063af3183acdfd54c563f0
so as to restore the SB600 SATA 64bit DMA capability.
This patch is also adding the workaround for M2A-VM old BIOS revisions,
but users are suggested to upgrade their system BIOS to the latest one
if they meet this issue.

Signed-off-by: Shane Huang <shane.huang@amd.com>
Cc: Tejun Heo <tj@kernel.org>

diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2009-05-20 22:18:44.000000000 +0800
+++ b/drivers/ata/ahci.c	2009-05-25 20:30:16.000000000 +0800
@@ -429,8 +429,7 @@
 	/* board_ahci_sb600 */
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
-				 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
-				 AHCI_HFLAG_SECT255),
+				 AHCI_HFLAG_NO_MSI | AHCI_HFLAG_SECT255),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
@@ -2575,6 +2574,51 @@
 	}
 }
 
+/*
+ * SB600 ahci controller on ASUS M2A-VM can't do 64bit DMA with older
+ * BIOS.  The oldest version known to be broken is 0901 and working is
+ * 1501 which was released on 2007-10-26.  Force 32bit DMA on anything
+ * older than 1501.  Please read bko#9412 for more info.
+ */
+static bool ahci_asus_m2a_vm_32bit_only(struct pci_dev *pdev)
+{
+	static const struct dmi_system_id sysids[] = {
+		{
+			.ident = "ASUS M2A-VM",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "ASUSTeK Computer INC."),
+				DMI_MATCH(DMI_BOARD_NAME, "M2A-VM"),
+			},
+		},
+		{ }
+	};
+	const char *cutoff_mmdd = "10/26";
+	const char *date;
+	int year;
+
+	if (pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(0x12, 0) ||
+	    !dmi_check_system(sysids))
+		return false;
+
+	/*
+	 * Argh.... both version and date are free form strings.
+	 * Let's hope they're using the same date format across
+	 * different versions.
+	 */
+	date = dmi_get_system_info(DMI_BIOS_DATE);
+	year = dmi_get_year(DMI_BIOS_DATE);
+	if (date && strlen(date) >= 10 && date[2] == '/' && date[5] == '/' &&
+	    (year > 2007 ||
+	     (year == 2007 && strncmp(date, cutoff_mmdd, 5) >= 0)))
+		return false;
+
+	dev_printk(KERN_WARNING, &pdev->dev, "ASUS M2A-VM: BIOS too old, "
+		   "forcing 32bit DMA, update BIOS\n");
+
+	return true;
+}
+
 static bool ahci_broken_system_poweroff(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id broken_systems[] = {
@@ -2678,6 +2722,10 @@
 	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
 		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
 
+	/* apply ASUS M2A_VM quirk */
+	if (ahci_asus_m2a_vm_32bit_only(pdev))
+		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+
 	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
 		pci_enable_msi(pdev);
 
diff -ruN a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
--- a/drivers/firmware/dmi_scan.c	2009-05-25 20:31:01.000000000 +0800
+++ b/drivers/firmware/dmi_scan.c	2009-05-25 20:31:05.000000000 +0800
@@ -596,6 +596,7 @@
 
 	return year;
 }
+EXPORT_SYMBOL(dmi_get_year);
 
 /**
  *	dmi_walk - Walk the DMI table and get called back for every record


