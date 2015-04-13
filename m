From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for 4.1-rc1
Date: Mon, 13 Apr 2015 11:39:02 -0400
Message-ID: <20150413153902.GF2596@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36826 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbbDMPjG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2015 11:39:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

* Hannes's patchset implements support for better error reporting
  introduced by the new ATA command spec.

* The deperecated pci_ dma API usages have been replaced by dma_ ones.

* A bunch of hardware specific updates and some cleanups.

This pull request causes the following conflict in
include/linux/libata.h.

	  ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
  <<<<<<< HEAD
	  ATA_FLAG_LOWTAG		= (1 << 24), /* host wants lowest available tag */
	  ATA_FLAG_SAS_HOST	= (1 << 25), /* SAS host */
  =======
  >>>>>>> c54c719b558e0eb3ba60b1390aeb47ed25ff4352

This is a simple context conflict between the following two commits.

  3a02824396c1 ("libata: remove ATA_FLAG_LOWTAG")
  5067c0469c64 ("ata: Add a new flag to destinguish sas controller")

The former removes a flag and the latter adds one.  It can be resolved
as follows.

	  ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
	  ATA_FLAG_SAS_HOST	= (1 << 25), /* SAS host */

Thanks.

The following changes since commit 7b09ac704bac2de5bf0362793edc22a0094e381c:

  Merge tag 'sound-4.0-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2015-03-18 11:17:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.1

for you to fetch changes up to c54c719b558e0eb3ba60b1390aeb47ed25ff4352:

  ata: remove deprecated use of pci api (2015-04-08 10:55:05 -0400)

----------------------------------------------------------------
Andy Shevchenko (3):
      sata_dwc_460ex: join messages back
      sata_dwc_460ex: move to generic DMA driver
      sata_dwc_460ex: re-use hsdev->dev instead of dwc_dev

Dan Carpenter (1):
      sata_dwc_460ex: indent an if statement

Feng Kan (1):
      sata: xgene: add ACPI support for APM X-Gene SATA ports

Hannes Reinecke (9):
      libata: use READ_LOG_DMA_EXT
      libata: whitespace cleanup in ata_get_cmd_descript()
      libata: whitespace fixes in ata_to_sense_error()
      ide,ata: Rename ATA_IDX to ATA_SENSE
      libata: use status bit definitions in ata_dump_status()
      libata: Implement NCQ autosense
      libata: Implement support for sense data reporting
      libata-eh: Set 'information' field for autosense
      libata: Add tracepoints

Peter Griffin (3):
      ahci: st: Update the DT example for how to obtain the PHY.
      ahci: st: Update the ahci_st DT documentation
      ahci: st: st_configure_oob must be called after IP is clocked.

Quentin Lambert (1):
      ata: remove deprecated use of pci api

Tejun Heo (1):
      libata: remove ATA_FLAG_LOWTAG

Thomas Petazzoni (1):
      ata: sata_mv: add proper definitions for LP_PHY_CTL register values

 Documentation/devicetree/bindings/ata/ahci-st.txt |  47 +-
 drivers/ata/Makefile                              |   3 +-
 drivers/ata/acard-ahci.c                          |  10 +-
 drivers/ata/ahci.c                                |  10 +-
 drivers/ata/ahci_st.c                             |   6 +-
 drivers/ata/ahci_xgene.c                          |  10 +
 drivers/ata/libata-core.c                         |  32 +-
 drivers/ata/libata-eh.c                           | 168 ++++-
 drivers/ata/libata-scsi.c                         | 116 +--
 drivers/ata/libata-sff.c                          |   4 +-
 drivers/ata/libata-trace.c                        | 151 ++++
 drivers/ata/libata.h                              |   6 +-
 drivers/ata/pata_atp867x.c                        |   4 +-
 drivers/ata/pata_cs5520.c                         |   4 +-
 drivers/ata/pata_hpt3x3.c                         |   4 +-
 drivers/ata/pata_ninja32.c                        |   4 +-
 drivers/ata/pata_pdc2027x.c                       |   4 +-
 drivers/ata/pata_scc.c                            |   4 +-
 drivers/ata/pata_sil680.c                         |   4 +-
 drivers/ata/pdc_adma.c                            |   4 +-
 drivers/ata/sata_dwc_460ex.c                      | 848 +++++-----------------
 drivers/ata/sata_inic162x.c                       |   4 +-
 drivers/ata/sata_mv.c                             |  30 +-
 drivers/ata/sata_nv.c                             |  12 +-
 drivers/ata/sata_promise.c                        |   4 +-
 drivers/ata/sata_qstor.c                          |  10 +-
 drivers/ata/sata_sil.c                            |   4 +-
 drivers/ata/sata_sil24.c                          |  12 +-
 drivers/ata/sata_svw.c                            |   4 +-
 drivers/ata/sata_sx4.c                            |   4 +-
 drivers/ata/sata_via.c                            |   4 +-
 drivers/ata/sata_vsc.c                            |   4 +-
 drivers/ide/ide-lib.c                             |   4 +-
 drivers/ide/ide-probe.c                           |   2 +-
 drivers/scsi/scsi_error.c                         |  31 +
 include/linux/ata.h                               |  29 +-
 include/linux/libata.h                            |   1 -
 include/scsi/scsi_eh.h                            |   1 +
 include/trace/events/libata.h                     | 325 +++++++++
 39 files changed, 1094 insertions(+), 834 deletions(-)
 create mode 100644 drivers/ata/libata-trace.c
 create mode 100644 include/trace/events/libata.h

-- 
tejun
