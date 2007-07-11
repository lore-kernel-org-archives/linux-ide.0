From: Matt Sealey <matt@genesi-usa.com>
Subject: [PATCH] Native-mode fix for Pegasos pata_via
Date: Wed, 11 Jul 2007 15:54:00 +0100
Message-ID: <4694EF08.9000607@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:2983 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763057AbXGKOxJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 10:53:09 -0400
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk ([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>)
	id 1I8dJ3-000IXK-IG
	for linux-ide@vger.kernel.org; Wed, 11 Jul 2007 14:36:42 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

PATCH..

~

Pegasos currently sets it's IDE controller to PCI native mode but leaves the
ISA IDE IRQ steering set to 14/15 and IDE Interrupt Routing to compatibility
mode to keep compatibility with some old broken block drivers.

Rather than clutter up libata with such things for one platform, the fix is
to force the controller into native mode here.

We only enable this fix if we are using libata drivers, to avoid breaking
the old block driver as was the intention of the firmware configuration.
Currently won't work if the IDE interrupt line isn't set to 14, however the
chances of this happening on Pegasos are very slim. It just makes the fixup
easier.

~

This is TOTALLY untested but it does compile just fine. If anyone could throw
in some suggestions it would be awesome. Testing the patch (minus the checks
for pata_via being compiled) with via86cxxx would be great too. I just don't
have a Pegasos I or II handy here to run any of this.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

--- arch/powerpc/kernel/prom_init.c.orig	2007-07-11 15:02:07.000000000 +0000
+++ arch/powerpc/kernel/prom_init.c	2007-07-11 15:04:17.000000000 +0000
@@ -2081,9 +2081,14 @@ static void __init fixup_device_tree_chr
 		prom_printf("Fixing up IDE interrupt on Pegasos...\n");
 		prop[0] = 14;
 		prop[1] = 0x0;
+#if !defined(CONFIG_PATA_VIA) && !defined(CONFIG_PATA_VIA_MODULE)
 		prop[2] = 15;
 		prop[3] = 0x0;
 		prom_setprop(ph, name, "interrupts", prop, 4*sizeof(u32));
+#else
+		prom_setprop(ph, name, "interrupts", prop, 2*sizeof(u32));
+#endif
+
 	}
 }
 #else
--- arch/powerpc/platforms/chrp/pci.c.orig	2007-07-11 15:38:52.000000000 +0000
+++ arch/powerpc/platforms/chrp/pci.c	2007-07-11 15:39:40.000000000 +0000
@@ -338,3 +338,74 @@ void chrp_pci_fixup_winbond_ata(struct p
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 		chrp_pci_fixup_winbond_ata);
+
+#if defined(CONFIG_PATA_VIA) || defined(CONFIG_PATA_VIA_MODULE)
+void chrp_pci_vt8231_ide_fixup(struct pci_dev *viaide)
+{
+	u8 irq, progif;
+	struct pci_dev *viaisa;
+
+	/* only matters on Pegasos, for now */
+	if (!machine_is(chrp) || _chrp_type != _CHRP_Pegasos)
+		return;
+
+	/*
+	   this is a very simple fixup and assumes that we want to use IRQ 14,
+	   so if the interrupt line isn't 14 then we should bail out now rather
+	   than break things even more.
+
+	   alternatively we could fix the controller to IRQ 14
+	*/
+	if (viaide->irq != 14)
+		return;
+	
+	if ((viaisa = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL))) {
+		printk("Fixing VIA IDE Interrupt Steering\n");
+
+		/*
+		   mask off the last 4 bits. This forces IRQ steering
+		   to 14 for both channels. This probably breaks compatibility
+		   mode and probably doesn't matter considering the next step
+		   but we do it anyway because we are neurotic.
+		*/
+		pci_read_config_byte(viaisa, 0x4a, &irq);
+		pci_write_config_byte(viaisa, 0x4a, irq & 0xf0);
+
+		/* make sure native interrupt routing is enabled */
+		pci_write_config_byte(viaide, 0x3d, 0x1);
+
+		/*
+		   we don't trust the setup of the chip so finally make sure it
+		   is actually in native mode by flipping those bits. Again,
+		   being neurotic.
+		*/
+		pci_read_config_byte(viaide, PCI_CLASS_PROG, &progif);
+		pci_write_config_byte(viaide, PCI_CLASS_PROG, progif | 0x5);
+
+		pci_dev_put(viaisa);
+	}
+		
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x0571, chrp_pci_vt8231_ide_fixup);
+#endif

