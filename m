From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/4] sata_dwc_460ex: fix return value of dma_dwc_xfer_setup()
Date: Fri, 28 Jan 2011 21:58:54 +0300
Message-ID: <201101282158.54462.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:59144 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751219Ab1A1TAP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2011 14:00:15 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

The caller expects this function to return the DMA channel number on success,
while it returns 0...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/sata_dwc_460ex.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/sata_dwc_460ex.c
===================================================================
--- linux-2.6.orig/drivers/ata/sata_dwc_460ex.c
+++ linux-2.6/drivers/ata/sata_dwc_460ex.c
@@ -44,7 +44,7 @@
 #undef	DRV_NAME
 #undef	DRV_VERSION
 #define DRV_NAME        "sata-dwc"
-#define DRV_VERSION     "1.1"
+#define DRV_VERSION     "1.2"
 
 /* SATA DMA driver Globals */
 #define DMA_NUM_CHANS		1
@@ -718,7 +718,7 @@ static int dma_dwc_xfer_setup(struct sca
 	/* Program the CTL register with src enable / dst enable */
 	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].ctl.low),
 		 DMA_CTL_LLP_SRCEN | DMA_CTL_LLP_DSTEN);
-	return 0;
+	return dma_ch;
 }
 
 /*
