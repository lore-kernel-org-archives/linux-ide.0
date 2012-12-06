From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] ahci_platform: make structs static
Date: Wed,  5 Dec 2012 23:44:20 -0800
Message-ID: <1354779860-8655-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45951 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab2LFHog (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2012 02:44:36 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4243178pad.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2012 23:44:36 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>

These structs are used only for ahci_platform.c, so they should be
static. Thanks to Fengguang for the (automated) suggestion.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/ata/ahci_platform.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 1d90690..1cc467b 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -49,12 +49,12 @@ static struct platform_device_id ahci_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, ahci_devtype);
 
-struct ata_port_operations ahci_platform_ops = {
+static struct ata_port_operations ahci_platform_ops = {
 	.inherits	= &ahci_ops,
 	.host_stop	= ahci_host_stop,
 };
 
-struct ata_port_operations ahci_platform_retry_srst_ops = {
+static struct ata_port_operations ahci_platform_retry_srst_ops = {
 	.inherits	= &ahci_pmp_retry_srst_ops,
 	.host_stop	= ahci_host_stop,
 };
@@ -323,7 +323,7 @@ disable_unprepare_clk:
 }
 #endif
 
-SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
+static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
 
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
-- 
1.7.9.5

