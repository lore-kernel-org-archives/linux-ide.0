From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 0/4] PHY Driver for Marvell SATA
Date: Thu, 26 Dec 2013 18:25:38 +0100
Message-ID: <1388078742-6726-1-git-send-email-andrew@lunn.ch>
References: <20131219194237.GC22725@htj.dyndns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42348 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab3LZR0u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Dec 2013 12:26:50 -0500
In-Reply-To: <20131219194237.GC22725@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, kishon@ti.com, tj@kernel.org
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Andrew Lunn <andrew@lunn.ch>

This version adds the requested checking of return values
in sata_mv.c. The other patches are unchanged.

Andrew Lunn (4):
  Phy: DT binding documentation for Marvell MVEBU SATA phy.
  Phy: Add a PHY driver for Marvell MVEBU SATA PHY.
  SATA: MV: Add support for the optional PHYs
  Phy: Add DT nodes on kirkwood and Dove for the SATA PHY

 Documentation/devicetree/bindings/ata/marvell.txt  |    6 +
 .../devicetree/bindings/phy/mvebu-phy.txt          |   22 ++++
 arch/arm/boot/dts/dove.dtsi                        |   11 ++
 arch/arm/boot/dts/kirkwood-6281.dtsi               |    2 +
 arch/arm/boot/dts/kirkwood-6282.dtsi               |    2 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   18 +++
 drivers/ata/sata_mv.c                              |   27 ++++
 drivers/phy/Kconfig                                |    6 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-mvebu-sata.c                       |  137 ++++++++++++++++++++
 10 files changed, 232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mvebu-phy.txt
 create mode 100644 drivers/phy/phy-mvebu-sata.c

-- 
1.7.10.4

