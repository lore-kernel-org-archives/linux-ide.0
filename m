From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] siimage: PIO1/2 taskfile transfer overclocking fix
Date: Sun, 28 Jan 2007 23:46:55 +0300
Message-ID: <200701282346.55935.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:16504 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932837AbXA1UrB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 15:47:01 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Fix two typos found by SiI680A documentation check.  They caused the taskfile
transfer overclocking:

- in PIO mode 1 as 0x2283 must be used for both data and taskfile transfers;

- in PIO mode 2 as data and taskfile timings are swapped when writing to the
  MMIO regs.

Fix coding style and trailing whitespace in enclosing statements while at it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/siimage.c |   59 ++++++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 30 deletions(-)

Index: linux-2.6/drivers/ide/pci/siimage.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/siimage.c
+++ linux-2.6/drivers/ide/pci/siimage.c
@@ -1,8 +1,9 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.07	Nov 30, 2003
+ * linux/drivers/ide/pci/siimage.c		Version 1.11	Jan 27, 2007
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
+ * Copyright (C) 2007		MontaVista Software, Inc.
  *
  *  May be copied or modified under the terms of the GNU General Public License
  *
@@ -205,41 +206,39 @@ static void siimage_tuneproc (ide_drive_
 	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
 	
 	/* cheat for now and use the docs */
-	switch(mode_wanted) {
-		case 4:	
-			speedp = 0x10c1; 
-			speedt = 0x10c1;
-			break;
-		case 3:	
-			speedp = 0x10C3; 
-			speedt = 0x10C3;
-			break;
-		case 2:	
-			speedp = 0x1104; 
-			speedt = 0x1281;
-			break;
-		case 1:		
-			speedp = 0x2283; 
-			speedt = 0x1281;
-			break;
-		case 0:
-		default:
-			speedp = 0x328A; 
-			speedt = 0x328A;
-			break;
+	switch (mode_wanted) {
+	case 4:
+		speedp = 0x10c1;
+		speedt = 0x10c1;
+		break;
+	case 3:
+		speedp = 0x10c3;
+		speedt = 0x10c3;
+		break;
+	case 2:
+		speedp = 0x1104;
+		speedt = 0x1281;
+		break;
+	case 1:
+		speedp = 0x2283;
+		speedt = 0x2283;
+		break;
+	case 0:
+	default:
+		speedp = 0x328a;
+		speedt = 0x328a;
+		break;
 	}
-	if (hwif->mmio)
-	{
-		hwif->OUTW(speedt, addr);
-		hwif->OUTW(speedp, tfaddr);
+
+	if (hwif->mmio) {
+		hwif->OUTW(speedp, addr);
+		hwif->OUTW(speedt, tfaddr);
 		/* Now set up IORDY */
 		if(mode_wanted == 3 || mode_wanted == 4)
 			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
 		else
 			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
-	}
-	else
-	{
+	} else {
 		pci_write_config_word(hwif->pci_dev, addr, speedp);
 		pci_write_config_word(hwif->pci_dev, tfaddr, speedt);
 		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);

