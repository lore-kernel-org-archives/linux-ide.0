From: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sis5513 fix for SiS962 chipset
Date: Fri, 10 Sep 2004 16:29:16 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61083
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267413AbUIJOgh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Sep 2004 10:36:37 -0400
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>

Hi,

1. If the fake 5513 id bit is not set by the BIOS we must have the 5518
id in the device table.

2. If the register remapping is not set by the BIOS then the enable bit
check in ide_pci_setup_ports will fail. It's safe to switch to the
remapping mode here. Keeping the not remapped mode would need quite big
changes AFAICS.

Works with 2.4.27 and 2.6.8. Please apply.

tglx
________________________________________________________________________
SCO: Linux does not exist
Linux: SCO's claim does not exist
Wallstreet: SCO does not exist for long
________________________________________________________________________

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff -urN linux-2.6.8.1.org/drivers/ide/pci/sis5513.c
linux-2.6.8.1/drivers/ide/pci/sis5513.c
--- linux-2.6.8.1.org/drivers/ide/pci/sis5513.c	2004-08-14
12:55:32.000000000 +0200
+++ linux-2.6.8.1/drivers/ide/pci/sis5513.c	2004-09-10
15:50:50.000000000 +0200
@@ -788,6 +788,15 @@
 			if (trueid == 0x5518) {
 				printk(KERN_INFO "SIS5513: SiS 962/963 MuTIOL IDE UDMA133
controller\n");
 				chipset_family = ATA_133;
+				
+				/* Check for 5513 compability mapping 
+				 * We must use this, else the port enabled code will fail,
+				 * as it expects the enablebits at 0x4a. 
+				 */
+				if (!(idemisc & 0x40000000)) {
+					pci_write_config_dword(dev, 0x54, idemisc | 0x40000000);
+					printk (KERN_INFO "SIS5513: Switching to 5513 register
mapping\n");
+				}
 			}
 	}
 
@@ -963,6 +972,7 @@
 
 static struct pci_device_id sis5513_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0,
0, 0},
+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0,
0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);




