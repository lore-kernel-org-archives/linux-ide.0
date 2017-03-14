From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/3] ATA/ARM: convert ARM/DaVinci to use libata PATA drivers
Date: Tue, 14 Mar 2017 17:36:51 +0100
Message-ID: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170314163738epcas5p3db719229d59550476c918a15d8c16d63@epcas5p3.samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36373 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdCNQhm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2017 12:37:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Hi,

This patchset adds Palmchip BK3710 IDE controller driver to
libata and switches ARM/DaVinci to use it (instead of the old
IDE driver).

Sekhar, please check that it still works after changes, thanks.

Changes since v1
(https://www.spinics.net/lists/arm-kernel/msg567442.html):
- addressed review comments from Sergei Shtylyov
- fixed cycle_time unitialized variable issue

Changes since v0.1 draft patch version
(https://www.spinics.net/lists/arm-kernel/msg566932.html):
- fixed cycle_time build warning
- added platform support fixes from Sekhar
- added defconfig changes from Sekhar
- preserved platform support for the old IDE driver
- split it on 3 patches

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (1):
  ata: add Palmchip BK3710 PATA controller driver

Sekhar Nori (2):
  ARM: davinci: add pata_bk3710 libata driver support
  ARM: davinci_all_defconfig: convert to use libata PATA

 arch/arm/configs/davinci_all_defconfig    |   4 +-
 arch/arm/mach-davinci/board-dm644x-evm.c  |   3 +-
 arch/arm/mach-davinci/board-dm646x-evm.c  |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c |   3 +-
 drivers/ata/Kconfig                       |   9 +
 drivers/ata/Makefile                      |   1 +
 drivers/ata/pata_bk3710.c                 | 386 ++++++++++++++++++++++++++++++
 7 files changed, 403 insertions(+), 6 deletions(-)
 create mode 100644 drivers/ata/pata_bk3710.c

-- 
1.9.1

