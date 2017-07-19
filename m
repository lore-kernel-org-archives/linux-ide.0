From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 006/102] ata: ahci_tegra: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:10 +0200
Message-ID: <20170719152646.25903-7-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Tejun Heo <tj@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Tejun Heo <tj@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-ide@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/ata/ahci_tegra.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 3a62eb246d80b..e9daf938738c5 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -319,19 +319,21 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(tegra->sata_regs))
 		return PTR_ERR(tegra->sata_regs);
 
-	tegra->sata_rst = devm_reset_control_get(&pdev->dev, "sata");
+	tegra->sata_rst = devm_reset_control_get_exclusive(&pdev->dev, "sata");
 	if (IS_ERR(tegra->sata_rst)) {
 		dev_err(&pdev->dev, "Failed to get sata reset\n");
 		return PTR_ERR(tegra->sata_rst);
 	}
 
-	tegra->sata_oob_rst = devm_reset_control_get(&pdev->dev, "sata-oob");
+	tegra->sata_oob_rst = devm_reset_control_get_exclusive(&pdev->dev,
+							       "sata-oob");
 	if (IS_ERR(tegra->sata_oob_rst)) {
 		dev_err(&pdev->dev, "Failed to get sata-oob reset\n");
 		return PTR_ERR(tegra->sata_oob_rst);
 	}
 
-	tegra->sata_cold_rst = devm_reset_control_get(&pdev->dev, "sata-cold");
+	tegra->sata_cold_rst = devm_reset_control_get_exclusive(&pdev->dev,
+								"sata-cold");
 	if (IS_ERR(tegra->sata_cold_rst)) {
 		dev_err(&pdev->dev, "Failed to get sata-cold reset\n");
 		return PTR_ERR(tegra->sata_cold_rst);
-- 
2.11.0
