From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Fri, 30 Dec 2016 15:01:15 +0100
Message-ID: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

Hi,

This patchset adds m68k/Atari Falcon PATA support to libata.
The major difference in the new libata's pata_falcon host
driver when compared to legacy IDE's falconide host driver is
that we are using polled PIO mode and thus avoiding the need
for STDMA locking magic altogether.

Tested under ARAnyM emulator.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (3):
  ata: allow subsystem to be used on m68k arch
  ata: pass queued command to ->sff_data_xfer method
  ata: add Atari Falcon PATA controller driver

 drivers/ata/Kconfig           |  11 ++-
 drivers/ata/Makefile          |   1 +
 drivers/ata/libata-sff.c      |  29 +++----
 drivers/ata/pata_at91.c       |   6 +-
 drivers/ata/pata_bf54x.c      |   7 +-
 drivers/ata/pata_ep93xx.c     |   4 +-
 drivers/ata/pata_falcon.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_ixp4xx_cf.c  |   4 +-
 drivers/ata/pata_legacy.c     |  15 ++--
 drivers/ata/pata_octeon_cf.c  |  12 +--
 drivers/ata/pata_pcmcia.c     |   6 +-
 drivers/ata/pata_samsung_cf.c |   4 +-
 drivers/ata/sata_rcar.c       |   4 +-
 include/linux/libata.h        |   8 +-
 14 files changed, 247 insertions(+), 48 deletions(-)
 create mode 100644 drivers/ata/pata_falcon.c

-- 
1.9.1
