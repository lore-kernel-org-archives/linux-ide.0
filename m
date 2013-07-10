From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH v4 0/3] ahci: enable ahci sata support on imx6q
Date: Wed, 10 Jul 2013 16:35:52 +0800
Message-ID: <1373445355-11453-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45014 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab3GJIdg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jul 2013 04:33:36 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so6495066pac.29
        for <linux-ide@vger.kernel.org>; Wed, 10 Jul 2013 01:33:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org

V4: add imx6q specific ahci sata support
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

[v4 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
[v4 2/3] ARM: imx6q: update the sata bits definitions of gpr13
[v4 3/3] sata: imx: add ahci sata support on imx platforms

arch/arm/boot/dts/imx6q-sabreauto.dts       |    4 +
arch/arm/boot/dts/imx6q-sabrelite.dts       |    4 +
arch/arm/boot/dts/imx6q-sabresd.dts         |    4 +
arch/arm/boot/dts/imx6q.dtsi                |    9 +
drivers/ata/Kconfig                         |    9 +
drivers/ata/Makefile                        |    1 +
drivers/ata/sata_imx.c                      |  237 +++++++++++++++++++++++++++
include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  121 ++++++++++----
8 files changed, 352 insertions(+), 37 deletions(-)

