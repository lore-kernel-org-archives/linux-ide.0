From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH V2] ahci: Changing two module params with static and
 __read_mostly
Date: Wed, 18 Sep 2013 20:21:49 +0800
Message-ID: <1379506909.26153.33.camel@cliu38-desktop-build>
References: <1379436518.26153.31.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7951 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab3IRC7V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Sep 2013 22:59:21 -0400
In-Reply-To: <1379436518.26153.31.camel@cliu38-desktop-build>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, joe@perches.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com


Here module parameters ahci_em_messages and devslp_idle_timeout can
be set as static and __read_mostly.

Signed-off-by: Liu, Chuansheng <chuansheng.liu@intel.com>
---
 drivers/ata/libahci.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index acfd0f7..b67086f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -189,14 +189,15 @@ struct ata_port_operations ahci_pmp_retry_srst_ops = {
 };
 EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
 
-int ahci_em_messages = 1;
+static bool ahci_em_messages __read_mostly = true;
 EXPORT_SYMBOL_GPL(ahci_em_messages);
-module_param(ahci_em_messages, int, 0444);
+module_param(ahci_em_messages, bool, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
 	"AHCI Enclosure Management Message control (0 = off, 1 = on)");
 
-int devslp_idle_timeout = 1000;	/* device sleep idle timeout in ms */
+/* device sleep idle timeout in ms */
+static int devslp_idle_timeout __read_mostly = 1000;
 module_param(devslp_idle_timeout, int, 0644);
 MODULE_PARM_DESC(devslp_idle_timeout, "device sleep idle timeout");
 
-- 
1.7.9.5



