From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] ata: pata_of_platform: using of_property_read_u32() helper
Date: Tue, 24 Jan 2017 20:08:29 +0800
Message-ID: <1485259709-16487-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:54582 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdAXMMe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2017 07:12:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>

Using better of_property_read_u32() than generic of_get_property().

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> 
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/ata/pata_of_platform.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index b6b7af8..201a32d 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -32,7 +32,6 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	unsigned int reg_shift = 0;
 	int pio_mode = 0;
 	int pio_mask;
-	const u32 *prop;
 
 	ret = of_address_to_resource(dn, 0, &io_res);
 	if (ret) {
@@ -50,13 +49,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 
 	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
 
-	prop = of_get_property(dn, "reg-shift", NULL);
-	if (prop)
-		reg_shift = be32_to_cpup(prop);
+	of_property_read_u32(dn, "reg-shift", &reg_shift);
 
-	prop = of_get_property(dn, "pio-mode", NULL);
-	if (prop) {
-		pio_mode = be32_to_cpup(prop);
+	if (!of_property_read_u32(dn, "pio-mode", &pio_mode)) {
 		if (pio_mode > 6) {
 			dev_err(&ofdev->dev, "invalid pio-mode\n");
 			return -EINVAL;
-- 
1.7.12.4

