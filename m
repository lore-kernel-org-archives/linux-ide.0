From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 13/14] pata_octeon_cf: perform host detach, removal on exit
Date: Fri,  2 Nov 2012 00:46:27 -0700
Message-ID: <1351842388-27210-14-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:34826 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab2KBHrF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:47:05 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1546198dak.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:47:05 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

This driver does not detach and remove its ata_host properly on device
removal. Add the common .remove helper.

Note: I do not know this driver well enough to ensure this is the right
thing to do. Merge this patch with caution.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/pata_octeon_cf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 1d61d5d..d8df93b 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -921,6 +921,7 @@ free_cf_port:
 
 static struct platform_driver octeon_cf_driver = {
 	.probe		= octeon_cf_probe,
+	.remove		= ata_platform_remove_one,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
-- 
1.7.11.3

