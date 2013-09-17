From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH] ahci: Changing two module params with static and
 __read_mostly
Date: Wed, 18 Sep 2013 00:48:38 +0800
Message-ID: <1379436518.26153.31.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32646 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab3IQHZj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Sep 2013 03:25:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com


Here module parameters ahci_em_messages and devslp_idle_timeout can
be set as static and __read_mostly.

Signed-off-by: Liu, Chuansheng <chuansheng.liu@intel.com>
---
 drivers/ata/libahci.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index acfd0f7..1757631 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -189,14 +189,15 @@ struct ata_port_operations ahci_pmp_retry_srst_ops = {
 };
 EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
 
-int ahci_em_messages = 1;
+static int ahci_em_messages __read_mostly = 1;
 EXPORT_SYMBOL_GPL(ahci_em_messages);
 module_param(ahci_em_messages, int, 0444);
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



