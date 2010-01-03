From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Fix Promise UDMA33 IDE driver (pdc202xx_old)
Date: Sun, 3 Jan 2010 22:35:42 +0000
Message-ID: <20100103223542.GA24920@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42622 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab0ACWf5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jan 2010 17:35:57 -0500
Content-Disposition: inline
In-Reply-To: <20100103002314.GA16528@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Sun, Jan 03, 2010 at 12:23:14AM +0000, Russell King wrote:
> - with IDE
>   - locks the interrupt line, and makes the machine extremely painful -
>     about an hour to get to the point of being able to unload the
>     pdc202xx_old module.

Having manually bisected kernel versions, I've narrowed it down to some
change between 2.6.30 and 2.6.31.  There's not much which has changed
between the two kernels, but one change stands out like a sore thumb:

+static int pdc202xx_test_irq(ide_hwif_t *hwif)
+{
+       struct pci_dev *dev     = to_pci_dev(hwif->dev);
+       unsigned long high_16   = pci_resource_start(dev, 4);
+       u8 sc1d                 = inb(high_16 + 0x1d);
+
+       if (hwif->channel) {
+               /*
+                * bit 7: error, bit 6: interrupting,
+                * bit 5: FIFO full, bit 4: FIFO empty
+                */
+               return ((sc1d & 0x50) == 0x40) ? 1 : 0;
+       } else  {
+               /*
+                * bit 3: error, bit 2: interrupting,
+                * bit 1: FIFO full, bit 0: FIFO empty
+                */
+               return ((sc1d & 0x05) == 0x04) ? 1 : 0;
+       }
+}

Reading the (documented as a 32-bit) system control register when the
interface is idle gives: 0x01da110c

So, the byte at 0x1d is 0x11, which is documented as meaning that the
primary and secondary FIFOs are empty.

The code above, which is trying to see whether an IRQ is pending, checks
for the IRQ bit to be one, and the FIFO bit to be zero - or in English,
to be non-empty.

Since during a BM-DMA read, the FIFOs will naturally be drained to the
PCI bus, the chance of us getting to the interface before this happens
are extremely small - and if we don't, it means we decide not to service
the interrupt.  Hence, the screaming interrupt problem with drivers/ide.

Fix this by only indicating an interrupt is ready if both the interrupt
and FIFO empty bits are at '1'.

This bug only affects PDC20246/PDC20247 (Promise Ultra33) based cards,
and has been tested on 2.6.31 and 2.6.33-rc2.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ide/pdc202xx_old.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/pdc202xx_old.c b/drivers/ide/pdc202xx_old.c
index cb812f3..f5c08f4 100644
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
@@ -100,13 +100,13 @@ static int pdc202xx_test_irq(ide_hwif_t *hwif)
 		 * bit 7: error, bit 6: interrupting,
 		 * bit 5: FIFO full, bit 4: FIFO empty
 		 */
-		return ((sc1d & 0x50) == 0x40) ? 1 : 0;
+		return ((sc1d & 0x50) == 0x50) ? 1 : 0;
 	} else	{
 		/*
 		 * bit 3: error, bit 2: interrupting,
 		 * bit 1: FIFO full, bit 0: FIFO empty
 		 */
-		return ((sc1d & 0x05) == 0x04) ? 1 : 0;
+		return ((sc1d & 0x05) == 0x05) ? 1 : 0;
 	}
 }
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
