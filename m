From: Uenal Mutlu <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3] drivers: ata: ahci_sunxi: Increased
 SATA/AHCI DMA TX/RX FIFOs
Date: Mon, 13 May 2019 16:24:10 +0200
Message-ID: <20190513142410.9299-1-um@mutluit.com>
Reply-To: um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDJNR5GB6YGRBK744XTAKGQELPMV4NA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Uenal Mutlu <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amarula-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Pablo Greco <pgreco-/kQrlZ55X3WoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, FUKAUMI Naoki <naobsd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, Stefan Monnier <monnier-CRDzTM1onBSWkKpYnGOUKg@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS, ie.
TX_TRANSACTION_SIZE and RX_TRANSACTION_SIZE) from default 0x0 each
to 0x3 each, gives a write performance boost of 120 MiB/s to 132 MiB/s
from lame 36 MiB/s to 45 MiB/s previously.
Read performance is above 200 MiB/s.
[tested on SSD using dd bs=4K/8K/12K/16K/20K/24K/32K: peak-perf at 12K]

Tested on the SBCs Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 which
are based on the Allwinner A20 32bit-SoC (ARMv7-a / arm-linux-gnueabihf).
These devices are RaspberryPi-like small devices.

This problem of slow SATA write-speed with these small devices lasts
for about 7 years now (beginning with the A10 SoC). Many commentators
throughout the years wrongly assumed the slow write speed was a
hardware limitation. This patch finally solves the problem, which
in fact was just a hard-to-find software problem due to lack of
SATA/AHCI documentation by the SoC-maker Allwinner Technology.

Lists of the affected sunxi and other boards and SoCs with SATA using
the ahci_sunxi driver:
  $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
  and http://linux-sunxi.org/SATA#Devices_with_SATA_ports
  See also http://linux-sunxi.org/Category:Devices_with_SATA_port

Acked-by: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Uenal Mutlu <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
---

v3:
  * Removed RFC from Subject line, and also the explicit call for RFC
    in the text, thereby submitting the patch for official merging.

v2:
  * Commented the patch in-place in ahci_sunxi.c
  * With bs=12K and no conv=... passed to dd, the write performance
    rises further to 132 MiB/s
  * Changed MB/s to MiB/s
  * Posted the story behind the patch:
    http://lkml.iu.edu/hypermail/linux/kernel/1905.1/03506.html
  * Posted a dd test script to find optimal bs, and some results:
    https://bit.ly/2YoOzEM

v1:
  * States bs=4K for dd and a write performance of 120 MiB/s
---
 drivers/ata/ahci_sunxi.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 911710643305..018186a39a69 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -157,8 +157,51 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 
-	/* Setup DMA before DMA start */
-	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
+	/* Setup DMA before DMA start
+	 *
+	 * NOTE: A similar SoC with SATA/AHCI by Texas Instruments documents
+	 *   this Vendor Specific Port (P0DMACR, aka PxDMACR) in its
+	 *   User's Guide document (TMS320C674x/OMAP-L1x Processor
+	 *   Serial ATA (SATA) Controller, Literature Number: SPRUGJ8C,
+	 *   March 2011, Chapter 4.33 Port DMA Control Register (P0DMACR),
+	 *   p.68, https://www.ti.com/lit/ug/sprugj8c/sprugj8c.pdf)
+	 *   as equivalent to the following struct:
+	 *
+	 *   struct AHCI_P0DMACR_t
+	 *   {
+	 *     unsigned TXTS     : 4;
+	 *     unsigned RXTS     : 4;
+	 *     unsigned TXABL    : 4;
+	 *     unsigned RXABL    : 4;
+	 *     unsigned Reserved : 16;
+	 *   };
+	 *
+	 *   TXTS: Transmit Transaction Size (TX_TRANSACTION_SIZE).
+	 *     This field defines the DMA transaction size in DWORDs for
+	 *     transmit (system bus read, device write) operation. [...]
+	 *
+	 *   RXTS: Receive Transaction Size (RX_TRANSACTION_SIZE).
+	 *     This field defines the Port DMA transaction size in DWORDs
+	 *     for receive (system bus write, device read) operation. [...]
+	 *
+	 *   TXABL: Transmit Burst Limit.
+	 *     This field allows software to limit the VBUSP master read
+	 *     burst size. [...]
+	 *
+	 *   RXABL: Receive Burst Limit.
+	 *     Allows software to limit the VBUSP master write burst
+	 *     size. [...]
+	 *
+	 *   Reserved: Reserved.
+	 *
+	 *
+	 * NOTE: According to the above document, the following alternative
+	 *   to the code below could perhaps be a better option
+	 *   (or preparation) for possible further improvements later:
+	 *     sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff,
+	 *		0x00000033);
+	 */
+	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);
 
 	/* Start DMA */
 	sunxi_setbits(port_mmio + PORT_CMD, PORT_CMD_START);
-- 
2.11.0
