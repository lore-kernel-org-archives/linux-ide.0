From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: Marvell PATA IDE Controller
Date: Sat, 12 Aug 2006 19:22:10 +0200
Message-ID: <20060812172210.GB3061@mail.muni.cz>
References: <20060809113650.GA2959@mail.muni.cz> <1155127850.5729.164.camel@localhost.localdomain> <20060809134249.GE2959@mail.muni.cz> <1155134187.5729.173.camel@localhost.localdomain> <20060809190118.GG2959@mail.muni.cz> <1155154123.5729.257.camel@localhost.localdomain> <20060809200740.GH2959@mail.muni.cz> <1155161129.5729.267.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from igw1.zrnko.cz ([81.31.45.161]:11670 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S964927AbWHLRWE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Aug 2006 13:22:04 -0400
Content-Disposition: inline
In-Reply-To: <1155161129.5729.267.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Aug 09, 2006 at 11:05:29PM +0100, Alan Cox wrote:
> ide-generic probes all IDE class devices if all-generic-ide is passed.

I managed to get Marvell 614x PATA controller to be recognized by generic
driver. It works pretty well. Marvell 614x (PCI ID 6101) is present in Intel
DP965LT main board and probably also in other Dx965xx boards (as the only legacy
PATA interface).

-- 
Luká¹ Hejtmánek

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="marvell.patch"

--- /usr/src/linux-2.6.18-rc4/drivers/ide/pci/generic.c	2006-08-06 20:20:11.000000000 +0200
+++ generic.c	2006-08-11 19:27:05.000000000 +0200
@@ -180,7 +180,13 @@
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
-	}
+	},{     /* 15 */
+		.name           = "Marvell-PATA",
+		.init_hwif      = init_hwif_generic,
+		.channels       = 1,
+		.autodma        = AUTODMA,
+		.bootable       = ON_BOARD,
+        }
 };
 
 /**
@@ -242,11 +248,12 @@
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
 	{ PCI_VENDOR_ID_NETCELL,PCI_DEVICE_ID_REVOLUTION,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
+        { PCI_VENDOR_ID_MARVELL, 0x6101, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
 	/* Must come last. If you add entries adjust this table appropriately and the init_one code */
 	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
 	{ 0, },

--tKW2IUtsqtDRztdT--
