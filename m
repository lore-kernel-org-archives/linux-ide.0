From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH 0/6] Adding support for SATA in EXYNO5
Date: Tue,  9 Oct 2012 17:18:46 +0530
Message-ID: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
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
  ARM: S3C2410: I2C driver polling mode support
  ARM: EYNOS5: SATA controller driver
  ARM: EXYNOS5: SATA PHY controller driver

 arch/arm/boot/dts/exynos5250-smdk5250.dts    |   11 +
 arch/arm/boot/dts/exynos5250.dtsi            |   20 ++
 arch/arm/mach-exynos/clock-exynos5.c         |   19 ++-
 arch/arm/mach-exynos/include/mach/map.h      |    7 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    3 +
 arch/arm/mach-exynos/mach-exynos5-dt.c       |    6 +
 drivers/ata/Kconfig                          |    9 +
 drivers/ata/Makefile                         |    1 +
 drivers/ata/sata_exynos.c                    |  274 +++++++++++++++++++++++
 drivers/ata/sata_exynos_phy.c                |  303 ++++++++++++++++++++++++++
 drivers/ata/sata_phy.c                       |   99 +++++++++
 drivers/ata/sata_phy.h                       |   44 ++++
 drivers/i2c/busses/i2c-s3c2410.c             |   84 ++++++--
 13 files changed, 859 insertions(+), 21 deletions(-)
 create mode 100644 drivers/ata/sata_exynos.c
 create mode 100644 drivers/ata/sata_exynos_phy.c
 create mode 100644 drivers/ata/sata_phy.c
 create mode 100644 drivers/ata/sata_phy.h

-- 
1.7.5.4
