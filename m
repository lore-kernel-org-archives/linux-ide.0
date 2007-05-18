From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: disable 64bit dma on sb600
Date: Fri, 18 May 2007 15:18:30 +0200
Message-ID: <464DA7A6.3010303@gmail.com>
References: <830792.81640.qm@web52605.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:20980 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbXERNSp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 May 2007 09:18:45 -0400
Received: by py-out-1112.google.com with SMTP id a29so1149272pyi
        for <linux-ide@vger.kernel.org>; Fri, 18 May 2007 06:18:44 -0700 (PDT)
In-Reply-To: <830792.81640.qm@web52605.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, wolke.liu@amd.com
Cc: linux-ide@vger.kernel.org

SB600 claims it can do 64bit DMA but it can't.  Disable it.

DON'T APPLY YET
---

Srihari, can you test this against 2.6.22-rc1-git7 just in case?  I'll
send this upstream after you ack.  Thanks.

 ahci.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e00e1b9..bb94047 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -170,6 +170,7 @@ enum {
 	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
 	AHCI_FLAG_HONOR_PI		= (1 << 26), /* honor PORTS_IMPL */
 	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
+	AHCI_FLAG_32BIT_ONLY		= (1 << 28), /* force 32bit */
 
 	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
@@ -354,7 +355,8 @@ static const struct ata_port_info ahci_p
 	/* board_ahci_sb600 */
 	{
 		.flags		= AHCI_FLAG_COMMON |
-				  AHCI_FLAG_IGN_SERR_INTERNAL,
+				  AHCI_FLAG_IGN_SERR_INTERNAL |
+				  AHCI_FLAG_32BIT_ONLY,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -492,6 +494,13 @@ static void ahci_save_initial_config(str
 	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
 	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
 
+	/* some chips lie about 64bit support */
+	if ((cap & HOST_CAP_64) && (pi->flags & AHCI_FLAG_32BIT_ONLY)) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "controller can't do 64bit DMA, forcing 32bit\n");
+		cap &= ~HOST_CAP_64;
+	}
+
 	/* fixup zero port_map */
 	if (!port_map) {
 		port_map = (1 << ahci_nr_ports(hpriv->cap)) - 1;
