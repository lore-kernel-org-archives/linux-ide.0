From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/10] ARM: da850-lcdk: add SATA support
Date: Fri, 13 Jan 2017 13:37:54 +0100
Message-ID: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
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
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This series contains all the changes necessary to make SATA work on
the da850-lcdk board.

The first patch adds a clock lookup entry required for the ahci core
to retrieve a functional clock.

The second enables relevant config options for all davinci boards.

The third adds device tree bindings for the ahci_da850 driver.

The fourth adds a workaround for a SATA controller instability we
detected after increasing the PLL0 frequency for proper LCD
controller support.

Patches 5 through 7 extend the ahci_da850 driver - add DT support,
un-hardcode the clock multiplier value and add a workaround for
a quirk present on the da850 SATA controller.

Patches 8-10 add the device tree changes required to probe the driver.

I'm posting the series as a whole to give all reviewers the full
picture and visibility of the changes required, if needed I can resend
the patches separately.

Bartosz Golaszewski (10):
  ARM: davinci: add a clock lookup entry for the SATA clock
  ARM: davinci_all_defconfig: enable SATA modules
  devicetree: bindings: add bindings for ahci-da850
  sata: hardreset: retry if phys link is down
  sata: ahci_da850: add device tree match table
  sata: ahci_da850: implement a softreset quirk
  sata: ahci_da850: add support for the da850,clk_multiplier DT property
  ARM: dts: da850: add pinmux settings for the SATA controller
  ARM: dts: da850: add the SATA node
  ARM: dts: da850-lcdk: enable the SATA node

 .../devicetree/bindings/ata/ahci-da850.txt         |  21 ++++
 arch/arm/boot/dts/da850-lcdk.dts                   |   5 +
 arch/arm/boot/dts/da850.dtsi                       |  30 ++++++
 arch/arm/configs/davinci_all_defconfig             |   2 +
 arch/arm/mach-davinci/da8xx-dt.c                   |   1 +
 drivers/ata/ahci_da850.c                           | 112 +++++++++++++++++++--
 drivers/ata/libata-core.c                          |  16 ++-
 include/linux/libata.h                             |   4 +-
 8 files changed, 177 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

-- 
2.9.3
