From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V9 0/5] imx53 ahci driver v9
Date: Wed, 28 Sep 2011 15:41:52 +0800
Message-ID: <1317195717-21174-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, eric.miao@linaro.org, linux-ide@vger.kernel.org, Richard Zhu <richard.zhu@linaro.org>, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

*** BLURB HERE ***
This is the seventh iteration of the imx53 ahci patch. Changes between
v5 and v7 are described in the following description.

ChangeLog v5->v6:
 - Move the most ahci initialization codes from the board related files
   to the common ahci_sata file.

 - Add the imx53 ahci's own ata_port_info definition in ahci_platform
   driver, since the 'ahci_pmp_retry_srst_ops' is required when imx53
   ahci is present.
 V6: http://www.spinics.net/lists/arm-kernel/msg138254.html

ChangeLog v6->v7:
 - Define the default imx53 ahci platform data, reduce the modificatons
   on the board related files.

 - Handle the sata_pwr_en pin obviously on smd board.
 V7: http://www.spinics.net/lists/arm-kernel/msg138569.html

ChangeLog V7->V8
 - Accept Sascha's suggestions.
   * Rename sata_init/sata_exit to imx_sata_init/imx_sata_exit.
   * move the init/exit as static functions to platform-ahci-imx.c file.
     Make a wrapper on these functions, and avoid to pass the function
     hooks by platform data.
   V8: http://www.spinics.net/lists/arm-kernel/msg141500.html

ChangeLog V8->V9
 - Use gpio_request_one to replace the gpio_request and gpio_direction_output
   when enable the sata power on mx53 smd board.

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
