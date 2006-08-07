From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: remove IRQ mask clearing from init_controller()
Date: Mon, 7 Aug 2006 11:39:04 +0900
Message-ID: <20060807023904.GA28202@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:15603 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750911AbWHGCjK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 22:39:10 -0400
Received: by py-out-1112.google.com with SMTP id z74so1830389pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 19:39:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Initial IRQ mask clearing is done by libata-core by freezing all ports
prior to requesting IRQ.  Remove redundant IRQ clearing from
init_controller().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

049892ed973dc00569e26130826fef0000fc7577
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f5734a9..68fd766 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -662,14 +662,13 @@ #endif
 		VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
 		writel(tmp, port_mmio + PORT_SCR_ERR);
 
-		/* clear & turn off port IRQ */
+		/* clear port IRQ */
 		tmp = readl(port_mmio + PORT_IRQ_STAT);
 		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 
 		writel(1 << i, mmio + HOST_IRQ_STAT);
-		writel(0, port_mmio + PORT_IRQ_MASK);
 	}
 
 	tmp = readl(mmio + HOST_CTL);
-- 
1.3.2

