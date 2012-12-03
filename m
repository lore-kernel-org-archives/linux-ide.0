From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 4/4] pata_of_platform: fix compile error
Date: Mon,  3 Dec 2012 10:34:42 -0800
Message-ID: <1354559682-30965-4-git-send-email-computersforpeace@gmail.com>
References: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43255 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab2LCSfC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 13:35:02 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2192697pbc.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 10:35:02 -0800 (PST)
In-Reply-To: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>

I failed to include <linux/libata.h>, causing this error:

  drivers/ata/pata_of_platform.c:93: error: 'ata_platform_remove_one' undeclared here (not in a function)

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/pata_of_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index cd0f9da..e5b234c 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
+#include <linux/libata.h>
 
 static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 {
-- 
1.8.0

