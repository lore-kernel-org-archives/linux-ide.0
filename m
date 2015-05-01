From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH] libata: samsung_cf: Constify platform_device_id
Date: Sat,  2 May 2015 00:59:16 +0900
Message-ID: <1430495956-32215-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-ide@vger.kernel.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/ata/pata_samsung_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index fa44eb2872db..cbb5a471eb9d 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -638,7 +638,7 @@ static const struct dev_pm_ops pata_s3c_pm_ops = {
 #endif
 
 /* driver device registration */
-static struct platform_device_id pata_s3c_driver_ids[] = {
+static const struct platform_device_id pata_s3c_driver_ids[] = {
 	{
 		.name		= "s3c64xx-pata",
 		.driver_data	= TYPE_S3C64XX,
-- 
2.1.4
