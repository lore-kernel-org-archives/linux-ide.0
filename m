From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.12-rc1
Date: Mon, 1 May 2017 15:50:08 -0400
Message-ID: <20170501195008.GG8921@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34085 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdEATuL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 May 2017 15:50:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello, Linus.

The biggest core change is removal of SCT WRITE SAME support, which
never worked properly.  Other than that, trivial updates in core code
and specific embedded driver updates.

Thanks.

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.12

for you to fetch changes up to 63ccc191649eb0f14a761074291551d0d2f85389:

  libata: remove SCT WRITE SAME support (2017-04-28 18:09:59 -0400)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ata: allow subsystem to be used on m32r and s390 archs

Bartosz Golaszewski (2):
      ata: ahci: add support for DaVinci DM816 SATA controller
      dt-bindings: ata: add DT bindings for ahci-dm816 SATA controller

Belen Sarabia (1):
      Delete redundant return value check of platform_get_resource()

Bhumika Goyal (1):
      ata: constify of_device_id structures

Boris Brezillon (1):
      pata: remove the at91 driver

Christoph Hellwig (2):
      libata: reject passthrough WRITE SAME requests
      libata: remove SCT WRITE SAME support

Geliang Tang (1):
      libata: use setup_deferrable_timer

Jason Yan (1):
      libata: make ata_sg_clean static over again

 .../devicetree/bindings/ata/ahci-dm816.txt         |  21 +
 drivers/ata/Kconfig                                |  18 +-
 drivers/ata/Makefile                               |   2 +-
 drivers/ata/ahci_dm816.c                           | 200 ++++++++
 drivers/ata/ahci_octeon.c                          |   5 -
 drivers/ata/libata-core.c                          |   8 +-
 drivers/ata/libata-scsi.c                          | 140 ++----
 drivers/ata/pata_at91.c                            | 503 ---------------------
 drivers/ata/pata_macio.c                           |   2 +-
 drivers/ata/pata_mpc52xx.c                         |   2 +-
 drivers/ata/pata_of_platform.c                     |   2 +-
 drivers/ata/sata_fsl.c                             |   2 +-
 drivers/ata/sata_mv.c                              |   2 +-
 include/linux/ata.h                                |   5 -
 14 files changed, 277 insertions(+), 635 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt
 create mode 100644 drivers/ata/ahci_dm816.c
 delete mode 100644 drivers/ata/pata_at91.c

-- 
tejun
