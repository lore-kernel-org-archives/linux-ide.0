From: Harman Kalra <harman4linux@gmail.com>
Subject: [PATCH] ata: Replace BUG() with BUG_ON().
Date: Thu, 22 Sep 2016 01:29:48 +0530
Message-ID: <1474487988-4207-1-git-send-email-harman4linux@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Harman Kalra <harman4linux@gmail.com>
List-Id: linux-ide@vger.kernel.org

Replace BUG() with BUG_ON().
Caught by coccinelle.

Signed-off-by: Harman Kalra <harman4linux@gmail.com>
---
 drivers/ata/pata_octeon_cf.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 2724595..475a006 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -152,8 +152,7 @@ static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
 		div = 8;
 	T = (int)((1000000000000LL * div) / octeon_get_io_clock_rate());
 
-	if (ata_timing_compute(dev, dev->pio_mode, &timing, T, T))
-		BUG();
+	BUG_ON(ata_timing_compute(dev, dev->pio_mode, &timing, T, T));
 
 	t1 = timing.setup;
 	if (t1)
-- 
1.7.9.5
