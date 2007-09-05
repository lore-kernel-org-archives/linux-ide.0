From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/13] opti621: always tune PIO
Date: Wed, 5 Sep 2007 23:56:09 +0200
Message-ID: <200709052356.09790.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:1445 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbXIEV66 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:58 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828166nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/opti621.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/opti621.c		Version 0.7	Sept 10, 2002
+ *  linux/drivers/ide/pci/opti621.c		Version 0.8	Aug 27, 2007
  *
  *  Copyright (C) 1996-1998  Linus Torvalds & authors (see below)
  */
@@ -57,9 +57,6 @@
  * There is a 25/33MHz switch in configuration
  * register, but driver is written for use at any frequency which get
  * (use idebus=xx to select PCI bus speed).
- * Use hda=autotune and hdb=autotune for automatical tune of the PIO modes.
- * If you get strange results, do not use this and set PIO manually
- * by hdparm.
  *
  * Version 0.1, Nov 8, 1996
  * by Jaromir Koutek, for 2.1.8. 
@@ -332,6 +329,9 @@ static void __devinit init_hwif_opti621 
 	hwif->drives[1].drive_data = PIO_DONT_KNOW;
 
 	hwif->set_pio_mode = &opti621_set_pio_mode;
+
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
 }
 
 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
