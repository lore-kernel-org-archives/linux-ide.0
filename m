From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/4] sun8i: r40: add AHCI
Date: Mon,  9 Jul 2018 15:20:54 +0000
Message-ID: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Hello

With Moeicenowy's agreement, I have take leadership ot this patchset.

There are no really changes appart renaming struct quirck to variant.

Since the last serie is really old, I will answer comment here.
The two regulator (1.2 and 2.5V) are not for the PHY since:
- nothing in the schematic said that they are for the PHY, they seems
  only for controller
- all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
  cannot be used for target)

Furthermore, the AHCI binding support only one regulator per PHY, so
using the "target" regulator is out of question for registring this two
non-phy regulator.

I hope this answer all comments done on last version.

Regards

Corentin Labbe (3):
  ata: ahci_sunxi: add support for R40 SATA controller
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

Icenowy Zheng (1):
  dt-bindings: add binding for Allwinner R40 SATA AHCI controller

 .../devicetree/bindings/ata/ahci-platform.txt      |   1 -
 .../bindings/ata/allwinner,sun4i-a10-ahci.txt      |  40 +++++++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  18 +++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |   9 ++
 drivers/ata/ahci_sunxi.c                           | 124 ++++++++++++++++++++-
 5 files changed, 188 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt

-- 
2.16.4
