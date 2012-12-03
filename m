From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 2/4] pata_octeon_cf: perform host detach, removal on exit
Date: Mon,  3 Dec 2012 10:34:40 -0800
Message-ID: <1354559682-30965-2-git-send-email-computersforpeace@gmail.com>
References: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35860 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab2LCSe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 13:34:58 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2104708pad.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 10:34:57 -0800 (PST)
In-Reply-To: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>, David Daney <david.daney@cavium.com>

This driver does not detach and remove its ata_host properly on device
removal. Add the common .remove helper.

Note: I do not know this driver well enough to ensure this is the right
thing to do. Merge this patch with caution.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: David Daney <david.daney@cavium.com>
---
v2: no change (rebased along with previous patch)

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
1.8.0

