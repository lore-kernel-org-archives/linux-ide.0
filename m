From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH v7 0/3] ahci: enable ahci sata support on imx6q
Date: Tue, 16 Jul 2013 11:28:45 +0800
Message-ID: <1373945328-20893-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35762 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3GPD0V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jul 2013 23:26:21 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so191230pdd.20
        for <linux-ide@vger.kernel.org>; Mon, 15 Jul 2013 20:26:20 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org

v7: add imx6q specific ahci sata support
  Thanks to Sergei Shtylyow and Shawn.
  - According to ePAPR [1] section 2.2.2, re-name
  the node from 'ahci' to 'sata'
  - Move the initialization of the ahb clock of the private
  data to the probe function.
  - Remove the platform_set_drvdata(..., NULL), and devm_clk_put
  (..., ...).
  - 

v6: http://www.spinics.net/lists/linux-ide/msg45719.html
  Thanks for Shawn's comments.
  - Speicify the ahb clock in the sata related dts changes.
  - Move the initialization of the sata PHY clock of the private
  data to the probe function.
  - Remove the empty device release function.
  - In order to be more readable, rename the imx_dev/imx_ahci_pdev
  to be ahci_dev/ahci_pdev, and do some other changes, such as typo
  error, more readable name of the variable.
  - 

v5: http://www.spinics.net/lists/linux-ide/msg45712.html
  - Fix the wrong referrence usage of the private data.
  - Use the private data to contain the poninter of the PHY
  signals adjustment window(gpr)
  - Tested on imx6q sd board.
  - 

v4: http://www.spinics.net/lists/linux-ide/msg45699.html
  Thanks for the review comments provided by Sascha, and Alexander.
  - Use the private data and keep a pointer to the PHY clock.
  - Don't use the global platform device variable, because that
  it would make the driver broken for mutiple instances.
  - Don't do the "writel" with assignment.
  - Other minor changes, such as print the error code when printing
  error message, use a u32 type to store readl results, and so on.

v3: http://www.spinics.net/lists/linux-ide/msg45688.html
  - Keep arch/arm and ahci_platform driver clean.
  - Add the sata_imx standalone driver contained all the
  specific setup
  - Add the release function, support the loadable module
  driver.
  - Tested on imx6q sd board.

v2: http://www.spinics.net/lists/linux-ide/msg45666.html 
 - Setup standalone imx ahci sata driver, because of
 the misalignments of the bits definition of the HBA register.
 - Replace the node by the label in the board dts.
 - 

v1: http://www.spinics.net/lists/linux-ide/msg45581.html
 - add imx6q specific ahci sata support to arch/arm/mach-imx/mach-imx6q.c

These patches is based on imx/dt branch of
"http://git.linaro.org/git-ro/people/shawnguo/linux-2.6.git"

[v7 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
[v7 2/3] ARM: imx6q: update the sata bits definitions of gpr13
[v7 3/3] sata: imx: add ahci sata support on imx platforms

arch/arm/boot/dts/imx6q-sabreauto.dts       |    4 +
arch/arm/boot/dts/imx6q-sabrelite.dts       |    4 +
arch/arm/boot/dts/imx6q-sabresd.dts         |    4 +
arch/arm/boot/dts/imx6q.dtsi                |    9 +
drivers/ata/Kconfig                         |    9 +
drivers/ata/Makefile                        |    1 +
drivers/ata/sata_imx.c                      |  236 +++++++++++++++++++++++++++
include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  121 ++++++++++----
8 files changed, 351 insertions(+), 37 deletions(-)
