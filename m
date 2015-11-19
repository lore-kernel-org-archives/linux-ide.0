From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RESEND v2] sata/mvebu: use #ifdef around suspend/resume code
Date: Thu, 19 Nov 2015 15:16:30 +0100
Message-ID: <8025767.rG7ykO9yUZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The newly added suspend/resume implementation for ahci_mvebu causes
a link error when CONFIG_PM_SLEEP is disabled:

ERROR: "ahci_platform_suspend_host" [drivers/ata/ahci_mvebu.ko] undefined!
ERROR: "ahci_platform_resume_host" [drivers/ata/ahci_mvebu.ko] undefined!

This adds the same #ifdef here that exists in the ahci_platform driver
which defines the above functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d6ecf1581488 ("ata: ahci_mvebu: add suspend/resume support")
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
The patch hasn't shown up in linux-next yet, but is still needed, resending.

Also fixed a typo in description.

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
