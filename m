From: JiSheng Zhang <jszhang3@gmail.com>
Subject: [PATCH V2 1/2] ahci_platform: use dev_get_platdata()
Date: Mon, 31 Oct 2011 21:20:10 +0800
Message-ID: <20111031212010.5035af2b@ustc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40765 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab1JaNGG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2011 09:06:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, avorontsov@mvista.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


Use dev_get_platdata() to retrieve the struct ahci_platform_data data
from the platform.

Signed-off-by: JiSheng Zhang <jszhang3@gmail.com>
---
 drivers/ata/ahci_platform.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index c03277d..45edba9 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -65,7 +65,7 @@ static struct scsi_host_template ahci_platform_sht = {
 static int __init ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct ahci_platform_data *pdata = dev->platform_data;
+	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct ata_port_info pi = ahci_port_info[id->driver_data];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
@@ -191,7 +191,7 @@ err0:
 static int __devexit ahci_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct ahci_platform_data *pdata = dev->platform_data;
+	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
-- 
1.7.6.3

