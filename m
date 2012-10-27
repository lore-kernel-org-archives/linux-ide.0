From: Brian Norris <computersforpeace@gmail.com>
Subject: [RFC v2 1/3] ahci_platform: enable hotplug unbinding
Date: Sat, 27 Oct 2012 13:09:34 -0700
Message-ID: <1351368576-5264-2-git-send-email-computersforpeace@gmail.com>
References: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:61645 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533Ab2J0UKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2012 16:10:15 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1806841dak.19
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2012 13:10:15 -0700 (PDT)
In-Reply-To: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kevin Cernekee <cernekee@gmail.com>, Brian Norris <computersforpeace@gmail.com>

platform_driver_probe() should be used for registering this driver only
if we want to

    "...remove its run-once probe() infrastructure from memory after the
    driver has bound to the device."

However, we may want to leave the probe infrastructure in place in order
to support binding/unbinding a device dynamically. This is useful, for
instance, as a power management mechanism, where a device can be totally
powered down when unbound (whereas with runtime power management,
powering down the SATA core would incur unacceptable loss of
functionality).

Thus, convert this driver to use platform_driver_register().

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/ahci_platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 9e419e1..f467ba8 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -73,7 +73,7 @@ static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT("ahci_platform"),
 };
 
-static int __init ahci_probe(struct platform_device *pdev)
+static int __devinit ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
@@ -286,6 +286,7 @@ static const struct of_device_id ahci_of_match[] = {
 MODULE_DEVICE_TABLE(of, ahci_of_match);
 
 static struct platform_driver ahci_driver = {
+	.probe = ahci_probe,
 	.remove = __devexit_p(ahci_remove),
 	.driver = {
 		.name = "ahci",
@@ -300,7 +301,7 @@ static struct platform_driver ahci_driver = {
 
 static int __init ahci_init(void)
 {
-	return platform_driver_probe(&ahci_driver, ahci_probe);
+	return platform_driver_register(&ahci_driver);
 }
 module_init(ahci_init);
 
-- 
1.7.11.3

