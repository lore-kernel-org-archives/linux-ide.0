From: Sandor Bodo-Merle <sbodomerle@gmail.com>
Subject: [PATCH] Fix for broken SB600 64 bit DMA issue - generic way
Date: Fri, 14 Aug 2009 21:54:46 +0200
Message-ID: <1250279686-5209-1-git-send-email-sbodomerle@gmail.com>
References: <4A84CC8A.7000103@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:51948 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757093AbZHNT5b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Aug 2009 15:57:31 -0400
Received: by fxm11 with SMTP id 11so1362861fxm.39
        for <linux-ide@vger.kernel.org>; Fri, 14 Aug 2009 12:57:30 -0700 (PDT)
In-Reply-To: <4A84CC8A.7000103@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Shane.Huang@amd.com, Sandor Bodo-Merle <sbodomerle@gmail.com>

---
 drivers/ata/ahci.c |   68 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index fe3eba5..9ae19a5 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2602,33 +2602,66 @@ static void ahci_p5wdh_workaround(struct ata_host *host)
 	}
 }
 
+const static struct dmi_system_id *dmi_64bit_dma_ok = NULL;
+static int ahci_asus_m2a_vm_32bit_only(const struct dmi_system_id *);
+
 /*
- * SB600 ahci controller on ASUS M2A-VM can't do 64bit DMA with older
- * BIOS.  The oldest version known to be broken is 0901 and working is
- * 1501 which was released on 2007-10-26.  Force 32bit DMA on anything
- * older than 1501.  Please read bko#9412 for more info.
+ * There are broken MoBo's with SB600 ahci controller, which can't do
+ * 64bit DMA.
+ * So far ASUS M2A-VM with older BIOS and Gigabyte GA-MA69VM-S2
+ * were reported as broken.
  */
-static bool ahci_asus_m2a_vm_32bit_only(struct pci_dev *pdev)
+static bool ahci_broken_system_32bit_only(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id sysids[] = {
 		{
+			.callback = ahci_asus_m2a_vm_32bit_only,
 			.ident = "ASUS M2A-VM",
 			.matches = {
 				DMI_MATCH(DMI_BOARD_VENDOR,
 					  "ASUSTeK Computer INC."),
 				DMI_MATCH(DMI_BOARD_NAME, "M2A-VM"),
 			},
+			.driver_data = (void *)"10/26", /* cutoff BIOS date - mm/dd */
 		},
-		{ }
+		{
+			.ident = "Gigabyte GA-MA69VM-S2",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+						"Gigabyte Technology Co., Ltd."),
+				DMI_MATCH(DMI_BOARD_NAME, "GA-MA69VM-S2"),
+			},
+		},
+		{ } /* terminate list */
 	};
-	const char *cutoff_mmdd = "10/26";
-	const char *date;
-	int year;
 
+	/* No matches found */
 	if (pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(0x12, 0) ||
-	    !dmi_check_system(sysids))
+		!dmi_check_system(sysids))
+		return false;
+
+	/* Working version found by callback */
+	if (dmi_64bit_dma_ok)
 		return false;
 
+  dev_printk(KERN_WARNING, &pdev->dev, "SB600 controller can't do 64 bit DMA on this motherboard, "
+      "forcing 32bit DMA\n");
+
+  return true;
+}
+
+/*
+ * SB600 ahci controller on ASUS M2A-VM can't do 64bit DMA with older
+ * BIOS.  The oldest version known to be broken is 0901 and working is
+ * 1501 which was released on 2007-10-26.  Force 32bit DMA on anything
+ * older than 1501.  Please read bko#9412 for more info.
+ */
+static int ahci_asus_m2a_vm_32bit_only(const struct dmi_system_id *d)
+{
+	const char *cutoff_mmdd = (const char *)d->driver_data;
+	const char *date;
+	int year;
+
 	/*
 	 * Argh.... both version and date are free form strings.
 	 * Let's hope they're using the same date format across
@@ -2638,13 +2671,14 @@ static bool ahci_asus_m2a_vm_32bit_only(struct pci_dev *pdev)
 	year = dmi_get_year(DMI_BIOS_DATE);
 	if (date && strlen(date) >= 10 && date[2] == '/' && date[5] == '/' &&
 	    (year > 2007 ||
-	     (year == 2007 && strncmp(date, cutoff_mmdd, 5) >= 0)))
-		return false;
+	     (year == 2007 && strncmp(date, cutoff_mmdd, 5) >= 0))) {
+		dmi_64bit_dma_ok = d;
+		return 0;
+	}
 
-	dev_printk(KERN_WARNING, &pdev->dev, "ASUS M2A-VM: BIOS too old, "
-		   "forcing 32bit DMA, update BIOS\n");
+	printk(KERN_WARNING "ASUS M2A-VM: BIOS too old, update BIOS\n");
 
-	return true;
+	return 1;
 }
 
 static bool ahci_broken_system_poweroff(struct pci_dev *pdev)
@@ -2857,8 +2891,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
 		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
 
-	/* apply ASUS M2A_VM quirk */
-	if (ahci_asus_m2a_vm_32bit_only(pdev))
+	/* apply SB600 64bit DMA quirk */
+	if (ahci_broken_system_32bit_only(pdev))
 		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
 
 	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
-- 
1.6.3.3

