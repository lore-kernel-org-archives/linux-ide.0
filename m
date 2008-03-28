From: akpm@linux-foundation.org
Subject: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Fri, 28 Mar 2008 14:33:46 -0700
Message-ID: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60777 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757557AbYC1Vd7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 17:33:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, zboszor@dunaweb.hu, hancockr@shaw.ca

From: Zoltan Boszormenyi <zboszor@dunaweb.hu>

unchangelogged patch.

Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: Robert Hancock <hancockr@shaw.ca>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_nv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ata/sata_nv.c~ata-swncq-should-be-enabled-by-default drivers/ata/sata_nv.c
--- a/drivers/ata/sata_nv.c~ata-swncq-should-be-enabled-by-default
+++ a/drivers/ata/sata_nv.c
@@ -532,7 +532,7 @@ MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
 static int adma_enabled = 1;
-static int swncq_enabled;
+static int swncq_enabled = 1;
 
 static void nv_adma_register_mode(struct ata_port *ap)
 {
@@ -2485,5 +2485,5 @@ module_exit(nv_exit);
 module_param_named(adma, adma_enabled, bool, 0444);
 MODULE_PARM_DESC(adma, "Enable use of ADMA (Default: true)");
 module_param_named(swncq, swncq_enabled, bool, 0444);
-MODULE_PARM_DESC(swncq, "Enable use of SWNCQ (Default: false)");
+MODULE_PARM_DESC(swncq, "Enable use of SWNCQ (Default: true)");
 
_
