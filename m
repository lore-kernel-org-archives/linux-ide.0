From: oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Subject: [PATCH 0/3] AHCI: sunxi: Add sunxi AHCI driver
Date: Wed,  4 Dec 2013 13:10:52 +0100
Message-ID: <1386159055-10264-1-git-send-email-oliver@schinagl.nl>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDC2JNWXZAJBBZFX7SKAKGQE3BTPKII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

This patch series adds Allwinner sunxi support to platform_ahci.
There are a few quirks here however that will need discussing.

Allwinner added something to setup the DMA engine prior to enabling DMA in
libahci.c. I'm not familiar at all with the AHCI spec and not sure what
the proper way to implement this would have been. Don't other platforms
optionally require the same thing?

Also the way ahci_platform works seems a little hack-ish, it seems like
something along the lines of ahci_platform_register(ahci-data) would be more
appropriate, but not sure yet on those details (I am just a beginner).

Furthermore this driver should, in theory, work on the A10 but on my
cubieboard 1 it does not work yet (just hangs somewhere in libahci or after,
but not the DMA call that was altered). I've also tested it the cubietruck,
cubieboard 2 and olinuxino and it worked fine there.

Thanks,

Oliver

Oliver Schinagl (3):
  RFC: AHCI: libahci is missing DMA
  ARM: sunxi: Add an ahci-platform compatible AHCI driver for the    
    Allwinner SUNXi series of SoCs
  ARM: sunxi: dts: Add ahci support to a few A10 and A20 boards

 .../devicetree/bindings/ata/ahci-sunxi.txt         |  24 ++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |  26 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   9 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  26 ++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  26 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  26 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   9 +
 drivers/ata/Kconfig                                |   9 +
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci.h                                 |   6 +
 drivers/ata/ahci_platform.c                        |  12 +
 drivers/ata/ahci_sunxi.c                           | 305 +++++++++++++++++++++
 drivers/ata/libahci.c                              |   8 +
 13 files changed, 487 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-sunxi.txt
 create mode 100644 drivers/ata/ahci_sunxi.c

-- 
1.8.3.2
