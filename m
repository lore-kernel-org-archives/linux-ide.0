From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] pata_octeon_cf: fix broken build
Date: Mon,  8 Jun 2015 11:32:43 +0300
Message-ID: <1433752363-6373-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:56618 "EHLO
	demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbbFHIeo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2015 04:34:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

MODULE_DEVICE_TABLE is referring to wrong driver's table and breaks the
build. Fix that.

Cc: stable@vger.kernel.org
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/ata/pata_octeon_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 80a8054..2724595 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -1053,7 +1053,7 @@ static struct of_device_id octeon_cf_match[] = {
 	},
 	{},
 };
-MODULE_DEVICE_TABLE(of, octeon_i2c_match);
+MODULE_DEVICE_TABLE(of, octeon_cf_match);
 
 static struct platform_driver octeon_cf_driver = {
 	.probe		= octeon_cf_probe,
-- 
2.4.2

