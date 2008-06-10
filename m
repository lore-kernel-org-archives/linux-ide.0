From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/14] ide: remove needless includes from ide-taskfile.c
Date: Tue, 10 Jun 2008 22:52:59 +0200
Message-ID: <20080610205259.18469.50696.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:30333 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251AbYFJUv3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:51:29 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669647gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:51:28 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   11 -----------
 1 file changed, 11 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -8,28 +8,17 @@
  *  The big the bad and the ugly.
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/errno.h>
-#include <linux/genhd.h>
-#include <linux/blkpg.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
-#include <linux/bitops.h>
-#include <linux/scatterlist.h>
 
-#include <asm/byteorder.h>
-#include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
