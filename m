From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/5] ahci: st: Remove legacy dependencies on PHY
Date: Wed, 12 Mar 2014 12:39:39 +0000
Message-ID: <1394627982-23726-3-git-send-email-lee.jones@linaro.org>
References: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tj@kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Kconfig   | 1 -
 drivers/ata/ahci_st.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ffc5d9d..f1adb4b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -100,7 +100,6 @@ config SATA_AHCI_PLATFORM
 config AHCI_ST
 	tristate "ST AHCI SATA support"
 	depends on SATA_AHCI_PLATFORM
-	select GENERIC_PHY
 	help
 	  This option enables support for ST AHCI SATA controller.
 
diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index f5af660..a28532a 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -16,7 +16,6 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/ahci_platform.h>
-#include <linux/phy/phy.h>
 #include <linux/libata.h>
 #include <linux/reset.h>
 #include <linux/io.h>
@@ -33,7 +32,6 @@
 
 struct st_ahci_drv_data {
 	struct platform_device *ahci;
-	struct phy *phy;
 	struct reset_control *pwr;
 	struct reset_control *sw_rst;
 	struct reset_control *pwr_rst;
-- 
1.8.3.2
