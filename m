From: y3kniceday <y3kniceday@tin.it>
Subject: Re: vt8251 patch= dma works
Date: Wed, 23 Nov 2005 11:43:23 +0000
Message-ID: <dm1gu4$vi0$1@sea.gmane.org>
References: <loom.20051122T191414-917@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030308000104030105010803"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57265 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030392AbVKWKnv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Nov 2005 05:43:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ees4v-0000uJ-BE
	for linux-ide@vger.kernel.org; Wed, 23 Nov 2005 11:42:17 +0100
Received: from ppp-62-11-132-41.dialup.tiscali.it ([62.11.132.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2005 11:42:17 +0100
Received: from y3kniceday by ppp-62-11-132-41.dialup.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2005 11:42:17 +0100
In-Reply-To: <loom.20051122T191414-917@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030308000104030105010803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

y3kniceday wrote:
> DMA works with this patch on kernel 2.6.12.4 but sata don't works!
> dmesg says:
> libata version 1.11 loaded.
> sata_via version 1.1
> sata_via(0000:00:0f.0): routed to hard irq line 10
> ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xEC0A bmdma 0xE400 irq 10
> ata2: SATA max UDMA/133 cmd 0xE880 ctl 0xE88A bmdma 0xE408 irq 10
> ata1: no device found (phy stat 00200008)
> scsi0 : sata_via
> ata2: no device found (phy stat ffffffff)
> scsi1 : sata_via
> 
> and i have an hd on ata1. 
> 
> patch:
> http://prcsanmarco.altervista.org/dma-sata.diff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
the patch:


--------------030308000104030105010803
Content-Type: text/plain;
 name="dma-sata.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma-sata.diff"

--- drivers/ide/pci/via82cxxx.c	2005-08-08 11:10:03.000000000 +0000
+++ drivers/ide/pci/via82cxxx.c	2005-11-22 14:37:42.000000000 +0000
@@ -81,6 +81,7 @@
 } via_isa_bridges[] = {
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },

--- include/linux/pci_ids.h	2005-08-08 11:10:15.000000000 +0000
+++ include/linux/pci_ids.h	2005-11-22 14:24:47.000000000 +0000
@@ -1405,6 +1405,7 @@
 #define PCI_DEVICE_ID_VIA_8783_0	0x3208
 #define PCI_DEVICE_ID_VIA_P4M400	0x3209
 #define PCI_DEVICE_ID_VIA_8237		0x3227
+#define PCI_DEVICE_ID_VIA_8251          0x3287
 #define PCI_DEVICE_ID_VIA_3296_0	0x0296
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231

--- drivers/pci/pci.ids	2005-08-08 11:10:07.000000000 +0000
+++ drivers/pci/pci.ids	2005-11-22 13:08:12.000000000 +0000
@@ -4027,6 +4027,7 @@
 1106  VIA Technologies, Inc.
 	0102  Embedded VIA Ethernet Controller
 	0130  VT6305 1394.A Controller
+	0204  K8M800
 	0305  VT8363/8365 [KT133/KM133]
 		1043 8033  A7V Mainboard
 		1043 803e  A7V-E Mainboard
@@ -4085,8 +4086,10 @@
 	0926  VT82C926 [Amazon]
 	1000  VT82C570MV
 	1106  VT82C570MV
+	1204  K8M800
 	1571  VT82C576M/VT82C586
 	1595  VT82C595/97 [Apollo VP2/97]
+	2204  K8M800
 	3022  CLE266
 # This is *not* USB 2.0 as the existing entry suggests
 	3038  VT82xxxxx UHCI USB 1.1 Controller
@@ -4221,7 +4224,10 @@
 		1458 5001  GA-7VT600 Motherboard
 		147b 1407  KV8-MAX3 motherboard
 	3249  VT6421 IDE RAID Controller
+	3287  VT8251 ISA
+	3349  VT8251 SATA
 	4149  VIA VT6420 (ATA133) Controller
+	4204  K8M800
 	5030  VT82C596 ACPI [Apollo PRO]
 	6100  VT85C100A [Rhine II]
 	7204  K8M800

--- drivers/scsi/sata_via.c	2005-08-08 11:10:09.000000000 +0000
+++ drivers/scsi/sata_via.c	2005-11-22 17:04:14.000000000 +0000
@@ -48,6 +48,7 @@
 enum board_ids_enum {
 	vt6420,
 	vt6421,
+	vt8251,
 };
 
 enum {
@@ -74,6 +75,8 @@
 static struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
 	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
+	{ 0x1106, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt8251 },
+
 
 	{ }	/* terminate list */
 };
@@ -170,6 +173,10 @@
 	8, 4, 8, 4, 16, 256
 };
 
+static const unsigned int vt8251_bar_sizes[] = {
+	8, 4, 8, 4, 16, 256
+};
+
 static const unsigned int vt6421_bar_sizes[] = {
 	16, 16, 16, 16, 32, 128
 };
@@ -322,7 +329,7 @@
 
 		bar_sizes = &svia_bar_sizes[0];
 	} else {
-		bar_sizes = &vt6421_bar_sizes[0];
+		bar_sizes = &vt8251_bar_sizes[0];//bar_sizes = &vt6421_bar_sizes[0];
 	}
 
 	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
--------------030308000104030105010803--

