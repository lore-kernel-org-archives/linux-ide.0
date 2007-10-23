From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cy82c693: fix build for CONFIG_HOTPLUG=n
Date: Tue, 23 Oct 2007 22:57:33 +0200
Message-ID: <200710232257.34137.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:63608 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbXJWVbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 17:31:21 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2723487mue
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 14:31:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Avuton Olrich <avuton@gmail.com>, Randy Dunlap <randy.dunlap@oracle.com>


On Saturday 20 October 2007, Avuton Olrich wrote:

> My randconfig script the attached config caught an error on:
> drivers/ide/pci/cy82c693.c:439: error: primary causes a section type conflict
>
> My git tree: c00046c279a2521075250fad682ca0acc10d4fd7
>
> Bisected to:
> 8562043606430185cad26d085d46adcc7ad67fd1 is first bad commit
> commit 8562043606430185cad26d085d46adcc7ad67fd1
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Sat Oct 20 00:32:34 2007 +0200
>
>     ide: constify struct ide_port_info
>
>     Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

It turns out that const and __{dev}initdata cannot be mixed currently.

This patch workarounds the problem by removing __devinitdata tag from 'primary'
variable (which makes 'primary' to be moved from .init.data to .bss section).
Now all __devinitdata data in cy82c693 host driver are read-only so it builds
again (driver's .init.data section gets marked as READONLY).

While at it:

* Move 'primary' variable to its only user, init_iops_cy82c693().

* Bump driver version.

Cc: "Avuton Olrich" <avuton@gmail.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Even if we decide to revert commit 8562043606430185cad26d085d46adcc7ad67fd1
later it is worth to have the (independent) changes contained in this patch.

 drivers/ide/pci/cy82c693.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cy82c693.c		Version 0.41	Aug 27, 2007
+ * linux/drivers/ide/pci/cy82c693.c		Version 0.42	Oct 23, 2007
  *
  *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), Maintainer
  *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integrator
@@ -436,10 +436,10 @@ static void __devinit init_hwif_cy82c693
 	hwif->ide_dma_on = &cy82c693_ide_dma_on;
 }
 
-static __devinitdata ide_hwif_t *primary;
-
 static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
 {
+	static ide_hwif_t *primary;
+
 	if (PCI_FUNC(hwif->pci_dev->devfn) == 1)
 		primary = hwif;
 	else {
