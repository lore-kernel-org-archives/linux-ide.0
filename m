From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.14-rc1
Date: Tue, 5 Sep 2017 07:29:59 -0700
Message-ID: <20170905142959.GG1774378@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34305 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbdIEOaD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2017 10:30:03 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org

Hello, Linus.

Nothing major.  Some new platform controller support and device
specific changes.

Thanks.

The following changes since commit 74cbd96bc2e00f5daa805e2ebf49e998f7045062:

  Merge tag 'md/4.13-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/shli/md (2017-07-18 11:51:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.14

for you to fetch changes up to 687abc0f77c239dc4cc93ea5cd27cfad76ddd038:

  dt-bindings: ata: add DT bindings for MediaTek SATA controller (2017-08-29 07:22:24 -0700)

----------------------------------------------------------------
Andrey Korolyov (1):
      cs5536: add support for IDE controller variant

Julia Lawall (1):
      ata: Drop unnecessary static

Linus Walleij (2):
      ata: sata_gemini: Retire custom pin control
      ata: sata_gemini: Introduce explicit IDE pin control

Nate Watterson (1):
      ata: ahci_platform: Add shutdown handler

Philipp Zabel (1):
      ata: sata_gemini: explicitly request exclusive reset control

Rob Herring (1):
      ata: Convert to using %pOF instead of full_name

Ryder Lee (2):
      ata: mediatek: add support for MediaTek SATA controller
      dt-bindings: ata: add DT bindings for MediaTek SATA controller

Sergei Shtylyov (1):
      pata_octeon_cf: use of_property_read_{bool|u32}()

 Documentation/devicetree/bindings/ata/ahci-mtk.txt |  51 ++++++
 drivers/ata/Kconfig                                |  10 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_mtk.c                             | 196 +++++++++++++++++++++
 drivers/ata/ahci_platform.c                        |   1 +
 drivers/ata/libahci_platform.c                     |  34 ++++
 drivers/ata/pata_amd.c                             |   1 +
 drivers/ata/pata_cs5536.c                          |   1 +
 drivers/ata/pata_octeon_cf.c                       |  10 +-
 drivers/ata/sata_gemini.c                          |  67 +++----
 drivers/ata/sata_svw.c                             |   2 +-
 include/linux/ahci_platform.h                      |   2 +
 include/linux/pci_ids.h                            |   1 +
 13 files changed, 337 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
 create mode 100644 drivers/ata/ahci_mtk.c

-- 
tejun
