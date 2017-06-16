From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ata: sata_rcar: make of_device_ids const.
Date: Fri, 16 Jun 2017 17:32:21 +0530
Message-ID: <474047fe3280ca103275247df6aa67288220a9d4.1497614383.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, b.zolnierkie@samsung.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   3946	   2296	      0	   6242	   1862	drivers/ata/sata_rcar.o

File size after constify sata_rcar_match.
   text	   data	    bss	    dec	    hex	filename
   5554	    696	      0	   6250	   186a	drivers/ata/sata_rcar.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/sata_rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 5d38245..35945e3 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -828,7 +828,7 @@ static void sata_rcar_init_controller(struct ata_host *host)
 	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
 }
 
-static struct of_device_id sata_rcar_match[] = {
+static const struct of_device_id sata_rcar_match[] = {
 	{
 		/* Deprecated by "renesas,sata-r8a7779" */
 		.compatible = "renesas,rcar-sata",
-- 
1.9.1
