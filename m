From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 14/14] libata: use pci_get_drvdata() helper
Date: Fri,  2 Nov 2012 00:46:28 -0700
Message-ID: <1351842388-27210-15-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab2KBHrG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:47:06 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2299681pad.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:47:06 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/libata-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 820e47f..a0c6cac 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6255,8 +6255,7 @@ void ata_host_detach(struct ata_host *host)
  */
 void ata_pci_remove_one(struct pci_dev *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct ata_host *host = dev_get_drvdata(dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 
 	ata_host_detach(host);
 }
@@ -6325,7 +6324,7 @@ int ata_pci_device_do_resume(struct pci_dev *pdev)
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc = 0;
 
 	rc = ata_host_suspend(host, mesg);
@@ -6339,7 +6338,7 @@ int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
-- 
1.7.11.3

