From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v3.20-rc1
Date: Mon, 9 Feb 2015 08:01:28 -0500
Message-ID: <20150209130128.GE3220@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:37200 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759519AbbBINBc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2015 08:01:32 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>

Hello, Linus.

Mostly driver-specific changes.  Nothing too noteworthy.  This pull
request contains three merges from for-3.19-fixes.  The first two are
to pull ahci_xgene and sata_dwc_460ex fix commits which are depended
upon by later changes.  The last one is to pull in a fix patch which
missed the v3.19-rc window.

Thanks.

The following changes since commit ce7514526742c0898b837d4395f515b79dfb5a12:

  libata: prevent HSM state change race between ISR and PIO (2015-01-19 14:11:23 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.20

for you to fetch changes up to b12aa1f25e1da7e23fa44f646ac46e41366cfc6c:

  Merge branch 'for-3.19-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata into for-3.20 (2015-02-09 07:54:41 -0500)

----------------------------------------------------------------
Akinobu Mita (2):
      ata: ahci_platform: fix owner module reference mismatch for scsi host
      ata: pata_platform: fix owner module reference mismatch for scsi host

Andy Shevchenko (7):
      sata_dwc_460ex: remove redundant dev_set_drvdata
      sata_dwc_460ex: enable COMPILE_TEST for the driver
      sata_dwc_460ex: fix most of the sparse warnings
      sata_dwc_460ex: use np local variable in ->probe()
      sata_dwc_460ex: remove extra message
      sata_dwc_460ex: convert to devm_kzalloc in ->probe()
      sata_dwc_460ex: disable compilation on ARM and ARM64

Gregory CLEMENT (3):
      ata: libahci: Clean-up the ahci_platform_en/disable_phys functions
      Documentation: bindings: Add the regulator property to the sub-nodes AHCI bindings
      ata: libahci: Allow using multiple regulators

Guenter Roeck (1):
      ata: libahci: Use of_platform_device_create only if supported

Markus Elfring (2):
      ata: Delete unnecessary checks before the function call "pci_dev_put"
      sata_mv: Delete unnecessary checks before the function call "phy_power_off"

Mikhail Ulyanov (1):
      sata_rcar: extend PM methods

Nicholas Krause (2):
      libata: s/ata_id_removeable()/ata_id_removable()/
      libata: Remove FIXME comment in atapi_eh_request_sense

Rickard Strandqvist (1):
      ata: libata-core: Remove unused function

Suman Tripathi (3):
      ahci_xgene: Implement the xgene_ahci_poll_reg_val to support PMP.
      ahci_xgene: Implement the workaround to support PMP enumeration and discovery.
      ahci_xgene: Fix the dma state machine lockup for the ATA_CMD_SMART PIO mode command.

Tejun Heo (3):
      Merge branch 'for-3.19-fixes' of git://git.kernel.org/.../tj/libata into for-3.20
      Merge branch 'for-3.19-fixes' of git://git.kernel.org/.../tj/libata into for-3.20
      Merge branch 'for-3.19-fixes' of git://git.kernel.org/.../tj/libata into for-3.20

Thierry Reding (1):
      ata: libahci: Fix devres cleanup on failure

Tina Ruchandani (1):
      pata_pdc2027x: Use 64-bit timekeeping

 .../devicetree/bindings/ata/ahci-platform.txt      |   9 +-
 drivers/ata/Kconfig                                |   2 +-
 drivers/ata/ahci.h                                 |   6 +-
 drivers/ata/ahci_da850.c                           |  11 +-
 drivers/ata/ahci_imx.c                             |  25 ++-
 drivers/ata/ahci_mvebu.c                           |  11 +-
 drivers/ata/ahci_platform.c                        |  11 +-
 drivers/ata/ahci_st.c                              |  11 +-
 drivers/ata/ahci_sunxi.c                           |  11 +-
 drivers/ata/ahci_tegra.c                           |  11 +-
 drivers/ata/ahci_xgene.c                           | 203 ++++++++++++++++-
 drivers/ata/libahci_platform.c                     | 249 ++++++++++++++-------
 drivers/ata/libata-core.c                          |  27 ---
 drivers/ata/libata-eh.c                            |   1 -
 drivers/ata/libata-scsi.c                          |   4 +-
 drivers/ata/libata.h                               |   1 -
 drivers/ata/pata_cs5530.c                          |   6 +-
 drivers/ata/pata_of_platform.c                     |  10 +-
 drivers/ata/pata_pdc2027x.c                        |  10 +-
 drivers/ata/pata_platform.c                        |   8 +-
 drivers/ata/sata_dwc_460ex.c                       | 116 +++++-----
 drivers/ata/sata_mv.c                              |   6 +-
 drivers/ata/sata_rcar.c                            |  25 ++-
 include/linux/ahci_platform.h                      |   6 +-
 include/linux/ata.h                                |   2 +-
 include/linux/ata_platform.h                       |   5 +-
 include/linux/libata.h                             |   6 +
 27 files changed, 563 insertions(+), 230 deletions(-)

-- 
tejun
