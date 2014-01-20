From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 1/4] ata: ahci_platform: Add DT compatible for Synopsis DWC AHCI controller
Date: Mon, 20 Jan 2014 16:41:25 +0200
Message-ID: <1390228888-5537-2-git-send-email-rogerq@ti.com>
References: <1390228888-5537-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390228888-5537-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: sergei.shtylyov@cogentembedded.com, kishon@ti.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, arnd@arndb.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-ide@vger.kernel.org

Add compatible string "snps,dwc-ahci", which should be used
for Synopsis Designware SATA cores. e.g. on TI OMAP5 and DRA7 platforms.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 4b231ba..d5ced13 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -330,6 +330,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
 	{ .compatible = "snps,exynos5440-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
+	{ .compatible = "snps,dwc-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.8.3.2
