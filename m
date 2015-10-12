From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] sata/mvebu: use #ifdef around suspend/resume code
Date: Mon, 12 Oct 2015 15:34:55 +0200
Message-ID: <7247630.qs4EYWgH4t@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52631 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbbJLNfC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2015 09:35:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The newly added suspend/resume implementation for ahci_mvebu causes
a link error when CONFIG_PM_SUSPEND is disabled:

ERROR: "ahci_platform_suspend_host" [drivers/ata/ahci_mvebu.ko] undefined!
ERROR: "ahci_platform_resume_host" [drivers/ata/ahci_mvebu.ko] undefined!

This adds the same #ifdef here that exists in the ahci_platform driver
which defines the above functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d6ecf1581488 ("ata: ahci_mvebu: add suspend/resume support")
---
v2: use the correct macro, thanks to Thomas for pointing it out!

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 8490d37aee2a..f7a7fa81740e 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -62,6 +62,7 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int ahci_mvebu_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	return ahci_platform_suspend_host(&pdev->dev);
@@ -81,6 +82,10 @@ static int ahci_mvebu_resume(struct platform_device *pdev)
 
 	return ahci_platform_resume_host(&pdev->dev);
 }
+#else
+#define ahci_mvebu_suspend NULL
+#define ahci_mvebu_resume NULL
+#endif
 
 static const struct ata_port_info ahci_mvebu_port_info = {
 	.flags	   = AHCI_FLAG_COMMON,

