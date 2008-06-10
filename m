From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/14] ide: remove needless includes from ide.c
Date: Tue, 10 Jun 2008 22:52:49 +0200
Message-ID: <20080610205249.18469.5758.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:29680 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbYFJUvN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:51:13 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669622gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:51:11 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   13 -------------
 1 file changed, 13 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -50,29 +50,16 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
-#include <linux/blkpg.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/completion.h>
-#include <linux/reboot.h>
-#include <linux/cdrom.h>
-#include <linux/seq_file.h>
 #include <linux/device.h>
-#include <linux/bitops.h>
-
-#include <asm/byteorder.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
 
 
 /* default maximum number of failures */
