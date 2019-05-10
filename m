From: Uenal Mutlu <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH] drivers: ata: ahci_sunxi: Increased
 SATA/AHCI DMA TX/RX FIFOs
Date: Fri, 10 May 2019 21:25:50 +0200
Message-ID: <20190510192550.17458-1-um@mutluit.com>
Reply-To: um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDJNR5GB6YGRBH5B27TAKGQEJLOQLKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Uenal Mutlu <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org, linux-amarula-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Pablo Greco <pgreco-/kQrlZ55X3WoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, FUKAUMI Naoki <naobsd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS) from
default 0x0 each to 0x3 each gives a write performance boost of 120MB/s
from lame 36MB/s to 45MB/s previously. Read performance is about 200MB/s
[tested on SSD using dd bs=4K count=512K].

Tested on the Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 SBCs
with Allwinner A20 32bit-SoCs (ARMv7-a / arm-linux-gnueabihf).
These devices are RaspberryPi-like small devices.

RFC: Since more than about 25 similar SBC/SoC models do use the
ahci_sunxi driver, users are encouraged to test it on all the
affected boards and give feedback.

List of the affected sunxi and other boards and SoCs with SATA using
the ahci_sunxi driver:
  $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
  and http://linux-sunxi.org/Category:Devices_with_SATA_port

Signed-off-by: Uenal Mutlu <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
---
 drivers/ata/ahci_sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 911710643305..257986431c79 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -158,7 +158,7 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 
 	/* Setup DMA before DMA start */
-	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
+	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);
 
 	/* Start DMA */
 	sunxi_setbits(port_mmio + PORT_CMD, PORT_CMD_START);
-- 
2.11.0
