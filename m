From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] pdc202xx_old: ignore "FIFO empty" bit in test_irq() method
Date: Wed, 14 Apr 2010 19:52:59 +0400
Message-ID: <201004141952.59445.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47312 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755653Ab0DNPxt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Apr 2010 11:53:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net, linux-ide@vger.kernel.org
Cc: rmk@arm.linux.org.uk

The driver takes into account not only the interrupt status bit but also "FIFO
empty" bit in its test_irq() method. This actually is a superfluous check since
for the DMA commands calling the dma_test_irq() method further in the interrupt
handler makes sure FIFO is emptied.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git tree...

Russell, would you mind giving this patch a test?

 drivers/ide/pdc202xx_old.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: ide-2.6/drivers/ide/pdc202xx_old.c
===================================================================
--- ide-2.6.orig/drivers/ide/pdc202xx_old.c
+++ ide-2.6/drivers/ide/pdc202xx_old.c
@@ -93,13 +93,13 @@ static int pdc202xx_test_irq(ide_hwif_t 
 		 * bit 7: error, bit 6: interrupting,
 		 * bit 5: FIFO full, bit 4: FIFO empty
 		 */
-		return ((sc1d & 0x50) == 0x50) ? 1 : 0;
+		return (sc1d & 0x40) ? 1 : 0;
 	} else	{
 		/*
 		 * bit 3: error, bit 2: interrupting,
 		 * bit 1: FIFO full, bit 0: FIFO empty
 		 */
-		return ((sc1d & 0x05) == 0x05) ? 1 : 0;
+		return (sc1d & 0x04) ? 1 : 0;
 	}
 }
 
