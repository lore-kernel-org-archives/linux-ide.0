From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 0/9] ARM: at91 cleanups for 4.1 #2
Date: Mon, 23 Mar 2015 20:29:06 +0100
Message-ID: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

Hi,

This patch set finishes the clean up of the mach-at91 directory.

It fixes the remaining two drivers (at91_cf and pata_at91) so that they compile
in a multiplatform configuration.

Then it removes the uneeded headers.

Changes in v2:
 - remove incorrect tabs in atmel-mc.h
 - collected acks
 - Added a new patch to remove Makefile.boot
 - improved the commit massage of the first patch

Alexandre Belloni (8):
  ata: at91: use syscon to configure the smc
  ARM: at91: drop sam9_smc.c
  ARM: at91: declare the at91rm9200 memory controller as a syscon
  pcmcia: at91_cf: Use syscon to configure the MC/smc
  ARM: at91/pm: use the atmel-mc syscon defines
  ARM: at91: remove mach/at91_ramc.h and mach/at91rm9200_mc.h
  ARM: at91: remove at91rm9200_sdramc.h
  ARM: at91: remove useless Makefile.boot

Boris Brezillon (1):
  mfd: syscon: Add Atmel MC (Memory Controller) registers definition

 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
 arch/arm/mach-at91/Makefile                        |   5 -
 arch/arm/mach-at91/Makefile.boot                   |   8 --
 arch/arm/mach-at91/include/mach/at91_ramc.h        |  28 ----
 arch/arm/mach-at91/include/mach/at91rm9200_mc.h    | 116 -----------------
 arch/arm/mach-at91/include/mach/at91sam9_smc.h     |  98 --------------
 arch/arm/mach-at91/pm.c                            |   8 +-
 arch/arm/mach-at91/pm.h                            |  14 +-
 arch/arm/mach-at91/pm_suspend.S                    |   3 +-
 arch/arm/mach-at91/sam9_smc.c                      | 136 -------------------
 arch/arm/mach-at91/sam9_smc.h                      |  11 --
 drivers/ata/Kconfig                                |   1 -
 drivers/ata/pata_at91.c                            |  92 ++++++++++---
 drivers/pcmcia/Kconfig                             |   1 -
 drivers/pcmcia/at91_cf.c                           |  25 ++--
 include/linux/mfd/syscon/atmel-mc.h                | 144 +++++++++++++++++++++
 include/soc/at91/at91rm9200_sdramc.h               |  63 ---------
 18 files changed, 249 insertions(+), 508 deletions(-)
 delete mode 100644 arch/arm/mach-at91/Makefile.boot
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_mc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9_smc.h
 delete mode 100644 arch/arm/mach-at91/sam9_smc.c
 delete mode 100644 arch/arm/mach-at91/sam9_smc.h
 create mode 100644 include/linux/mfd/syscon/atmel-mc.h
 delete mode 100644 include/soc/at91/at91rm9200_sdramc.h

-- 
2.1.0
