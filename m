From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ata: pata_octeon_cf: make of_device_ids const.
Date: Fri, 16 Jun 2017 17:24:41 +0530
Message-ID: <dd1977ad60634797aeb04d3785bafffa0ec53026.1497613944.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34550 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbdFPLzO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jun 2017 07:55:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    465	    696	      4	   1165	    48d	drivers/ata/pata_octeon_cf.o

File size after constify octeon_cf_match.
   text	   data	    bss	    dec	    hex	filename
    865	    280	      4	   1149	    47d	drivers/ata/pata_octeon_cf.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/pata_octeon_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index f524a90..1ba03d6 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -1038,7 +1038,7 @@ static void octeon_cf_shutdown(struct device *dev)
 	}
 }
 
-static struct of_device_id octeon_cf_match[] = {
+static const struct of_device_id octeon_cf_match[] = {
 	{
 		.compatible = "cavium,ebt3000-compact-flash",
 	},
-- 
1.9.1

