From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/3] ata: ahci_platform: correct parameter documentation for ahci_platform_shutdown
Date: Thu, 12 Jul 2018 11:41:29 +0000
Message-ID: <1531395691-4653-2-git-send-email-clabbe@baylibre.com>
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

The documentation about parameter for ahci_platform_shutdown has a typo.

This fix the following build warning:
drivers/ata/libahci_platform.c:693: warning: Function parameter or member 'pdev' not described in 'ahci_platform_shutdown'
drivers/ata/libahci_platform.c:693: warning: Excess function parameter 'dev' description in 'ahci_platform_shutdow

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/libahci_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index feee2e11fb33..70052c046559 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -607,7 +607,7 @@ static void ahci_host_stop(struct ata_host *host)
 
 /**
  * ahci_platform_shutdown - Disable interrupts and stop DMA for host ports
- * @dev: platform device pointer for the host
+ * @pdev: platform device pointer for the host
  *
  * This function is called during system shutdown and performs the minimal
  * deconfiguration required to ensure that an ahci_platform host cannot
-- 
2.16.4
