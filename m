From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 50/50] rapide: add module_exit()
Date: Sun, 06 Jul 2008 19:21:00 +0200
Message-ID: <4871026e.1ade660a.3458.62ed@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:6749 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759178AbYGFRfo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:44 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554745mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:43 -0700 (PDT)
Content-Disposition: inline; filename=rapide-add-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/rapide.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -95,7 +95,13 @@ static int __init rapide_init(void)
 	return ecard_register_driver(&rapide_driver);
 }
 
+static void __exit rapide_exit(void)
+{
+	ecard_unregister_driver(&rapide_driver);
+}
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Yellowstone RAPIDE driver");
 
 module_init(rapide_init);
+module_exit(rapide_exit);

-- 

