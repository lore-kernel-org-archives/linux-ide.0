From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: port_no should be used when clearing IRQ in ahci_thaw()
Date: Sat, 27 Jan 2007 11:04:26 +0900
Message-ID: <20070127020426.GI8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:4836 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbXA0CEe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2007 21:04:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so865215uga
        for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2007 18:04:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ap->id is logcial port ID which is unique among all ATA ports and
doesn't have anything to do with hardware port index.  ap->port_no is
the hardware port index and thus should be used when clearing IRQ mask
in ahci_thaw().

This problem has been spotted by Jeff Garzik <jgarzik@pobox.com>.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ab73b0a..7f1bf85 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1281,7 +1281,7 @@ static void ahci_thaw(struct ata_port *ap)
 	/* clear IRQ */
 	tmp = readl(port_mmio + PORT_IRQ_STAT);
 	writel(tmp, port_mmio + PORT_IRQ_STAT);
-	writel(1 << ap->id, mmio + HOST_IRQ_STAT);
+	writel(1 << ap->port_no, mmio + HOST_IRQ_STAT);
 
 	/* turn IRQ back on */
 	writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
