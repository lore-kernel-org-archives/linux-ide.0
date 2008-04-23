From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: retry enabling AHCI a few times before spitting out
 WARN_ON()
Date: Wed, 23 Apr 2008 20:52:58 +0900
Message-ID: <480F231A.7020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.230]:55969 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYDWLxJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 07:53:09 -0400
Received: by qb-out-0506.google.com with SMTP id e11so2568686qbe.15
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 04:53:08 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>, "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>

Some chips need AHCI_EN set more than once to actually set it.  Try a
few times before giving up and spitting out WARN_ON().

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Peer Chen <pchen@nvidia.com>
Cc: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
---
 drivers/ata/ahci.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 739ba3f..711b5d7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -556,16 +556,27 @@ static inline void __iomem *ahci_port_base(struct ata_port *ap)
 
 static void ahci_enable_ahci(void __iomem *mmio)
 {
+	int i;
 	u32 tmp;
 
 	/* turn on AHCI_EN */
 	tmp = readl(mmio + HOST_CTL);
-	if (!(tmp & HOST_AHCI_EN)) {
+	if (tmp & HOST_AHCI_EN)
+		return;
+
+	/* Some controllers need AHCI_EN to be written multiple times.
+	 * Try a few times before giving up.
+	 */
+	for (i = 0; i < 5; i++) {
 		tmp |= HOST_AHCI_EN;
 		writel(tmp, mmio + HOST_CTL);
 		tmp = readl(mmio + HOST_CTL);	/* flush && sanity check */
-		WARN_ON(!(tmp & HOST_AHCI_EN));
+		if (tmp & HOST_AHCI_EN)
+			return;
+		msleep(10);
 	}
+
+	WARN_ON(1);
 }
 
 /**
