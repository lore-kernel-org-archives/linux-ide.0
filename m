From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6 fix] hpt366: use correct enablebits for HPT36x
Date: Sat, 30 Jun 2007 00:04:22 +0400
Message-ID: <200706300004.22274.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:40242 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1752227AbXF2UCn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 16:02:43 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, michal.kepien@poczta.onet.pl, linas@austin.ibm.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

The HPT36x chips finally turned out to have the channel enable bits -- however,
badly implemented.  Make use of them despite it's probably only going to burden
the driver's code -- assuming both channels are always enabled by the HighPoint
BIOS anyway...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Michal, Linas, please verify the patch... :-)

 drivers/ide/pci/hpt366.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.05	Jun 26, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.06	Jun 27, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -1514,18 +1514,28 @@ static int __devinit init_setup_hpt366(s
 		goto init_single;
 
 	/*
-	 * HPT36x chips are single channel and
-	 * do not seem to have the channel enable bit...
+	 * HPT36x chips have one channel per function and have
+	 * both channel enable bits located differently and visible
+	 * to both functions -- really stupid design decision... :-(
+	 * Bit 4 is for the primary channel, bit 5 for the secondary.
 	 */
 	d->channels = 1;
-	d->enablebits[0].reg = 0;
+	d->enablebits[0].mask = d->enablebits[0].val = 0x10;
 
 	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
-	  	u8  pin1 = 0, pin2 = 0;
+	  	u8  mcr1 = 0, pin1 = 0, pin2 = 0;
 		int ret;
 
 		pci_set_drvdata(dev2, info[rev]);
 
+		/*
+		 * Now we'll have to force both channels enabled if
+		 * at least one of them has been enabled by BIOS...
+		 */
+		pci_read_config_byte(dev, 0x50, &mcr1);
+		if (mcr1 & 0x30)
+			pci_write_config_byte(dev, 0x50, mcr1 | 0x30);
+
 		pci_read_config_byte(dev,  PCI_INTERRUPT_PIN, &pin1);
 		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
 		if (pin1 != pin2 && dev->irq == dev2->irq) {

