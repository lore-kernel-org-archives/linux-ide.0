From: Rudolph Pereira <rudolph@faex.net>
Subject: Re: sis5513.c patch
Date: Tue, 30 Aug 2005 06:07:02 +1000
Message-ID: <20050829200702.GA2236@localhost.localdomain>
References: <42A621BC.7040607@a-wing.co.uk> <58cb370e05060800276f3fc29c@mail.gmail.com> <42A6AB1B.8000800@a-wing.co.uk> <58cb370e05060801585b49020e@mail.gmail.com> <58cb370e05060802149b2f530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 109.82.233.220.exetel.com.au ([220.233.82.109]:30739 "EHLO
	faex.net") by vger.kernel.org with ESMTP id S1751493AbVH2UHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2005 16:07:16 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e05060802149b2f530@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: info@a-wing.co.uk, linux-ide@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(replying to an old thread, as a I just discovered it)

On Wed, Jun 08, 2005 at 11:14:45AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Second look into sis5513.c and another problem turns out - patch breaks 
> support for IDE controllers integrated into 961 and 961B South Bridges
> (ATA_133 is used instead of ATA_100 and ATA133a).
> 
> For unknown Host Bridges driver checks for presence of 961/961B/962/963
> South Bridges by checking true device ID (please see sis5513.c for details) 
> and assigns 'chipset_family' accordingly (ATA_100/ATA_133a or ATA_133).
> 
> You have 965L South Bridge so probably it has newer true device ID 
> and  may also require different programming sequence.
I also have an ASUS K8S-MX with a SiS 760GX/SiS 965L as in this thread.
The attached patch, modified from one for the 964L by Arnaud Patard/Uwe
Koziolek, against 2.6.13-rc6-mm2, works for me and should do things properly.

I've been running it for the last couple of days with a bit of heavy I/O
(testing) and have seen no problems as yet.

If anyone out there has one of these mb/chipset combos and could try to
see if it fixes anything, or if anyone has feedback, I'd be happy to
adjust the patch, etc.

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis5513-965.patch"

--- drivers/ide/pci/sis5513.c.orig	2005-08-27 12:37:26.000000000 +1000
+++ drivers/ide/pci/sis5513.c	2005-08-27 11:11:54.000000000 +1000
@@ -42,7 +42,7 @@
  * Fortunately the 5513 can be 'unmasked' by fiddling with some config space
  * bits, changing its device id to the true one - 5517 for 961 and 5518 for
  * 962/963.
- */
+ */ 
 
 #include <linux/config.h>
 #include <linux/types.h>
@@ -726,7 +726,7 @@
 */
 
 /* Chip detection and general config */
-static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
+static unsigned int __init init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *host;
 	int i = 0;
@@ -778,6 +778,15 @@
 					printk(KERN_INFO "SIS5513: Switching to 5513 register mapping\n");
 				}
 			}
+			else if (trueid == 0x180) { /* sis965L */
+				u16 pci_command;
+				pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+				pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+				pci_write_config_word(dev, PCI_COMMAND, pci_command);
+				chipset_family = ATA_133;
+				printk(KERN_INFO "SIS5513: SiS 965 IDE UDMA133 controller\n");
+			}
+
 	}
 
 	if (!chipset_family) { /* Belongs to pci-quirks */
@@ -879,7 +888,7 @@
 	return 0;
 }
 
-static unsigned int __devinit ata66_sis5513 (ide_hwif_t *hwif)
+static unsigned int __init ata66_sis5513 (ide_hwif_t *hwif)
 {
 	u8 ata66 = 0;
 
@@ -897,7 +906,7 @@
         return ata66;
 }
 
-static void __devinit init_hwif_sis5513 (ide_hwif_t *hwif)
+static void __init init_hwif_sis5513 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 
@@ -952,6 +961,7 @@
 static struct pci_device_id sis5513_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+        { PCI_VENDOR_ID_SI, 0x180,                 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);

--nFreZHaLTZJo0R7j--
