From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/6] ata: Missing HAS_DMA dependencies
Date: Tue,  3 Jan 2017 19:09:43 +0100
Message-ID: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

	Hi all,

Bartlomiej's "[PATCH 1/3] ata: allow subsystem to be used on m68k arch"
exposed a few missing dependencies on HAS_DMA. This series allows to
build again "allmodconfig" and "allyesconfig" kernels tailored for
Sun-3, which sets NO_DMA=y.

Geert Uytterhoeven (6):
  ata: SATA_MV should depend on HAS_DMA
  ata: SATA_HIGHBANK should depend on HAS_DMA
  ata: ATA_BMDMA should depend on HAS_DMA
  ata: AHCI and other non-SFF native drivers should depend on HAS_DMA
  libata: Make ata_sg_clean() static again
  libata: Protect DMA core code by #ifdef CONFIG_HAS_DMA

 drivers/ata/Kconfig       |  7 ++++++
 drivers/ata/libata-core.c | 61 +++++++++++++++++++++++++++--------------------
 drivers/ata/libata.h      |  1 -
 3 files changed, 42 insertions(+), 27 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
