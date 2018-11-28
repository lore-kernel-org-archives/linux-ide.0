From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH] sis5513: fix potential use after free
Date: Wed, 28 Nov 2018 08:55:26 +0800
Message-ID: <1543366526-46767-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: linux-ide@vger.kernel.org

The function sis_find_family drops lpc_bridge reference via pci_dev_put,
however, after that, field lpc_bridge->revision is read. This may result
in a use after free bug. The patch moves the put operation after the
condition check.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/ide/sis5513.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
index 024bc7b..69f9889 100644
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -434,7 +434,6 @@ static int sis_find_family(struct pci_dev *dev)
 
 				lpc_bridge = pci_get_slot(dev->bus, 0x10); /* Bus 0, Dev 2, Fn 0 */
 				pci_read_config_byte(dev, 0x49, &prefctl);
-				pci_dev_put(lpc_bridge);
 
 				if (lpc_bridge->revision == 0x10 && (prefctl & 0x80)) {
 					printk(KERN_INFO DRV_NAME " %s: SiS 961B MuTIOL IDE UDMA133 controller\n",
@@ -445,6 +444,8 @@ static int sis_find_family(struct pci_dev *dev)
 						pci_name(dev));
 					chipset_family = ATA_100;
 				}
+
+				pci_dev_put(lpc_bridge);
 			}
 	}
 
-- 
2.7.4
