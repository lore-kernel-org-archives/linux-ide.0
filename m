From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0060/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:46 +0800
Message-ID: <20160802103746.17760-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16854 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbcHBLPw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ata/libata-zpodd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index f3a65a3..d8d4093 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -8,7 +8,7 @@
 #include "libata.h"
 
 static int zpodd_poweroff_delay = 30; /* 30 seconds for power off delay */
-module_param(zpodd_poweroff_delay, int, 0644);
+module_param(zpodd_poweroff_delay, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(zpodd_poweroff_delay, "Poweroff delay for ZPODD in seconds");
 
 enum odd_mech_type {
-- 
2.9.2

