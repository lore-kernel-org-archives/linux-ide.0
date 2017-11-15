From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.15-rc1
Date: Wed, 15 Nov 2017 10:27:59 -0800
Message-ID: <20171115182759.GY983427@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:56229 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbdKOS2C (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Nov 2017 13:28:02 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Nothing too interesting or alarming.  Other than a new power saving
mode addition to ahci and crash fix on a tracepoint, all changes are
trivial or device-specific.

Thanks.

The following changes since commit 23e4c67ae13da7549a54f4e8c0014f48b2ef5204:

  ata: avoid gcc-7 warning in ata_timing_quantize (2017-09-07 13:33:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.15

for you to fetch changes up to 5bca462d2d18b1c9ec86c7985753134f06fa5cd2:

  ahci: imx: Handle increased read failures for IMX53 temperature sensor in low frequency mode. (2017-11-13 12:17:43 -0800)

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: sata_dwc_460ex: Propagate platform device ID to DMA driver

Anurag Kumar Vulisha (9):
      devicetree: bindings: Add sata port phy config parameters in ahci-ceva
      ata: ceva: Move sata port phy oob settings to device-tree
      ata: ceva: Add gen 3 mode support in driver
      ata: ceva: Disable Device Sleep capability
      ata: ceva: Make RxWaterMark value as module parameter
      ata: ceva: Add CCI support for SATA if CCI is enabled
      ata: ceva: Correct the AXI bus configuration for SATA ports
      ata: ceva: Correct the suspend and resume logic for SATA
      ata: ceva: Add SMMU support for SATA IP

Arvind Yadav (2):
      libata: fix spelling mistake: 'ambigious' -> 'ambiguous'
      ata: pata_pdc2027x: Fix space before '[' error.

Bhumika Goyal (1):
      libata: make ata_port_type const

Colin Ian King (3):
      ata: pata_artop: remove redundant initialization of pio
      libata: make static arrays const, reduces object code size
      ata: sata_mv: remove a redundant assignment to pointer ehi

Egor Starkov (1):
      ahci: imx: Handle increased read failures for IMX53 temperature sensor in low frequency mode.

Geert Uytterhoeven (1):
      ata: sata_rcar: Use of_device_get_match_data() helper

Gustavo A. R. Silva (1):
      ata: mark expected switch fall-throughs

Hans de Goede (1):
      libata: Add new med_power_with_dipm link_power_management_policy setting

Radha Mohan Chintakuntla (1):
      ahci: Add support for Cavium's fifth generation SATA controller

Rameshwar Prasad Sahu (1):
      ata: fixes kernel crash while tracing ata_eh_link_autopsy event

 .../devicetree/bindings/ata/ahci-ceva.txt          |  39 ++++
 drivers/ata/ahci.c                                 |   9 +-
 drivers/ata/ahci_ceva.c                            | 197 +++++++++++++++++----
 drivers/ata/ahci_imx.c                             |   2 +-
 drivers/ata/libahci_platform.c                     |   1 +
 drivers/ata/libata-core.c                          |   8 +-
 drivers/ata/libata-eh.c                            |  14 +-
 drivers/ata/libata-scsi.c                          |  19 +-
 drivers/ata/libata.h                               |   2 +-
 drivers/ata/pata_artop.c                           |   2 +-
 drivers/ata/pata_atp867x.c                         |   2 +
 drivers/ata/pata_pdc2027x.c                        |   6 +-
 drivers/ata/sata_dwc_460ex.c                       |   1 +
 drivers/ata/sata_mv.c                              |   8 +-
 drivers/ata/sata_rcar.c                            |   7 +-
 include/linux/libata.h                             |   1 +
 16 files changed, 244 insertions(+), 74 deletions(-)
