From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/8] ide: remove needless includes from ide-dma.c
Date: Tue, 02 Sep 2008 21:47:40 +0200
Message-ID: <20080902194740.14564.87638.sendpatchset@localhost.localdomain>
References: <20080902194711.14564.63625.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:11245 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbYIBTtq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Sep 2008 15:49:46 -0400
Received: by nf-out-0910.google.com with SMTP id d3so409609nfc.21
        for <linux-ide@vger.kernel.org>; Tue, 02 Sep 2008 12:49:45 -0700 (PDT)
In-Reply-To: <20080902194711.14564.63625.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |    8 --------
 1 file changed, 8 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -28,21 +28,13 @@
  * for supplying a Promise UDMA board & WD UDMA drive for this work!
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/init.h>
 #include <linux/ide.h>
-#include <linux/delay.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/io.h>
-#include <asm/irq.h>
 
 static const struct drive_list_entry drive_whitelist [] = {
 
