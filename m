From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] palm_bk3710: add warm-plug support
Date: Sun, 8 Jun 2008 20:09:41 +0200
Message-ID: <200806082009.41844.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:19404 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbYFHSJd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jun 2008 14:09:33 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1273130mue.1
        for <linux-ide@vger.kernel.org>; Sun, 08 Jun 2008 11:09:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Don't fail the probe if there are no devices attached to the controller.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/palm_bk3710.c |    3 ---
 1 file changed, 3 deletions(-)

Index: b/drivers/ide/arm/palm_bk3710.c
===================================================================
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -405,9 +405,6 @@ static int __devinit palm_bk3710_probe(s
 
 	ide_device_add(idx, &palm_bk3710_port_info);
 
-	if (!hwif->present)
-		goto out;
-
 	return 0;
 out:
 	printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
