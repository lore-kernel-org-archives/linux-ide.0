From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Small fixes backported to old IDE SiS driver
Date: Tue, 03 Jan 2006 15:19:41 +0000
Message-ID: <1136301581.22598.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:43712 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932398AbWACPR5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 10:17:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org

Some quick backport bits from the libata PATA work to fix things found
in the sis driver. The piix driver needs some fixes too but those are
way to large and need someone working on old IDE with time to do them.

This patch fixes the case where random bits get loaded into SIS timing
registers according to the description of the correct behaviour from
Vojtech Pavlik. It also adds the SiS5517 ATA16 chipset which is not
currently supported by the driver. Thanks to Conrad Harriss for loaning
me the machine with the 5517 chipset.

Alan


Signed-off-by: Alan Cox <alan@redhat.com>

--- drivers/ide/pci/sis5513.c~	2006-01-03 15:01:24.753952872 +0000
+++ drivers/ide/pci/sis5513.c	2006-01-03 15:01:24.753952872 +0000
@@ -111,6 +111,7 @@
 
 	{ "SiS5596",	PCI_DEVICE_ID_SI_5596,	ATA_16   },
 	{ "SiS5571",	PCI_DEVICE_ID_SI_5571,	ATA_16   },
+	{ "SiS5517",	PCI_DEVICE_ID_SI_5517,	ATA_16   },
 	{ "SiS551x",	PCI_DEVICE_ID_SI_5511,	ATA_16   },
 };
 
@@ -523,6 +524,7 @@
 			case 3:		test1 = 0x30|0x03; break;
 			case 2:		test1 = 0x40|0x04; break;
 			case 1:		test1 = 0x60|0x07; break;
+			case 0:		test1 = 0x00; break;
 			default:	break;
 		}
 		pci_write_config_byte(dev, drive_pci, test1);
--- include/linux/pci_ids.h~	2006-01-03 15:00:52.835805168 +0000
+++ include/linux/pci_ids.h	2006-01-03 15:00:52.836805016 +0000
@@ -632,6 +632,7 @@
 #define PCI_DEVICE_ID_SI_963		0x0963
 #define PCI_DEVICE_ID_SI_5511		0x5511
 #define PCI_DEVICE_ID_SI_5513		0x5513
+#define PCI_DEVICE_ID_SI_5517		0x5517
 #define PCI_DEVICE_ID_SI_5518		0x5518
 #define PCI_DEVICE_ID_SI_5571		0x5571
 #define PCI_DEVICE_ID_SI_5581		0x5581

