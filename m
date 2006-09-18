From: Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH] Fix libata resource conflict for legacy mode
Date: Mon, 18 Sep 2006 15:16:04 +0200
Message-ID: <m3ac4xiacr.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:22537 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S965243AbWIRNFp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Sep 2006 09:05:45 -0400
Received: from anduin.mandriva.com (anduin.mandriva.com [192.168.100.45])
	by office.mandriva.com (Postfix) with ESMTP id 1D0123C7
	for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 15:05:44 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id B4C5AFF855
	for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 15:16:04 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--=-=-=

Hi,

Someone reported a bug about not being able to use his box with ICH6
chipset unless booting with PnP disabled on the kernel command-line.

When failing, he had in the logs :

ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 21
ata: 0x1f0 IDE port busy


After some debugging, it turns out that with PnP activated the resources
are looking like this : 

0100-01fe : pnp 00:09
  0170-0177 : libata
  01f0-01f7 : libata

Thus, with the check done in libata, it finds "pnp 00:09" instead of
"libata" and fails.
The quick fix I made for this is to check wether the resource has a
child or not and then check which child is conflicting.

This patch was tested on 2.6.17 but I rediffed it for 2.6.18-git as the
same bug will likely occur. Of course, if preferred, I can rediff it for
libata#upstream.
Also, I added some printks to print the name of the conflicting resource
but this can also be removed if preferred.


Regards,
Arnaud


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=2618git_libata_vs_pnp.patch

When the libata is trying to handle legacy ide ports (0x1f0 for instance), it
doesn't take care if the resource has childs or not. 
The result is that this situation :
0100-01fe : pnp 00:09
  0170-0177 : libata
  01f0-01f7 : libata

is seen as conflict, which is wrong. The 'pnp 00:09' part is there due to the 
PnP support. If PnP support is off, this doesn't appear.

The proposed fix is to detect childs and in this case, look at which child is
conflicting.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

Index: linux-2.6/drivers/scsi/libata-bmdma.c
===================================================================
--- linux-2.6.orig/drivers/scsi/libata-bmdma.c
+++ linux-2.6/drivers/scsi/libata-bmdma.c
@@ -1016,10 +1016,13 @@ int ata_pci_init_one (struct pci_dev *pd
 			res.start = 0x1f0;
 			res.end = 0x1f0 + 8 - 1;
 			conflict = ____request_resource(&ioport_resource, &res);
+			if (conflict->child)
+				conflict = ____request_resource(conflict,&res);
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= (1 << 0);
 			else {
 				disable_dev_on_err = 0;
+				printk(KERN_WARNING "ata: conflict with %s\n",conflict->name);
 				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
 			}
 		} else
@@ -1030,10 +1033,13 @@ int ata_pci_init_one (struct pci_dev *pd
 			res.start = 0x170;
 			res.end = 0x170 + 8 - 1;
 			conflict = ____request_resource(&ioport_resource, &res);
+			if (conflict->child)
+				conflict = ____request_resource(conflict,&res);
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= (1 << 1);
 			else {
 				disable_dev_on_err = 0;
+				printk(KERN_WARNING "ata: conflict with %s\n",conflict->name);
 				printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
 			}
 		} else

--=-=-=--

