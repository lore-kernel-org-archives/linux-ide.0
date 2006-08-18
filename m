From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: s/CONFIG_SCSI_SATA/CONFIG_[S]ATA/g in pci/quirks.c
Date: Sat, 19 Aug 2006 03:54:39 +0900
Message-ID: <20060818185439.GK6371@htj.dyndns.org>
References: <20060818180832.GJ6371@htj.dyndns.org> <44E60898.4020805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:17061 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161071AbWHRSyo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Aug 2006 14:54:44 -0400
Received: by py-out-1112.google.com with SMTP id n25so1193547pyg
        for <linux-ide@vger.kernel.org>; Fri, 18 Aug 2006 11:54:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <44E60898.4020805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

drivers/pci/quirks.c was not updated when libata config constants were
renamed braking several libata quirks.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/pci/quirks.c
===================================================================
--- work.orig/drivers/pci/quirks.c	2006-08-19 03:12:58.000000000 +0900
+++ work/drivers/pci/quirks.c	2006-08-19 03:50:29.000000000 +0900
@@ -1209,7 +1209,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
 
-#if defined(CONFIG_SCSI_SATA) || defined(CONFIG_SCSI_SATA_MODULE)
+#if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
 
 /*
  *	If we are using libata we can drive this chip properly but must
@@ -1299,7 +1299,7 @@ static int __init combined_setup(char *s
 }
 __setup("combined_mode=", combined_setup);
 
-#ifdef CONFIG_SCSI_SATA_INTEL_COMBINED
+#ifdef CONFIG_SATA_INTEL_COMBINED
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
@@ -1392,7 +1392,7 @@ static void __devinit quirk_intel_ide_co
 		request_region(0x170, 8, "libata");	/* port 1 */
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,	  quirk_intel_ide_combined );
-#endif /* CONFIG_SCSI_SATA_INTEL_COMBINED */
+#endif /* CONFIG_SATA_INTEL_COMBINED */
 
 
 int pcie_mch_quirk;
