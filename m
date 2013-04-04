From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX PATA cleanup and i.MX51 support
Date: Thu,  4 Apr 2013 11:25:03 +0200
Message-ID: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38439 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430Ab3DDJZ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Apr 2013 05:25:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Shawn Guo <shawn.guo@linaro.org>

The following contains some cleanup and devicetree support for the
i.MX PATA driver. Also i.MX51 PATA support is added.

The first four patches should go via the ata tree, the others through
arm-soc, they do not depend on each other.

Sascha

----------------------------------------------------------------
Sascha Hauer (6):
      ata: i.MX PATA: Use devm_clk_get
      ata: i.MX PATA: cleanup error path
      ata: i.MX PATA: use void __iomem * for regs
      ata: i.MX PATA: add devicetree support
      ARM: i.MX5: Add PATA and SRTC clocks
      ARM: i.MX51: Add PATA support

 Documentation/devicetree/bindings/ata/imx-pata.txt | 17 +++++++++
 .../devicetree/bindings/clock/imx5-clock.txt       |  2 +
 arch/arm/boot/dts/imx51.dtsi                       | 44 ++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c                |  4 +-
 drivers/ata/pata_imx.c                             | 36 +++++++++++++-----
 5 files changed, 92 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
