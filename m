From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4.2] ata: ahci_brcmstb: Fix warnings with CONFIG_PM_SLEEP=n
Date: Tue, 14 Jul 2015 13:03:33 -0700
Message-ID: <1436904213-9205-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregory.0xf0@gmail.com, computersforpeace@gmail.com, tj@kernel.org, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-ide@vger.kernel.org

When CONFIG_PM_SLEEP is disabled, brcm_ahci_{suspend,resume} are not
used, which causes such a build warning to occur:

  CC      drivers/ata/ahci_brcmstb.o
drivers/ata/ahci_brcmstb.c:212:12: warning: 'brcm_ahci_suspend' defined
but not used [-Wunused-function]
 static int brcm_ahci_suspend(struct device *dev)
            ^
drivers/ata/ahci_brcmstb.c:224:12: warning: 'brcm_ahci_resume' defined
but not used [-Wunused-function]
 static int brcm_ahci_resume(struct device *dev)
            ^
  LD      drivers/ata/built-in.o

Fixes: 766a2d979632 ("ata: add Broadcom AHCI SATA3 driver for STB chips")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Tejun, this is a new driver that got merged during 4.2, could you queue
this up for an upcoming 4.2-rcX pull request?

Thanks!

 drivers/ata/ahci_brcmstb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index ce1e3a885981..42b6cf4a05c8 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -209,6 +209,7 @@ static void brcm_sata_init(struct brcm_ahci_priv *priv)
 			   priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int brcm_ahci_suspend(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
@@ -231,6 +232,7 @@ static int brcm_ahci_resume(struct device *dev)
 	brcm_sata_phys_enable(priv);
 	return ahci_platform_resume(dev);
 }
+#endif
 
 static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
-- 
2.1.0
