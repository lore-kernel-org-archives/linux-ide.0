From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/10] rz1000: set serialized flag only if mate interface exists
Date: Tue, 11 Sep 2007 23:37:07 +0200
Message-ID: <200709112337.07455.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:27120 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681AbXIKVkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:18 -0400
Received: by ug-out-1314.google.com with SMTP id z38so138055ugc
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Setting hwif->serialized makes sense only if the mate interface exists.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/rz1000.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/rz1000.c
===================================================================
--- a/drivers/ide/pci/rz1000.c
+++ b/drivers/ide/pci/rz1000.c
@@ -41,7 +41,8 @@ static void __devinit init_hwif_rz1000 (
 		printk(KERN_INFO "%s: disabled chipset read-ahead "
 			"(buggy RZ1000/RZ1001)\n", hwif->name);
 	} else {
-		hwif->serialized = 1;
+		if (hwif->mate)
+			hwif->mate->serialized = hwif->serialized = 1;
 		hwif->drives[0].no_unmask = 1;
 		hwif->drives[1].no_unmask = 1;
 		printk(KERN_INFO "%s: serialized, disabled unmasking "
