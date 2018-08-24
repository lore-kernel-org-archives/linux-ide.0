From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.19-rc1
Date: Fri, 24 Aug 2018 11:53:56 -0700
Message-ID: <20180824185356.GY3978217@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, again.

Nothing too interesting.  Mostly ahci and ahci_platform changes, many
around power management.

Thanks.

The following changes since commit 9ffc59d57228d74809700be6f7ecb1db10292f05:

  Merge tag '4.18-rc1-more-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2018-06-18 14:28:19 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.19

for you to fetch changes up to 2d17f460c5d79fa9fc794e813377f3276acf81ce:

  ata: ahci_platform: enable to get and control reset (2018-08-22 08:08:28 -0700)

----------------------------------------------------------------
Corentin Labbe (4):
      ata: ahci_platform: correct parameter documentation for ahci_platform_shutdown
      ata: ahci_platform: convert kzallloc to kcalloc
      ata: ahci_platform: convert kcalloc to devm_kcalloc
      Revert "ata: ahci_platform: convert kcalloc to devm_kcalloc"

Geert Uytterhoeven (2):
      ata: sata_rcar: Provide a short-hand for &pdev->dev
      ata: sata_rcar: Add rudimentary Runtime PM support

Kunihiko Hayashi (3):
      ata: add an extra argument to ahci_platform_get_resources()
      ata: libahci_platform: add reset control support
      ata: ahci_platform: enable to get and control reset

Masaharu Hayakawa (1):
      ata: sata_rcar: exclude setting of PHY registers in Gen3

Paul Menzel (2):
      ata: Guard ata_scsi_dump_cdb() by ATA_VERBOSE_DEBUG
      ata: Only output sg element mapped number in verbose debug

Samuel Morris (2):
      ata: ahci: rpm_put port on port_stop to match rpm_get in port_start
      ata: ahci_platform: allow disabling of hotplug to save power

Sebastian Andrzej Siewior (1):
      libata: remove ata_sff_data_xfer_noirq()

Srinivas Pandruvada (4):
      ata: ahci: Support state with min power but Partial low power state
      ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
      ata: libahci: Correct setting of DEVSLP register
      ata: libahci: Allow reconfigure of DEVSLP register

Tejun Heo (1):
      Revert "ata: ahci_platform: allow disabling of hotplug to save power"

Wolfram Sang (2):
      ata: sata_rcar: really mask all interrupts on Gen2 and later
      ata: sata_rcar: Add r8a77965 support

 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 .../devicetree/bindings/ata/sata_rcar.txt          |  1 +
 Documentation/driver-api/libata.rst                |  3 +-
 drivers/ata/ahci.c                                 | 38 +++++++++--
 drivers/ata/ahci.h                                 |  1 +
 drivers/ata/ahci_brcm.c                            |  2 +-
 drivers/ata/ahci_ceva.c                            |  2 +-
 drivers/ata/ahci_da850.c                           |  2 +-
 drivers/ata/ahci_dm816.c                           |  2 +-
 drivers/ata/ahci_imx.c                             |  2 +-
 drivers/ata/ahci_mtk.c                             |  2 +-
 drivers/ata/ahci_mvebu.c                           |  2 +-
 drivers/ata/ahci_platform.c                        |  3 +-
 drivers/ata/ahci_qoriq.c                           |  2 +-
 drivers/ata/ahci_seattle.c                         |  2 +-
 drivers/ata/ahci_st.c                              |  2 +-
 drivers/ata/ahci_sunxi.c                           |  2 +-
 drivers/ata/ahci_tegra.c                           |  2 +-
 drivers/ata/ahci_xgene.c                           |  2 +-
 drivers/ata/libahci.c                              | 27 +++++---
 drivers/ata/libahci_platform.c                     | 49 ++++++++++----
 drivers/ata/libata-core.c                          |  3 +-
 drivers/ata/libata-scsi.c                          |  5 +-
 drivers/ata/libata-sff.c                           | 30 ---------
 drivers/ata/pata_cmd640.c                          |  2 +-
 drivers/ata/pata_icside.c                          |  2 +-
 drivers/ata/pata_imx.c                             |  2 +-
 drivers/ata/pata_legacy.c                          |  6 +-
 drivers/ata/pata_palmld.c                          |  2 +-
 drivers/ata/pata_pcmcia.c                          |  2 +-
 drivers/ata/pata_platform.c                        |  2 +-
 drivers/ata/pata_via.c                             |  2 +-
 drivers/ata/sata_rcar.c                            | 76 +++++++++++-----------
 include/linux/ahci_platform.h                      |  4 +-
 include/linux/libata.h                             |  5 +-
 35 files changed, 166 insertions(+), 126 deletions(-)

-- 
tejun
