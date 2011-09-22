From: Richard Zhu <richard.zhu@linaro.org>
Subject: [V8 PATCH 0/5] imx53 ahci driver v8
Date: Thu, 22 Sep 2011 18:14:43 +0800
Message-ID: <1316686488-4684-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:15414
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752625Ab1IVKPM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2011 06:15:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

*** BLURB HERE ***
This is the seventh iteration of the imx53 ahci patch. Changes between
v5 and v7 are described in the following description.

ChangeLog v5->v6:
 - Move the most ahci initialization codes from the board related files
   to the common ahci_sata file.

 - Add the imx53 ahci's own ata_port_info definition in ahci_platform
   driver, since the 'ahci_pmp_retry_srst_ops' is required when imx53
   ahci is present.

ChangeLog v6->v7:
 - Define the default imx53 ahci platform data, reduce the modificatons
   on the board related files.

 - Handle the sata_pwr_en pin obviously on smd board.

ChangeLog V7->V8
 - Accept Sascha's suggestions.
   * Rename sata_init/sata_exit to imx_sata_init/imx_sata_exit.
   * move the init/exit as static functions to platform-ahci-imx.c file.
     Make a wrapper on these functions, and avoid to pass the function
     hooks by platform data.


Richard Zhu (5):
  AHCI Add the AHCI SATA feature on the MX53 platforms
  ahci_plt Add the board_ids and pi refer to different features
  MX53 Enable the AHCI SATA on MX53 ARD board
  MX53 Enable the AHCI SATA on MX53 LOCO board
  MX53 Enable the AHCI SATA on MX53 SMD board

 arch/arm/mach-mx5/board-mx53_ard.c              |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c             |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c              |   16 +++
 arch/arm/mach-mx5/clock-mx51-mx53.c             |   19 +++
 arch/arm/mach-mx5/devices-imx53.h               |    2 +
 arch/arm/plat-mxc/devices/Kconfig               |    4 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-ahci-imx.c   |  156 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++
 drivers/ata/ahci_platform.c                     |   44 ++++++-
 10 files changed, 248 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c


