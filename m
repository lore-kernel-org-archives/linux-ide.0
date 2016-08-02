From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0057/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:34 +0800
Message-ID: <20160802103734.17562-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26943 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715AbcHBLPj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:39 -0400
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
 drivers/ata/libahci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 71b0719..7d833db 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -51,10 +51,10 @@ static int ahci_skip_host_reset;
 int ahci_ignore_sss;
 EXPORT_SYMBOL_GPL(ahci_ignore_sss);
 
-module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
+module_param_named(skip_host_reset, ahci_skip_host_reset, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)");
 
-module_param_named(ignore_sss, ahci_ignore_sss, int, 0444);
+module_param_named(ignore_sss, ahci_ignore_sss, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ignore_sss, "Ignore staggered spinup flag (0=don't ignore, 1=ignore)");
 
 static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
@@ -190,14 +190,14 @@ EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
 
 static bool ahci_em_messages __read_mostly = true;
 EXPORT_SYMBOL_GPL(ahci_em_messages);
-module_param(ahci_em_messages, bool, 0444);
+module_param(ahci_em_messages, bool, S_IRUSR | S_IRGRP | S_IROTH);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
 	"AHCI Enclosure Management Message control (0 = off, 1 = on)");
 
 /* device sleep idle timeout in ms */
 static int devslp_idle_timeout __read_mostly = 1000;
-module_param(devslp_idle_timeout, int, 0644);
+module_param(devslp_idle_timeout, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(devslp_idle_timeout, "device sleep idle timeout");
 
 static void ahci_enable_ahci(void __iomem *mmio)
-- 
2.9.2

