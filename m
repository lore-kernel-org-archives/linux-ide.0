From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 13:01:57 -0400
Message-ID: <4353D905.3080400@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org> <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org> <4353CF7E.1090404@pobox.com> <Pine.LNX.4.64.0510170930420.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070808050109050200030701"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750944AbVJQRCH@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510170930420.23590@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com, Jesse Barnes <jbarnes@virtuousgeek.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808050109050200030701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's a patch for the quirk.  I'll split this off from the sata-menu 
discussion.  Jesse, I presume this also fixes the problem for you?


This change makes quirk_intel_ide_combined() dependent on the precise 
conditions under which it is needed:
* IDE is built in
* IDE SATA option is not set
* ata_piix or ahci drivers are enabled

This fixes an issue where some modular configurations would not cause 
the quirk to be enabled.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


--------------070808050109050200030701
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1233,7 +1233,7 @@ static void __init quirk_alder_ioapic(st
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
-#ifdef CONFIG_SCSI_SATA
+#ifdef CONFIG_SCSI_SATA_INTEL_COMBINED
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
@@ -1310,7 +1310,7 @@ static void __devinit quirk_intel_ide_co
 		request_region(0x170, 8, "libata");	/* port 1 */
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,	  quirk_intel_ide_combined );
-#endif /* CONFIG_SCSI_SATA */
+#endif /* CONFIG_SCSI_SATA_INTEL_COMBINED */
 
 
 int pcie_mch_quirk;
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -553,6 +553,11 @@ config SCSI_SATA_VITESSE
 
 	  If unsure, say N.
 
+config SCSI_SATA_INTEL_COMBINED
+	bool
+	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
+	default y
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API

--------------070808050109050200030701--
