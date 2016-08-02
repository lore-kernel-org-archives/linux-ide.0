From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0055/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:26 +0800
Message-ID: <20160802103726.17429-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
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
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a83bbcc..ddd08fb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -585,7 +585,7 @@ static int marvell_enable;
 #else
 static int marvell_enable = 1;
 #endif
-module_param(marvell_enable, int, 0644);
+module_param(marvell_enable, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
 
 
-- 
2.9.2
