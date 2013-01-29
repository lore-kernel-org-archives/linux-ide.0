From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH 0/2] Adding SATA PHY framework and PHY controller driver
Date: Tue, 29 Jan 2013 20:49:16 +0530
Message-ID: <1359472758-31350-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, girish.shivananjappa@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>
List-Id: linux-ide@vger.kernel.org

Adding SATA PHY framework. The framework acts as an interface
between the SATA controller and the PHY controller.

The framework can be used by any platform with device tree support.
It primarily serves to de-couple the SATA controller driver and the
PHY controller driver.

Vasanth Ananthan (2):
  driver: ata: SATA PHY framework
  driver: ata: add new Exynos5250 SATA PHY controller driver

 arch/arm/mach-exynos/include/mach/regs-pmu.h  |    3 +
 arch/arm/mach-exynos/include/mach/regs-sata.h |   29 +++
 drivers/ata/Kconfig                           |   10 +
 drivers/ata/Makefile                          |    1 +
 drivers/ata/sata_exynos_phy.c                 |  265 +++++++++++++++++++++++++
 drivers/ata/sata_phy.c                        |  145 ++++++++++++++
 drivers/ata/sata_phy.h                        |   29 +++
 7 files changed, 482 insertions(+)
 create mode 100644 arch/arm/mach-exynos/include/mach/regs-sata.h
 create mode 100644 drivers/ata/sata_exynos_phy.c
 create mode 100644 drivers/ata/sata_phy.c
 create mode 100644 drivers/ata/sata_phy.h

-- 
1.7.9.5
