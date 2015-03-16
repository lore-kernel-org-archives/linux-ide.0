From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 00/10] ARM: at91 cleanups for 4.1 #2
Date: Mon, 16 Mar 2015 23:44:36 +0100
Message-ID: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

Hi,

This patch set finishes the clean up of the mach-at91 directory.

It fixed the remaining two drivers (at91_cf and pata_at91) so that they compile
in a multiplatform configuration.

Then it removes the uneeded headers.


Alexandre Belloni (9):
  ARM: at91/pm: move the standby functions to pm.c
  ARM: at91/pm: move AT91_MEMCTRL_* to pm.h
  ata: at91: use syscon to configure the smc
  ARM: at91: drop sam9_smc.c
  ARM: at91: declare the at91rm9200 memory controller as a syscon
  pcmcia: at91_cf: Use syscon to configure the MC/smc
  ARM: at91/pm: use the atmel-mc syscon defines
  ARM: at91: remove mach/at91_ramc.h and mach/at91rm9200_mc.h
  ARM: at91: remove at91rm9200_sdramc.h

Boris Brezillon (1):
  mfd: syscon: Add Atmel MC (Memory Controller) registers definition

 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
 arch/arm/mach-at91/Makefile                        |   5 -
 arch/arm/mach-at91/include/mach/at91_ramc.h        |  32 -----
 arch/arm/mach-at91/include/mach/at91rm9200_mc.h    | 116 -----------------
 arch/arm/mach-at91/include/mach/at91sam9_smc.h     |  98 --------------
 arch/arm/mach-at91/pm.c                            |  91 ++++++++++++-
 arch/arm/mach-at91/pm.h                            | 110 +++-------------
 arch/arm/mach-at91/pm_suspend.S                    |   3 +-
 arch/arm/mach-at91/sam9_smc.c                      | 136 -------------------
 arch/arm/mach-at91/sam9_smc.h                      |  11 --
 drivers/ata/Kconfig                                |   1 -
 drivers/ata/pata_at91.c                            |  92 ++++++++++---
 drivers/pcmcia/Kconfig                             |   1 -
 drivers/pcmcia/at91_cf.c                           |  25 ++--
 include/linux/mfd/syscon/atmel-mc.h                | 144 +++++++++++++++++++++
 include/soc/at91/at91rm9200_sdramc.h               |  63 ---------
 17 files changed, 339 insertions(+), 593 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_mc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9_smc.h
 delete mode 100644 arch/arm/mach-at91/sam9_smc.c
 delete mode 100644 arch/arm/mach-at91/sam9_smc.h
 create mode 100644 include/linux/mfd/syscon/atmel-mc.h
 delete mode 100644 include/soc/at91/at91rm9200_sdramc.h

-- 
2.1.0
