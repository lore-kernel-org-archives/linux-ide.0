From: Brett Russ <russb@emc.com>
Subject: [PATCH libata-2.6] AHCI: print port ID not number
Date: Thu, 24 Feb 2005 15:03:53 -0500 (EST)
Message-ID: <20050224200353.DA17314FBC@lns1032.lss.emc.com>
Received: from mailhub.lss.emc.com ([168.159.2.31]:42984 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262463AbVBXUQ5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 15:16:57 -0500
Received: from lns1032.lss.emc.com (lns1032.lss.emc.com [168.159.31.32])
	by mailhub.lss.emc.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j1OKGrQe028905
	for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2005 15:16:54 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The attached patch fixes the "ata#: error occurred, port reset" line
to display the port id instead of the port number.

Signed-off-by: Brett Russ <russb@emc.com>

--- libata-2.6/drivers/scsi/ahci.c	Thu Feb 24 14:18:35 2005
+++ libata-2.6-ahci-printk/drivers/scsi/ahci.c	Thu Feb 24 14:21:41 2005
@@ -574,7 +574,7 @@
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 
-	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->port_no);
+	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
 }
 
 static void ahci_eng_timeout(struct ata_port *ap)

