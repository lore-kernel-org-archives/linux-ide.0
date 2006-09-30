From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] ahci: preserve PORTS_IMPL over host resets
Date: Sat, 30 Sep 2006 21:21:21 +0900
Message-ID: <20060930122121.GR25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:14405 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750940AbWI3MV0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 08:21:26 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1204600wxc
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 05:21:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, robbat2@gentoo.org

Instead of writing 0xf blindly, preserve the content of write-once
PORTS_IMPL register over host resets.

This patch is taken from Jeff Garzik's AHCI init update patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
---
 drivers/ata/ahci.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 54e1f38..d268ced 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -563,11 +563,12 @@ static int ahci_deinit_port(void __iomem
 
 static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev)
 {
-	u32 cap_save, tmp;
+	u32 cap_save, impl_save, tmp;
 
 	cap_save = readl(mmio + HOST_CAP);
 	cap_save &= ( (1<<28) | (1<<17) );
 	cap_save |= (1 << 27);
+	impl_save = readl(mmio + HOST_PORTS_IMPL);
 
 	/* global controller reset */
 	tmp = readl(mmio + HOST_CTL);
@@ -588,10 +589,16 @@ static int ahci_reset_controller(void __
 		return -EIO;
 	}
 
+	/* turn on AHCI mode */
 	writel(HOST_AHCI_EN, mmio + HOST_CTL);
 	(void) readl(mmio + HOST_CTL);	/* flush */
+
+	/* These write-once registers are normally cleared on reset.
+	 * Restore BIOS values... which we HOPE were present before
+	 * reset.
+	 */
 	writel(cap_save, mmio + HOST_CAP);
-	writel(0xf, mmio + HOST_PORTS_IMPL);
+	writel(impl_save, mmio + HOST_PORTS_IMPL);
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
-- 
1.4.2.1


