From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH 0/5] MVEBU SATA PHY driver
Date: Wed,  4 Dec 2013 18:15:59 +0100
Message-ID: <1386177364-10164-1-git-send-email-andrew@lunn.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, kishon-l0cyMroinI0@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Marvell Kirkwood and Dove can turn the SATA PHY off in order to save
power. For Dove, this can be in the order of 220mW when its SATA PHY
is turned off.

Andrew Lunn (5):
  Phy: DT binding documentation for Marvell MVEBU SATA phy.
  Phy: Add a PHY driver for Marvell MVEBU SATA PHY.
  SATA: MV: Add support for the optional PHYs
  Phy: Add DT nodes on kirkwood and Dove for the SATA PHY
  ARM: defconfig: Enable generic phy in dove and kirkwood.

 Documentation/devicetree/bindings/ata/marvell.txt  |   6 +
 .../devicetree/bindings/phy/phy-mvebu-sata.txt     |  22 ++++
 arch/arm/boot/dts/dove.dtsi                        |  11 ++
 arch/arm/boot/dts/kirkwood-6281.dtsi               |   2 +
 arch/arm/boot/dts/kirkwood-6282.dtsi               |   2 +
 arch/arm/boot/dts/kirkwood.dtsi                    |  18 +++
 arch/arm/configs/dove_defconfig                    |   1 +
 arch/arm/configs/kirkwood_defconfig                |   1 +
 drivers/ata/sata_mv.c                              |  19 +++
 drivers/phy/Kconfig                                |   5 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-mvebu-sata.c                       | 130 +++++++++++++++++++++
 12 files changed, 218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-sata.txt
 create mode 100644 drivers/phy/phy-mvebu-sata.c

-- 
1.8.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
