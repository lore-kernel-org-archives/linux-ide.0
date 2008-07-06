From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 49/50] icside: add module_exit()
Date: Sun, 06 Jul 2008 19:20:59 +0200
Message-ID: <4871026d.1ade660a.3458.62e9@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:6801 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759152AbYGFRfn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:43 -0400
Received: by mu-out-0910.google.com with SMTP id w8so554720mue.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:42 -0700 (PDT)
Content-Disposition: inline; filename=icside-add-module_exit.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -710,8 +710,14 @@ static int __init icside_init(void)
 	return ecard_register_driver(&icside_driver);
 }
 
+static void __exit icside_exit(void);
+{
+	ecard_unregister_driver(&icside_driver);
+}
+
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ICS IDE driver");
 
 module_init(icside_init);
+module_exit(icside_exit);

-- 

