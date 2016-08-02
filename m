From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0065/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:38:07 +0800
Message-ID: <20160802103807.18090-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com
List-Id: linux-ide@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ata/sata_nv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 734f563..54ef357 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2511,9 +2511,9 @@ static void nv_adma_host_stop(struct ata_host *host)
 
 module_pci_driver(nv_pci_driver);
 
-module_param_named(adma, adma_enabled, bool, 0444);
+module_param_named(adma, adma_enabled, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(adma, "Enable use of ADMA (Default: false)");
-module_param_named(swncq, swncq_enabled, bool, 0444);
+module_param_named(swncq, swncq_enabled, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(swncq, "Enable use of SWNCQ (Default: true)");
-module_param_named(msi, msi_enabled, bool, 0444);
+module_param_named(msi, msi_enabled, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(msi, "Enable use of MSI (Default: false)");
-- 
2.9.2
