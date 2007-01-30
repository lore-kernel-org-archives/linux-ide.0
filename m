From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_sl82c105: wrong assumptions about compatible PIO modes
Date: Tue, 30 Jan 2007 20:40:30 +0300
Message-ID: <200701302040.30895.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:34092 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965642AbXA3Rke (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 12:40:34 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Fix the wrong "compatible" PIO mode choices: MWDMA0 has 480 ns cycle while PIO1
only has 383 ns cycle, and MWDMA2 timings matchs those of PIO4 exactly.

---
Frankly speaking, I'm not sure this function is useful or correct at all --
with the DMA timings being actually programmed in sl82c105_bmdma_start()...

And the issue of the same registers being used for both PIO and DMA timings is
not specific for this driver at all but seems to be addressed only by it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ata/pata_sl82c105.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/pata_sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sl82c105.c
+++ linux-2.6/drivers/ata/pata_sl82c105.c
@@ -139,13 +139,13 @@ static void sl82c105_set_dmamode(struct 
 {
 	switch(adev->dma_mode) {
 		case XFER_MW_DMA_0:
-			sl82c105_configure_piomode(ap, adev, 1);
+			sl82c105_configure_piomode(ap, adev, 0);
 			break;
 		case XFER_MW_DMA_1:
 			sl82c105_configure_piomode(ap, adev, 3);
 			break;
 		case XFER_MW_DMA_2:
-			sl82c105_configure_piomode(ap, adev, 3);
+			sl82c105_configure_piomode(ap, adev, 4);
 			break;
 		default:
 			BUG();

