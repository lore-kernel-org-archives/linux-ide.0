From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.9-rc1
Date: Thu, 13 Oct 2016 20:59:31 -0400
Message-ID: <20161014005931.GK32534@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34689 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755218AbcJNA7v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2016 20:59:51 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

libata changes for v4.9.

* Write same support added.
* Minor ahci MSIX irq handling updates.
* Non-critical SCSI command translation fixes.
* Controller specific changes.

The branch contains a pull of v4.8-rc5 to avoid conflicts between ahci
irq handling fixes merged through for-4.8-fixes and the ahci msix irq
handling updates.

Thanks.

The following changes since commit bc4dee5aa72723632a1f83fd0d3720066c93b433:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2016-09-05 11:10:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.9

for you to fetch changes up to 1ce788d24268a33513d832d9030ceab93f1c2ce2:

  ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a SoC" (2016-09-30 10:28:51 +0200)

----------------------------------------------------------------
Christoph Hellwig (4):
      ahci: also use a per-port lock for the multi-MSIX case
      ahci: use pci_alloc_irq_vectors
      libata: remove unused definitions from <asm/libata-portmap.h>
      libata: remove <asm-generic/libata-portmap.h>

Harman Kalra (3):
      ata: sata_mv: Replacing dma_pool_alloc and memset with a single call dma_pool_zalloc.
      ata: Replace BUG() with BUG_ON().
      pata_at91: Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Patrice Chotard (2):
      ahci: st: Add ports-implemented property in support
      ARM: dts: STiH407-family: Add ports-implemented property in sata nodes

Shaun Tancheff (5):
      libata: Safely overwrite attached page in WRITE SAME xlat
      libata: Add support for SCT Write Same
      libata: SCT Write Same / DSM Trim
      libata: SCT Write Same handle ATA_DFLAG_PIO
      libata: Some drives failing on SCT Write Same

Tang Yuantian (3):
      ahci: qoriq: adjust sata parameter
      ahci: qoriq: enable snoopable sata read and write
      ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a SoC"

Tejun Heo (1):
      Merge branch 'master' into for-4.9

Tom Yan (2):
      libata-scsi: use u8 array to store mode page copy
      libata-scsi: fix MODE SELECT translation for Control mode page

 arch/arm/boot/dts/stih407-family.dtsi          |   4 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   2 +
 arch/ia64/include/asm/libata-portmap.h         |   4 -
 arch/powerpc/include/asm/libata-portmap.h      |   4 -
 drivers/ata/ahci.c                             | 149 +++----------
 drivers/ata/ahci.h                             |  24 +--
 drivers/ata/ahci_qoriq.c                       |  20 +-
 drivers/ata/ahci_st.c                          |   4 +
 drivers/ata/libahci.c                          |   9 +-
 drivers/ata/libata-scsi.c                      | 288 ++++++++++++++++++++++---
 drivers/ata/pata_at91.c                        |   4 +-
 drivers/ata/pata_octeon_cf.c                   |   3 +-
 drivers/ata/sata_mv.c                          |   6 +-
 include/asm-generic/libata-portmap.h           |   7 -
 include/linux/ata.h                            |  69 +++---
 include/linux/libata.h                         |   3 +-
 17 files changed, 365 insertions(+), 238 deletions(-)
 delete mode 100644 include/asm-generic/libata-portmap.h

-- 
tejun
