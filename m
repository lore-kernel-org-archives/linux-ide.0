From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/11] cs5530/sc1200: add PIO autotune fallback to ->ide_dma_check
Date: Sat, 4 Aug 2007 22:09:53 +0200
Message-ID: <200708042209.53572.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:12604 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbXHDUQL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1508326mue
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add PIO autotune fallback to ->ide_dma_check.

  Since cs5530/sc1200 allow separate PIO and DMA timings, and cs5530/sc1200
  always set ->autotune this change shouldn't have any other effect than
  bringing these drivers in-line with other host drivers wrt ->ide_dma_check
  implementations.

* Fix ->ide_dma_check to return "-1" if DMA cannot be set.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5530.c |    6 ++++--
 drivers/ide/pci/sc1200.c |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cs5530.c		Version 0.75	Aug 2 2007
+ * linux/drivers/ide/pci/cs5530.c		Version 0.76	Aug 3 2007
  *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2000			Mark Lord <mlord@pobox.com>
@@ -117,7 +117,9 @@ static int cs5530_config_dma(ide_drive_t
 	if (ide_tune_dma(drive))
 		return 0;
 
-	return 1;
+	ide_set_max_pio(drive);
+
+	return -1;
 }
 
 static void cs5530_set_dma_mode(ide_drive_t *drive, const u8 mode)
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sc1200.c		Version 0.96	Aug 2 2007
+ * linux/drivers/ide/pci/sc1200.c		Version 0.97	Aug 3 2007
  *
  * Copyright (C) 2000-2002		Mark Lord <mlord@pobox.com>
  * Copyright (C)      2007		Bartlomiej Zolnierkiewicz
@@ -208,7 +208,9 @@ static int sc1200_config_dma (ide_drive_
 	if (ide_tune_dma(drive))
 		return 0;
 
-	return 1;
+	ide_set_max_pio(drive);
+
+	return -1;
 }
 
 
