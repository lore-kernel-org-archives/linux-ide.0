From: Bernhard Froemel <froemel@vmars.tuwien.ac.at>
Subject: Re: Allow (forced) AHCI mode on Intel 5 series, 3400 series chipsets
Date: Mon, 08 Aug 2011 13:53:20 +0200
Message-ID: <4E3FCE30.1060605@vmars.tuwien.ac.at>
References: <4E3D9EF9.4050906@vmars.tuwien.ac.at> <20110808100731.GI23937@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000705060106020808000903"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from luna.vmars.tuwien.ac.at ([128.130.39.29]:42829 "EHLO
	mail.vmars.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab1HHMAG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Aug 2011 08:00:06 -0400
In-Reply-To: <20110808100731.GI23937@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, joerg@dorchain.net, sshtylyov@mvista.com

This is a multi-part message in MIME format.
--------------000705060106020808000903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,
On 08/08/2011 12:07 PM, Tejun Heo wrote:
> Hello,
> 
Thanks for your comments!

> On Sat, Aug 06, 2011 at 10:07:21PM +0200, Bernhard Froemel wrote:
>> +static int __init i5s_3400s_force_ahci_setup(char *str)
>> +{
>> +	if (!strcmp(str, "1"))
>> +		i5s_3400s_force_ahci = 1;
>> +	return 0;
>> +}
>> +early_param("i5s_3400s_force_ahci", i5s_3400s_force_ahci_setup);
> 
> Just setting variable if the parameter is specified would be enough.
I wanted to catch cases like 'i5s_3400s_force_ahci=0', but I can see
that this is probably not a problem.

>> +static void i5s_3400s_fixup_resume(struct pci_dev *dev)
>> [...]
>> +}
> 
> Shouldn't the resume fixup also check force_ahci?  It looks like it
> would put the controller into ahci mode even if it was in ide mode
> during boot.
Right you are; I have no idea how that ended up wrong - I should
probably really don't make any changes after I tested the patch.
Attached the revised and tested patch.

> 
> At any rate, unless there's a broken BIOS which boots into ahci mode
> but resumes into ide mode, I personally don't feel too enthusiastic
> about forcing the controller into ahci mode depending on a kernel
> paramster.  
I renamed the force variable and it should be clearer now:

case a) EFI/bios is not broken and correctly restores the SATA
controller mode before control is given back to the kernel:
The patch has no influence beside when the user decides to supply the
kernel parameter '': Then this patch will put the SATA controller into
AHCI mode during boot and will correctly handle resume.

case b) EFI/bios does not allow to set AHCI and/or does not restore AHCI
(e.g., Apple systems based on that chipset) on resume: The patch enables
AHCI usage on those systems. Without the patch you could previously only
put the SATA controller into AHCI by means of a bootloader -- but then
you still can't resume, because the controller is in the wrong mode
after resume.

> If it can be decided automatically and enabled by default,
> for sure.  If not, it's not gonna be all that useful anyway.
Unfortunately, we'd need to e.g. evaluate DMI info to limit the patch to
systems which are known to not provide an AHCI configuration option in
there EFI/bios. Also we still need some means to tell the kernel whether
to put the SATA controller into AHCI or remain in the default (IDE)
mode: a kernel command parameter crossed my mind first.

Additional to my original submission I ensured to only set the
controller into AHCI mode when it's according to the datasheet 'safe'.

Thanks,
  Bernhard

--------------000705060106020808000903
Content-Type: text/x-patch;
 name="i5s_3400s_ahci_handling_for_incapable_efi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i5s_3400s_ahci_handling_for_incapable_efi.patch"

Signed-off-by: Bernhard Froemel <froemel@vmars.tuwien.ac.at>
--- a/drivers/pci/quirks.c	2011-07-22 04:17:23.000000000 +0200
+++ b/drivers/pci/quirks.c	2011-08-08 13:37:54.459428437 +0200
@@ -2799,6 +2799,87 @@
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
+static int i5s_3400s_sata_ahci;
+
+static int __init i5s_3400s_force_ahci_setup(char *str)
+{
+	i5s_3400s_sata_ahci = 1;
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
+		i5s_3400s_sata_ahci = 1;
+	} else {
+		printk(KERN_DEBUG I5S_PREFIX
+			"SATA controller mode: NON AHCI (0x%04x)\n", amap);
+		/* only honor i5s_3400s_sata ahci if the controller is
+		in a mode were it's safe (IDE Mode, MV == 0x0) to
+		switch to AHCI */
+		if (i5s_3400s_sata_ahci && (amap & 0xC3) == 0) {
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
+		if (i5s_3400s_sata_ahci && (amap & 0xc3) == 0) {
+			amap &= ~BIT(7);
+			amap |= 0x60;
+			printk(KERN_DEBUG I5S_PREFIX
+				"Restoring AHCI mode of SATA controller (0x%04x)\n",
+				amap);
+			/* MAP - Address Map Register:  AHCI mode + 6 SATA
+			ports */
+			pci_bus_write_config_word(dev->bus,
+				PCI_DEVFN(PCI_SLOT(dev->devfn), 2),
+				I5S_REG_AMAP, amap);
+		}
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

--------------000705060106020808000903--
