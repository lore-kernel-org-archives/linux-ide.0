From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/9] ht6560b: use driver name for resource allocation
Date: Sat, 16 Feb 2008 21:27:15 +0100
Message-ID: <20080216202715.25536.60906.sendpatchset@localhost.localdomain>
References: <20080216202634.25536.78915.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:14552 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759524AbYBPUMm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 15:12:42 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1181335fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 12:12:41 -0800 (PST)
In-Reply-To: <20080216202634.25536.78915.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ht6560b.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -32,6 +32,7 @@
  *  Try:  http://www.maf.iki.fi/~maf/ht6560b/
  */
 
+#define DRV_NAME	"ht6560b"
 #define HT6560B_VERSION "v0.07"
 
 #include <linux/module.h>
@@ -339,7 +340,7 @@ static int __init ht6560b_init(void)
 	hwif = &ide_hwifs[0];
 	mate = &ide_hwifs[1];
 
-	if (!request_region(HT_CONFIG_PORT, 1, hwif->name)) {
+	if (!request_region(HT_CONFIG_PORT, 1, DRV_NAME)) {
 		printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
 			__FUNCTION__);
 		return -ENODEV;
