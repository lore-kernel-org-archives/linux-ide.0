From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 3/4] libata: use pci_get_drvdata() helper
Date: Mon,  3 Dec 2012 10:34:41 -0800
Message-ID: <1354559682-30965-3-git-send-email-computersforpeace@gmail.com>
References: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:50377 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab2LCSfA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 13:35:00 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1426137dak.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 10:34:59 -0800 (PST)
In-Reply-To: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
v2: no change (rebased along with previous patches)

 drivers/ata/libata-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8e3f4a9..47d5961 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6287,8 +6287,7 @@ void ata_host_detach(struct ata_host *host)
  */
 void ata_pci_remove_one(struct pci_dev *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct ata_host *host = dev_get_drvdata(dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 
 	ata_host_detach(host);
 }
@@ -6357,7 +6356,7 @@ int ata_pci_device_do_resume(struct pci_dev *pdev)
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc = 0;
 
 	rc = ata_host_suspend(host, mesg);
@@ -6371,7 +6370,7 @@ int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
-- 
1.8.0

