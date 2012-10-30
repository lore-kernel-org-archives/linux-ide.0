From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH v2 0/6] Adding support for SATA in EXYNO5
Date: Tue, 30 Oct 2012 17:01:31 +0100
Message-ID: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>
List-Id: linux-ide@vger.kernel.org

The following set of patches provides drivers for SATA
and SATA PHY controller and also an interface for the
two entity to interact.

Vasanth Ananthan (6):
  ARM: EXYNOS5: Clock settings for SATA and SATA PHY
  ARM: EXYNOS5: DT Support for SATA and SATA PHY
  DRIVERS: ATA: SATA PHY utility framework
  DRIVERS:I2C: I2C driver polling mode support
  DRIVERS: ATA:  SATA controller driver
  DRIVERS: ATA: SATA PHY controller driver

 .../devicetree/bindings/ata/exynos-sata-phy.txt    |   14 +
 .../devicetree/bindings/ata/exynos-sata.txt        |   17 ++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   15 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   18 ++
 arch/arm/mach-exynos/clock-exynos5.c               |   21 ++-
 arch/arm/mach-exynos/include/mach/map.h            |    3 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h       |    3 +
 arch/arm/mach-exynos/include/mach/regs-sata.h      |   29 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    6 +
 drivers/ata/Kconfig                                |   22 ++
 drivers/ata/Makefile                               |    2 +
 drivers/ata/sata_exynos.c                          |  268 +++++++++++++++++
 drivers/ata/sata_exynos_phy.c                      |  300 ++++++++++++++++++++
 drivers/ata/sata_phy.c                             |  104 +++++++
 drivers/ata/sata_phy.h                             |   44 +++
 drivers/i2c/busses/i2c-s3c2410.c                   |   79 ++++--
 16 files changed, 923 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
 create mode 100644 Documentation/devicetree/bindings/ata/exynos-sata.txt
 create mode 100644 arch/arm/mach-exynos/include/mach/regs-sata.h
 create mode 100644 drivers/ata/sata_exynos.c
 create mode 100644 drivers/ata/sata_exynos_phy.c
 create mode 100644 drivers/ata/sata_phy.c
 create mode 100644 drivers/ata/sata_phy.h

-- 
1.7.4.1
