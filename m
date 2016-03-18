From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.6-rc1
Date: Fri, 18 Mar 2016 14:27:26 -0400
Message-ID: <20160318182726.GD20028@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33300 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbcCRS1b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2016 14:27:31 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>

Hello, Linus.

libata changes for v4.6-rc1.

* ahci grew runtime power management support so that the controller
  can be turned off if no devices are attached.

* sata_via isn't dead yet.  It got hotplug support and more refined
  workaround for certain WD drives.

* Misc cleanups.  There's a merge from for-4.5-fixes to avoid
  confusing conflicts in ahci PCI ID table.

Thanks.

The following changes since commit dc8b4afc4a04fac8ee55a19b59f2356a25e7e778:

  ata: ahci: don't mark HotPlugCapable Ports as external/removable (2016-02-29 16:17:57 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.6

for you to fetch changes up to 8134233e8d346aaa1c929dc510e75482ae318bce:

  ata: ahci_xgene: dereferencing uninitialized pointer in probe (2016-03-11 12:40:34 -0500)

----------------------------------------------------------------
Aleksey Makarov (1):
      libata: support AHCI on OCTEON platform

Dan Carpenter (1):
      ata: ahci_xgene: dereferencing uninitialized pointer in probe

Lior Amsalem (1):
      ata: ahci_mvebu: add support for Armada 3700 variant

Mika Westerberg (7):
      block: Add blk_set_runtime_active()
      scsi: Set request queue runtime PM status back to active on resume
      scsi: Drop runtime PM usage count after host is added
      ahci: Cache host controller version
      ahci: Convert driver to use modern PM hooks
      ahci: Add functions to manage runtime PM of AHCI ports
      ahci: Add runtime PM support for the host controller

Ondrej Zary (2):
      sata_via: Apply WD workaround only when needed on VT6421
      sata_via: Implement hotplug for VT6421

Scott Lawson (1):
      AHCI: Remove obsolete Intel Lewisburg SATA RAID device IDs

Simon Horman (1):
      ata: sata_rcar: Use ARCH_RENESAS

Tejun Heo (2):
      libata: fix unbalanced spin_lock_irqsave/spin_unlock_irq() in ata_scsi_park_show()
      Merge branch 'for-4.5-fixes' into for-4.6

 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  42 +++++++
 arch/mips/include/asm/octeon/cvmx.h                |   9 ++
 block/blk-core.c                                   |  24 ++++
 drivers/ata/Kconfig                                |  11 +-
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci.c                                 | 108 ++++++++++++-----
 drivers/ata/ahci.h                                 |   1 +
 drivers/ata/ahci_mvebu.c                           |  14 ++-
 drivers/ata/ahci_octeon.c                          | 105 ++++++++++++++++
 drivers/ata/ahci_platform.c                        |   1 +
 drivers/ata/ahci_xgene.c                           |   4 +-
 drivers/ata/libahci.c                              |  55 ++++++++-
 drivers/ata/libata-scsi.c                          |   4 +-
 drivers/ata/sata_via.c                             | 133 +++++++++++++++++++--
 drivers/scsi/hosts.c                               |   7 ++
 drivers/scsi/scsi_pm.c                             |  10 ++
 include/linux/blkdev.h                             |   2 +
 18 files changed, 475 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
 create mode 100644 drivers/ata/ahci_octeon.c

-- 
tejun
