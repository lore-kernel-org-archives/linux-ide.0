From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 004/102] ahci: st: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:08 +0200
Message-ID: <20170719152646.25903-5-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Patrice Chotard <patrice.chotard@st.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/ata/ahci_st.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index bc345f2495553..8a26e917dae90 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -108,19 +108,19 @@ static int st_ahci_probe_resets(struct ahci_host_priv *hpriv,
 {
 	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 
-	drv_data->pwr = devm_reset_control_get(dev, "pwr-dwn");
+	drv_data->pwr = devm_reset_control_get_exclusive(dev, "pwr-dwn");
 	if (IS_ERR(drv_data->pwr)) {
 		dev_info(dev, "power reset control not defined\n");
 		drv_data->pwr = NULL;
 	}
 
-	drv_data->sw_rst = devm_reset_control_get(dev, "sw-rst");
+	drv_data->sw_rst = devm_reset_control_get_exclusive(dev, "sw-rst");
 	if (IS_ERR(drv_data->sw_rst)) {
 		dev_info(dev, "soft reset control not defined\n");
 		drv_data->sw_rst = NULL;
 	}
 
-	drv_data->pwr_rst = devm_reset_control_get(dev, "pwr-rst");
+	drv_data->pwr_rst = devm_reset_control_get_exclusive(dev, "pwr-rst");
 	if (IS_ERR(drv_data->pwr_rst)) {
 		dev_dbg(dev, "power soft reset control not defined\n");
 		drv_data->pwr_rst = NULL;
-- 
2.11.0
