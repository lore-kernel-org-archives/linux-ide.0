From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.8-rc1
Date: Tue, 26 Jul 2016 13:17:54 -0400
Message-ID: <20160726171754.GC4144@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35537 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbcGZRR4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2016 13:17:56 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

libata saw quite a bit of activities in this cycle.

* SMR drive support still being worked on.
* Bug fixes and improvements to misc SCSI command emulation.
* Some low level driver updates.

Thanks.

The following changes since commit dc03c0f9d12d85286d5e3623aa96d5c2a271b8e6:

  Merge branch 'misc' of git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild (2016-05-26 22:32:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.8

for you to fetch changes up to 737bee9308c457090711684b976e0fe02785a094:

  libata-scsi: better style in ata_msense_*() (2016-07-20 11:19:35 -0400)

----------------------------------------------------------------
Arnd Bergmann (1):
      ata: fix "ering" sysfs time printing

Christoph Hellwig (4):
      libata: return boolean values from ata_is_*
      libata: remove ata_is_nodata
      libata: remove ATA_PROT_FLAG_DATA
      ata: define ATA_PROT_* in terms of ATA_PROT_FLAG_*

Colin Ian King (2):
      pata_atiixp: fix trivial indentation misalignment on if statement
      ata: hpt366: fix incorrect mask when checking at cmd_high_time

Damien Le Moal (3):
      libata-scsi: Fix translation of REPORT ZONES command
      libata-scsi: Fix ZBC management out command translation
      libata-scsi: minor cleanup for ata_scsi_zbc_out_xlat

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for ata device tree bindings

Hannes Reinecke (5):
      libata: use ata_is_ncq() accessors
      libsas: use ata_is_ncq() and ata_has_dma() accessors
      ata: fixup ATA_PROT_NODATA
      libata-eh: decode all taskfile protocols
      ata: Handle ATA NCQ NO-DATA commands correctly

Iago Abal (1):
      drivers: ata: pata_arasan_cf: use the same name for the same lock

Javier Martinez Canillas (1):
      ata: Use IS_ENABLED() instead of checking for built-in or module

Pang Raymond (1):
      AHCI: Clear GHC.IS to prevent unexpectly asserting INTx

Tom Yan (12):
      libata-scsi: do not respond with "invalid field" for FORMAT UNIT
      libata-scsi: correct cbd to CDB in comment
      libata-scsi: set correct VERSION field for ZAC devices
      libata-scsi: fix SET FEATURES "filtering" for ata_msense_caching()
      libata-scsi: set CmdQue bit in standard INQUIRY data to 1
      libata-scsi: correct SPC version descriptor
      libata-scsi: fix D_SENSE bit relection in control mode page
      libata-scsi: rename ata_msense_ctl_mode() to ata_msense_control()
      libata-scsi: reject WRITE SAME (16) with n_block that exceeds limit
      libata-scsi: avoid repeated calculation of number of TRIM ranges
      ata: make lba_{28,48}_ok() use ATA_MAX_SECTORS{,_LBA48}
      libata-scsi: better style in ata_msense_*()

Wei Yongjun (1):
      ata: sata_dwc_460ex: remove redundant dev_err call

Yendapally Reddy Dhananjaya Reddy (7):
      dt-bindings: ata: rename brcm, sata-brcmstb.txt to brcm, sata-brcm.txt
      dt-bindings: ata: add support for Broadcom NSP SoC ahci
      dt-bindings: phy: Add documentation for NSP SATA PHY
      ata: ahci_brcmstb: rename to support across Broadcom SoC's
      ata: ahci_brcm: Add support for Broadcom NSP SoC
      phy: Add SATA3 PHY support for Broadcom NSP SoC
      ARM: dts: nsp: Add sata device tree entry

 .../{brcm,sata-brcmstb.txt => brcm,sata-brcm.txt}  |  9 +--
 .../devicetree/bindings/phy/brcm-sata-phy.txt      |  4 +-
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     | 42 +++++++++++
 arch/arm/boot/dts/bcm958625k.dts                   | 12 ++++
 drivers/ata/Kconfig                                |  8 +--
 drivers/ata/Makefile                               |  2 +-
 drivers/ata/ahci.c                                 |  2 +-
 drivers/ata/{ahci_brcmstb.c => ahci_brcm.c}        | 46 +++++++++---
 drivers/ata/libahci.c                              | 10 ++-
 drivers/ata/libata-core.c                          | 14 ++--
 drivers/ata/libata-eh.c                            |  8 ++-
 drivers/ata/libata-scsi.c                          | 82 +++++++++++++---------
 drivers/ata/libata-transport.c                     |  9 +--
 drivers/ata/pata_arasan_cf.c                       |  2 +-
 drivers/ata/pata_atiixp.c                          |  4 +-
 drivers/ata/pata_hpt366.c                          |  2 +-
 drivers/ata/pata_marvell.c                         |  2 +-
 drivers/ata/sata_dwc_460ex.c                       | 14 ++--
 drivers/phy/phy-brcm-sata.c                        | 81 +++++++++++++++++++++
 drivers/scsi/libsas/sas_ata.c                      | 11 +--
 include/linux/ata.h                                | 41 +++++++----
 include/linux/libata.h                             | 60 ++++------------
 include/trace/events/libata.h                      |  1 +
 24 files changed, 314 insertions(+), 153 deletions(-)
 rename Documentation/devicetree/bindings/ata/{brcm,sata-brcmstb.txt => brcm,sata-brcm.txt} (81%)
 rename drivers/ata/{ahci_brcmstb.c => ahci_brcm.c} (91%)

-- 
tejun
