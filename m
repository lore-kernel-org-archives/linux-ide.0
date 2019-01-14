From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ata: rb532_cf: Remove unused variable
Date: Mon, 14 Jan 2019 02:30:39 -0600
Message-ID: <20190114083039.GA11208@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-ide@vger.kernel.org

Remove unused variable *info* in rb532_pata_driver_remove():

drivers/ata/pata_rb532_cf.c:165:24: warning: unused variable 'info'
[-Wunused-variable]

Fixes: 0fe98fa056d7 ("ata: rb532_cf: Convert to use GPIO descriptors")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ata/pata_rb532_cf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 66bb5bff126b..1b9a8552d2dd 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -162,7 +162,6 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 static int rb532_pata_driver_remove(struct platform_device *pdev)
 {
 	struct ata_host *ah = platform_get_drvdata(pdev);
-	struct rb532_cf_info *info = ah->private_data;
 
 	ata_host_detach(ah);
 
-- 
2.20.1
