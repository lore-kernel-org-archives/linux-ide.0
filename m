From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove unused macros from <asm-parisc/ide.h>
Date: Sun, 10 Aug 2008 17:47:07 +0200
Message-ID: <200808101747.08025.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:15451 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbYHJPtx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Aug 2008 11:49:53 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1417867fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 08:49:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>


Cc: Kyle McMartin <kyle@mcmartin.ca>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/asm-parisc/ide.h |    4 ----
 1 file changed, 4 deletions(-)

Index: b/include/asm-parisc/ide.h
===================================================================
--- a/include/asm-parisc/ide.h
+++ b/include/asm-parisc/ide.h
@@ -13,10 +13,6 @@
 
 #ifdef __KERNEL__
 
-#define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
-#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
-#define ide_request_region(from,extent,name)	request_region((from), (extent), (name))
-#define ide_release_region(from,extent)		release_region((from), (extent))
 /* Generic I/O and MEMIO string operations.  */
 
 #define __ide_insw	insw
