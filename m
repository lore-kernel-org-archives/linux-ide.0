From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 0/5] ATA/ARM: convert ARM/DaVinci to use libata PATA drivers
Date: Wed, 22 Mar 2017 19:20:57 +0100
Message-ID: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170322182127epcas1p267b13e8c92205223458863783bdea476@epcas1p2.samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53181 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935790AbdCVSVb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2017 14:21:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Hi,

This patchset adds Palmchip BK3710 IDE controller driver to
libata and switches ARM/DaVinci to use it (instead of the old
IDE driver).

Sekhar, please check that it still works after changes, thanks.

Changes since v2
(https://www.spinics.net/lists/arm-kernel/msg568597.html):
- fixed 'checkpatch.pl --strict' issues reported by Sekhar
- added chipset initialization fixups in the new patches #2-3
  (based on the review comments from Sergei)

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


Bartlomiej Zolnierkiewicz (3):
  ata: add Palmchip BK3710 PATA controller driver
  pata_bk3710: disable IORDY Timer on chipset initialization
  pata_bk3710: clear status bits of BMISP on chipset initialization

Sekhar Nori (2):
  ARM: davinci: add pata_bk3710 libata driver support
  ARM: davinci_all_defconfig: convert to use libata PATA

 arch/arm/configs/davinci_all_defconfig    |   4 +-
 arch/arm/mach-davinci/board-dm644x-evm.c  |   3 +-
 arch/arm/mach-davinci/board-dm646x-evm.c  |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c |   3 +-
 drivers/ata/Kconfig                       |   9 +
 drivers/ata/Makefile                      |   1 +
 drivers/ata/pata_bk3710.c                 | 382 ++++++++++++++++++++++++++++++
 7 files changed, 399 insertions(+), 6 deletions(-)
 create mode 100644 drivers/ata/pata_bk3710.c

-- 
1.9.1

