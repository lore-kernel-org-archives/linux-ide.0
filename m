From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ide/generic: Jmicron has its own drivers now
Date: Mon, 8 Jan 2007 12:19:47 +0000
Message-ID: <20070108121947.04728240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:56499 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751485AbXAHMJF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Jan 2007 07:09:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Drop ide-generic support for Jmicron identifiers as we now trust
Jmicron.c for this with drivers/ide. The code check remains for
the all-generic-ide case.

[Please push to Linus post 2.6.20]


Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.20-rc3-mm1/drivers/ide/pci/generic.c	2007-01-05 13:08:30.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ide/pci/generic.c	2007-01-08 11:52:36.154460816 +0000
@@ -185,36 +185,6 @@
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
-	},{	/* 15 */
-		.name		= "JMB361",
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 16 */
-		.name		= "JMB363",
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 17 */
-		.name		= "JMB365",
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 18 */
-		.name		= "JMB366",
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{	/* 19 */
-		.name		= "JMB368",
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
 	}
 };
 
@@ -281,11 +251,6 @@
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
 	{ PCI_VENDOR_ID_NETCELL,PCI_DEVICE_ID_REVOLUTION,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
 	/* Must come last. If you add entries adjust this table appropriately and the init_one code */
 	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
 	{ 0, },
