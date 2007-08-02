From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sc1200: always tune PIO
Date: Fri, 3 Aug 2007 00:46:57 +0200
Message-ID: <200708030046.57825.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:37975 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757145AbXHBWsq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 18:48:46 -0400
Received: by mu-out-0910.google.com with SMTP id i10so801784mue
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 15:48:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sc1200.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sc1200.c		Version 0.95	Jun 16 2007
+ * linux/drivers/ide/pci/sc1200.c		Version 0.96	Aug 2 2007
  *
  * Copyright (C) 2000-2002		Mark Lord <mlord@pobox.com>
  * Copyright (C)      2007		Bartlomiej Zolnierkiewicz
@@ -354,6 +354,9 @@ static void __devinit init_hwif_sc1200 (
 	hwif->set_pio_mode = &sc1200_set_pio_mode;
 	hwif->set_dma_mode = &sc1200_set_dma_mode;
 
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
 	if (hwif->dma_base == 0)
 		return;
 
