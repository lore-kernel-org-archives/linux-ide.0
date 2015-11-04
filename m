From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.4-rc1
Date: Wed, 4 Nov 2015 15:54:21 -0500
Message-ID: <20151104205421.GB396@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36134 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030264AbbKDUyZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Nov 2015 15:54:25 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>

Hello, Linus.

Most are ahci and other device specific additions.  Dan cleaned up
ahci IRQ handling to prepare for future MSIX changes.  On the libata
core side, Vinayak updated SG handling so that NCQ commands can be
issued through SG_IO and Christoph cleaned up code a bit.  There's one
merge from for-4.3-fixes to include a pata_macio commit that didn't
get pushed out.

Thanks.

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.4

for you to fetch changes up to 159b5bb46492e4dcef2070b12861030bc360402b:

  Merge branch 'for-4.3-fixes' into for-4.4 (2015-11-03 17:29:03 -0500)

----------------------------------------------------------------
Alexandra Yates (1):
      ahci: add new Intel device IDs

Andrzej Hajda (1):
      libata: samsung_cf: fix handling platform_get_irq result

Arnd Bergmann (1):
      ahci: qoriq: Fix a compiling warning

Christoph Hellwig (2):
      libata: cleanup ata_scsi_qc_complete
      libata: only call ->done once all per-tag ressources are released

Dan Williams (2):
      ahci: ahci_host_activate: kill IRQF_SHARED
      ahci: cleanup ahci_host_activate_multi_irqs

Johannes Thumshirn (1):
      ahci: Add Marvell 88se91a2 device id

LABBE Corentin (1):
      pata_it821x: use "const char *" for string literals

Luis de Bethencourt (1):
      ata: pata_macio: Fix module autoload for OF platform driver

Manuel Lauss (1):
      ata: ahci: find eSATA ports and flag them as removable

Robert Jarzmik (1):
      ata: pata_pxa: dmaengine conversion

Tang Yuantian (6):
      Revert "ahci: added support for Freescale AHCI sata"
      devicetree:bindings: add devicetree bindings for Freescale AHCI
      ahci: added a new driver for supporting Freescale AHCI sata
      ahci: qoriq: Rename LS2085A SoC support code to LS2080A
      ahci: qoriq: Disable NCQ on ls2080a SoC
      devicetree: bindings: Fixed a few typos

Tejun Heo (1):
      Merge branch 'for-4.3-fixes' into for-4.4

Vinayak Kale (2):
      libata: add support for NCQ commands for SG interface
      libata: enable LBA flag in taskfile for ata_scsi_pass_thru()

 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |  21 ++
 .../devicetree/bindings/ata/ahci-platform.txt      |   2 -
 drivers/ata/Kconfig                                |   9 +
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci.c                                 |  12 +
 drivers/ata/ahci.h                                 |   2 +
 drivers/ata/ahci_platform.c                        |   1 -
 drivers/ata/ahci_qoriq.c                           | 279 +++++++++++++++++++++
 drivers/ata/libahci.c                              |  30 +--
 drivers/ata/libata-scsi.c                          |  59 +++--
 drivers/ata/pata_it821x.c                          |   6 +-
 drivers/ata/pata_macio.c                           |   1 +
 drivers/ata/pata_pxa.c                             | 171 +++++--------
 drivers/ata/pata_samsung_cf.c                      |   2 +-
 include/linux/libata.h                             |   1 +
 15 files changed, 433 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
 create mode 100644 drivers/ata/ahci_qoriq.c

-- 
tejun
