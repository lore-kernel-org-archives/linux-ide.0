From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.5-rc1
Date: Mon, 11 Jan 2016 14:41:36 -0500
Message-ID: <20160111194136.GJ1898@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34683 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933015AbcAKTli (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2016 14:41:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>

Hello, Linus.

Mostly low level driver specific changes.  Two changes are somewhat
noteworthy.  First, Dan's patchset to support per-port msix interrupt
handling for ahci, which was tried last cycle but had to be backed out
due to a couple issues, is back and seems to be working fine.  Second,
libata exception handling now uses usleep_range() instead of msleep()
for sleeps < 20ms which can make things snappier in some corner cases.

Thanks.

The following changes since commit 4d92f0099a06ef0e36c7673f7c090f1a448b2d1b:

  ahci: Order SATA device IDs for codename Lewisburg (2015-11-16 11:22:16 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.5

for you to fetch changes up to e39b2bb3b72b999a04e8d295882be3255aca5ade:

  libata: skip debounce delay on link resume (2016-01-08 11:50:14 -0500)

----------------------------------------------------------------
Anil Veliyankara Madam (1):
      drivers: libata-core: Use usleep_range() instead of msleep() for short sleeps (<20 ms)

Dan Williams (4):
      ahci: per-port msix support
      ahci: switch from 'threaded' to 'hardirq' interrupt handling
      ahci: kill 'intr_status'
      ahci: compile out msi/msix infrastructure

Danesh Petigara (3):
      ata: ahci_brcmstb: enable support for ALPM
      ata: ahci_brcmstb: disable DIPM support
      libata: skip debounce delay on link resume

Geert Uytterhoeven (1):
      ata: sata_rcar: Remove obsolete platform_device_id entries

Heiner Kallweit (1):
      ata: core: fix irq description on AHCI single irq systems

Insu Yun (1):
      sata_sx4: correctly handling failed allocation

Jaedon Shin (4):
      ata: ahci_brcmstb: disable NCQ for MIPS-based platforms
      ata: ahci_brcmstb: add a quirk for MIPS-based platforms
      ata: ahci_brcmstb: remove unused definitions
      ata: ahci_brcmstb: add support for MIPS-based platforms

Kouei Abe (1):
      sata_rcar: Add compatible string for r8a7795

Tang Yuantian (3):
      ahci: qoriq: Adjust the default register values on ls1043a
      ahci: qoriq: Update the default Rx watermark value
      ahci: qoriq: Adjust the default register values on ls1021a

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
 .../devicetree/bindings/ata/sata_rcar.txt          |  1 +
 drivers/ata/Kconfig                                |  2 +-
 drivers/ata/ahci.c                                 | 67 +++++++++++++++-------
 drivers/ata/ahci.h                                 | 27 ++++++++-
 drivers/ata/ahci_brcmstb.c                         | 61 +++++++++++++++++++-
 drivers/ata/ahci_qoriq.c                           | 31 +++++++---
 drivers/ata/libahci.c                              | 46 ++++++---------
 drivers/ata/libata-core.c                          | 20 ++++++-
 drivers/ata/sata_rcar.c                            | 19 +++---
 drivers/ata/sata_sx4.c                             |  2 +
 include/linux/libata.h                             |  1 +
 12 files changed, 198 insertions(+), 83 deletions(-)

-- 
tejun
