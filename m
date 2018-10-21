From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] ata: pata_samsung_cf: simplify getting .driver_data
Date: Sun, 21 Oct 2018 21:59:49 +0200
Message-ID: <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
References: <20181021195949.1351-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021195949.1351-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/ata/pata_samsung_cf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index f5bd44b8bd63..1dc3361cb5a5 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -609,17 +609,15 @@ static int __exit pata_s3c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int pata_s3c_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ata_host *host = platform_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	return ata_host_suspend(host, PMSG_SUSPEND);
 }
 
 static int pata_s3c_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ata_host *host = platform_get_drvdata(pdev);
-	struct s3c_ide_platdata *pdata = dev_get_platdata(&pdev->dev);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct s3c_ide_platdata *pdata = dev_get_platdata(dev);
 	struct s3c_ide_info *info = host->private_data;
 
 	pata_s3c_hwinit(info, pdata);
-- 
2.19.0
