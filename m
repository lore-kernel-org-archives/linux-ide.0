From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH v5 0/3] ahci: enable ahci sata support on imx6q
Date: Thu, 11 Jul 2013 17:10:28 +0800
Message-ID: <1373533831-9500-1-git-send-email-Hong-Xing.Zhu@freescale.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawn.guo@linaro.org
Cc: s.hauer@pengutronix.de, rob.herring@calxeda.com, linux-ide@vger.kernel.org, tj@kernel.org, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

V5: add imx6q specific ahci sata support
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

[v5 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
[v5 2/3] ARM: imx6q: update the sata bits definitions of gpr13
[v5 3/3] sata: imx: add ahci sata support on imx platforms

arch/arm/boot/dts/imx6q-sabreauto.dts       |    4 +
arch/arm/boot/dts/imx6q-sabrelite.dts       |    4 +
arch/arm/boot/dts/imx6q-sabresd.dts         |    4 +
arch/arm/boot/dts/imx6q.dtsi                |    9 +
drivers/ata/Kconfig                         |    9 +
drivers/ata/Makefile                        |    1 +
drivers/ata/sata_imx.c                      |  233 +++++++++++++++++++++++++++
include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  121 ++++++++++-----
8 files changed, 348 insertions(+), 37 deletions(-)
