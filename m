From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: disable 64bit dma on sb600
Date: Fri, 18 May 2007 16:23:19 +0200
Message-ID: <464DB6D7.8040206@gmail.com>
References: <830792.81640.qm@web52605.mail.re2.yahoo.com> <464DA7A6.3010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:48039 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbXEROXe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 May 2007 10:23:34 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1350330nza
        for <linux-ide@vger.kernel.org>; Fri, 18 May 2007 07:23:34 -0700 (PDT)
In-Reply-To: <464DA7A6.3010303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, wolke.liu@amd.com, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

SB600 claims it can do 64bit DMA but it can't.  Disable it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this one is for #upstream-fixes.

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
