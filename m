From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] ahci: Use dev_info() to inform about the lack of Device Sleep support
Date: Thu,  8 Jan 2015 19:41:34 +0100
Message-ID: <1420742494-5017-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-ide@vger.kernel.org

According to the Serial ATA AHCI specification, Device Sleep is an
optional feature and as such no errors should be printed if it's
missing. Keep informing users, but use dev_info() instead of dev_err().

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 97683e4..61a9c07 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2003,7 +2003,7 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 
 	devslp = readl(port_mmio + PORT_DEVSLP);
 	if (!(devslp & PORT_DEVSLP_DSP)) {
-		dev_err(ap->host->dev, "port does not support device sleep\n");
+		dev_info(ap->host->dev, "port does not support device sleep\n");
 		return;
 	}
 
-- 
2.1.4
