From: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 00/13] ata: ahci_platform: support allwinner
 R40 AHCI
Date: Thu, 30 Aug 2018 21:01:07 +0200
Message-ID: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Reply-To: clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBD7YLCN32UNBBCP6UDOAKGQEODPDBUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hello

This patchset add support for allwinner R40 AHCI controller.

The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
by this serie, so no regression should come with it.

The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
but will be resent for inclustion when all patchs will have hit linus
tree.

Changes since v3:
- Moved PHY code to a new sun4i-a10-phy-sata driver
- Removed reset code since ahci_platform support now reset controller.

Changes since V2
- Moved all ressources management to ahci_platform

Corentin Labbe (13):
  dt-bindings: ata: ahci-platform: fix indentation of target-supply
  ata: ahci_platform: add support for AHCI controller regulator
  dt-bindings: ata: ahci-platform: document ahci-supply
  phy: Add sun4i-a10-phy-sata driver
  dt-bindings: phy: document sun4i-a10-sata-phy
  dt-bindings: ata: update ahci_sunxi bindings
  ata: ahci_sunxi: Bypass PHY init when using the new binding
  ata: ahci_sunxi: add support for r40
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
  ARM: dts: sun7i: a20: add sata-port/sata-phy nodes
  ARM: dts: sun4i: a10: add sata-port/sata-phy nodes
  ata: ahci_sunxi: remove PHY code

 .../devicetree/bindings/ata/ahci-platform.txt      |  11 +-
 .../devicetree/bindings/phy/sun4i-sata-phy.txt     |  20 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  13 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  13 ++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  21 +++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  23 +++
 drivers/ata/ahci.h                                 |   1 +
 drivers/ata/ahci_sunxi.c                           |  87 +--------
 drivers/ata/libahci_platform.c                     |  26 ++-
 drivers/phy/allwinner/Kconfig                      |   7 +
 drivers/phy/allwinner/Makefile                     |   1 +
 drivers/phy/allwinner/phy-sun4i-sata.c             | 208 +++++++++++++++++++++
 12 files changed, 343 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt
 create mode 100644 drivers/phy/allwinner/phy-sun4i-sata.c

-- 
2.16.4
