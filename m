From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/21] ahci: build fix for !CONFIG_PM
Date: Mon, 16 Jul 2007 14:29:38 +0900
Message-ID: <11845637781555-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:11852 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762628AbXGPF3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:43 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736626nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:42 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

ahci_port_resume() is also used while starting port.  Move it out of
CONFIG_PM block.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 11e4eb9..eaec5e5 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1519,6 +1519,14 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 	}
 }
 
+static int ahci_port_resume(struct ata_port *ap)
+{
+	ahci_power_up(ap);
+	ahci_start_port(ap);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
@@ -1536,14 +1544,6 @@ static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 	return rc;
 }
 
-static int ahci_port_resume(struct ata_port *ap)
-{
-	ahci_power_up(ap);
-	ahci_start_port(ap);
-
-	return 0;
-}
-
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-- 
1.5.0.3


