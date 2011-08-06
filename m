From: Bernhard Froemel <froemel@vmars.tuwien.ac.at>
Subject: Allow (forced) AHCI mode on Intel 5 series, 3400 series chipsets
Date: Sat, 06 Aug 2011 22:07:21 +0200
Message-ID: <4E3D9EF9.4050906@vmars.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020608090204000404010907"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from luna.vmars.tuwien.ac.at ([128.130.39.29]:42697 "EHLO
	mail.vmars.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab1HFUYy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Aug 2011 16:24:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: joerg@dorchain.net, sshtylyov@mvista.com

This is a multi-part message in MIME format.
--------------020608090204000404010907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I'd like to submit the following patch for discussion.
Credits go to Greg White (pushing me with his patch into the right
direction, https://bugs.launchpad.net/mactel-support/+bug/817017 ) and
Joerg Dorchain (who found an elegant way to fix this without introducing
any new hacks to the existing framework,
http://ns.spinics.net/lists/linux-ide/msg40206.html ).

Sole purpose of this patch against Linux 3.0 is to enable AHCI mode of
the SATA controller within certain Intel 5 series/3400 series chipset
based systems.

The EFI/bios on the Apple Macbook Pro 6 series (and other Intel Chipset
based Macs and Macbook (Pros)) is ignorant of the SATA controller
AHCI/IDE mode settings. It is not possible to configure the EFI/bios to
set the SATA controller into the AHCI mode and even if the controller is
put into AHCI mode (e.g. by the bootloader) it is not correctly restored
during sleep/suspend-wakeup cycles. The attached patch attempts to fix
this by
1) registering the actual SATA controller mode and/or forcibly set it to
AHCI mode (kernel command parameter: i5s_3400s_force_ahci=1) during
system boot
2) restoring the AHCI mode after wakeup depending on the mode the
controller was during system boot

The patch should have no impact on systems where an EFI/bios takes care
about setting and correctly restoring the SATA controller mode: For
those systems the kernel command parameter 'i5s_3400s_force_ahci=1' only
acts as an additional feature to override the actual EFI/bios setting.

Cheers,
 Bernhard

--------------020608090204000404010907
Content-Type: text/x-patch;
 name="i5s_3400s_ahci_handling_for_incapable_efi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i5s_3400s_ahci_handling_for_incapable_efi.patch"

Signed-off-by: Bernhard Froemel <froemel@vmars.tuwien.ac.at>

--- a/drivers/pci/quirks.c	2011-07-22 04:17:23.000000000 +0200
+++ b/drivers/pci/quirks.c	2011-07-28 13:30:04.816817416 +0200
@@ -2799,6 +2799,82 @@
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_TI, 0xb800, fixup_ti816x_class);
 
+/*
+ * Workaround for EFIs/Bios that do not allow to set (and/or restore upon
+ * resume) the SATA controller AHCI mode within the Intel 5 Series/3400
+ * Series chipset. The SATA controller mode is registered during the boot
+ * process. In case of a resume, these fixups check the current controller
+ * mode against the earlier registered one and will restore it to AHCI
+ * mode if necessary. The user can force AHCI by setting the kernel
+ * command parameter 'i5s_3400s_force_ahci=1'.
+ *
+ * The PCI device id (and register contents) change during mode switch, so
+ * these fixups are attached to the LPC and expect that:
+ * -) the SATA controller is on 00:1f.2
+ * -) the SATA controller device is initialized/resumed *after* the LPC device
+*/
+
+#define I5S_REG_AMAP		0x90
+#define I5S_PREFIX			"[i5s_3400s ** FIXUP] "
+static int i5s_3400s_force_ahci;
+
+static int __init i5s_3400s_force_ahci_setup(char *str)
+{
+	if (!strcmp(str, "1"))
+		i5s_3400s_force_ahci = 1;
+	return 0;
+}
+early_param("i5s_3400s_force_ahci", i5s_3400s_force_ahci_setup);
+
+static void __devinit i5s_3400s_fixup(struct pci_dev *dev)
+{
+	u16 amap;
+	pci_bus_read_config_word(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 2),
+		I5S_REG_AMAP, &amap);
+	if (amap & 0x60) {
+		printk(KERN_DEBUG I5S_PREFIX
+			"SATA controller mode: AHCI (0x%04x)\n", amap);
+		i5s_3400s_force_ahci = 1;
+	} else {
+		printk(KERN_DEBUG I5S_PREFIX
+			"SATA controller mode: NON AHCI (0x%04x)\n", amap);
+		if (i5s_3400s_force_ahci && (amap & 0xE0) == 0) {
+			amap |= 0x60;
+			printk(KERN_DEBUG I5S_PREFIX
+				"Putting SATA controller into AHCI (0x%04x)\n",
+				amap);
+			pci_bus_write_config_word(dev->bus,
+				PCI_DEVFN(PCI_SLOT(dev->devfn), 2),
+				I5S_REG_AMAP, amap);
+		}
+	}
+}
+static void i5s_3400s_fixup_resume(struct pci_dev *dev)
+{
+	u16 amap;
+	pci_bus_read_config_word(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 2),
+		I5S_REG_AMAP, &amap);
+	if (!(amap & 0x60)) {
+		printk(KERN_DEBUG I5S_PREFIX
+			"SATA controller mode: NON AHCI (0x%04x)\n", amap);
+		amap &= ~BIT(7);
+		amap |= 0x60;
+	  printk(KERN_DEBUG I5S_PREFIX
+			"Restoring AHCI mode of SATA controller (0x%04x)\n",
+			amap);
+		/* MAP - Address Map Register:  AHCI mode + 6 SATA ports */
+		pci_bus_write_config_word(dev->bus,
+			PCI_DEVFN(PCI_SLOT(dev->devfn), 2), I5S_REG_AMAP,
+			amap);
+	} else {
+		printk(KERN_DEBUG I5S_PREFIX
+			"SATA controller mode: AHCI (0x%04x)\n", amap);
+	}
+}
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL, 0x3b09,
+	i5s_3400s_fixup_resume);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x3b09, i5s_3400s_fixup);
+
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 			  struct pci_fixup *end)
 {

--------------020608090204000404010907--
