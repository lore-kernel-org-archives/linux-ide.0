From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] sata/mvebu: use #ifdef around suspend/resume code
Date: Mon, 12 Oct 2015 15:05:27 +0200
Message-ID: <5727002.l6plqmRKB3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:55310 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbbJLNFf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2015 09:05:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The newly added suspend/resume implementation for ahci_mvebu causes
a link error when CONFIG_PM_SUSPEND is disabled:

ERROR: "ahci_platform_suspend_host" [drivers/ata/ahci_mvebu.ko] undefined!
ERROR: "ahci_platform_resume_host" [drivers/ata/ahci_mvebu.ko] undefined!

This adds the same #ifdef here that exists in the ahci_platform driver
which defines the above functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d6ecf1581488 ("ata: ahci_mvebu: add suspend/resume support")

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 8490d37aee2a..5745bcce5e77 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -62,6 +62,7 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
+#ifdef CONFIG_PM_SUSPEND
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

