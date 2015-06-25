From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.2-rc1
Date: Thu, 25 Jun 2015 18:00:32 -0400
Message-ID: <20150625220032.GA14738@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:33234 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbFYWAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2015 18:00:35 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

* A number of libata core changes to better support NCQ TRIM.

* ahci now supports MSI-X in single IRQ mode to support a new
  controller which doesn't implement MSI or INTX.

* ahci now supports edge-triggered IRQ mode to support a new
  controller which for some did edge-triggered IRQ.

* Usual controller support additions and changes.

Thanks.

The following changes since commit e0e2674b92056c24c69940d5f405ea4aef5e4010:

  ata: ahci_st: fixup layering violations / drvdata errors (2015-04-20 13:36:38 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.2

for you to fetch changes up to 243918be6393f643e513a26e7882e6ae06ff7717:

  libata: Do not blacklist Micron M500DC (2015-06-18 14:52:30 -0400)

----------------------------------------------------------------
Arnd Bergmann (1):
      ata: hpt366: fix constant cast warning

Brian Norris (2):
      Documentation: devicetree: add Broadcom SATA binding
      ata: add Broadcom AHCI SATA3 driver for STB chips

Dan Carpenter (1):
      ata: ahci_xgene: potential NULL dereference in probe

Krzysztof Kozlowski (1):
      libata: samsung_cf: Constify platform_device_id

Martin K. Petersen (7):
      libata: Allow NCQ TRIM to be enabled or disabled with a module parameter
      libata: Expose TRIM capability in sysfs
      libata: READ LOG DMA EXT support can be in either page 119 or 120
      libata: Fall back to unqueued READ LOG EXT if the DMA variant fails
      libata: Fix sysfs documentation bug
      libata: Fix regression when the NCQ Send and Receive log page is absent
      libata: Do not blacklist Micron M500DC

Masanari Iida (1):
      Doc: libata: Fix spelling typo found in libata.xml

Rasmus Villemoes (1):
      libata: finally use __initconst in ata_parse_force_one()

Robert Richter (5):
      ahci: Move interrupt enablement code to a separate function
      ahci: Store irq number in struct ahci_host_priv
      ahci: Add generic MSI-X support for single interrupts to SATA PCI driver
      ahci: Add support for Cavium's ThunderX host controller
      ahci, msix: Fix build error for !PCI_MSI

Shailendra Verma (1):
      ata:sata_nv - Change 1 to true for bool type variable.

Suman Tripathi (3):
      libahci: Refactoring of ahci_single_irq_intr function.
      libahci: Add support to handle HOST_IRQ_STAT as edge trigger latch.
      ata: ahci_xgene: Add AHCI Support for 2nd HW version of APM X-Gene SoC AHCI SATA Host controller.

Suneel Garapati (2):
      devicetree:bindings: add devicetree bindings for ceva ahci
      drivers: ata: add support for Ceva sata host controller

Tang Yuantian (1):
      ahci: added support for Freescale AHCI sata

Thomas Petazzoni (1):
      ata: ahci_mvebu: add suspend/resume support

 Documentation/ABI/testing/sysfs-ata                |  11 +
 .../devicetree/bindings/ata/ahci-ceva.txt          |  20 ++
 .../devicetree/bindings/ata/ahci-platform.txt      |   2 +
 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  34 +++
 Documentation/kernel-parameters.txt                |   2 +
 drivers/ata/Kconfig                                |  18 ++
 drivers/ata/Makefile                               |   2 +
 drivers/ata/acard-ahci.c                           |   4 +-
 drivers/ata/ahci.c                                 | 104 ++++++-
 drivers/ata/ahci.h                                 |   6 +-
 drivers/ata/ahci_brcmstb.c                         | 322 +++++++++++++++++++++
 drivers/ata/ahci_ceva.c                            | 238 +++++++++++++++
 drivers/ata/ahci_mvebu.c                           |  22 ++
 drivers/ata/ahci_platform.c                        |   1 +
 drivers/ata/ahci_xgene.c                           | 103 +++++--
 drivers/ata/libahci.c                              | 105 +++++--
 drivers/ata/libahci_platform.c                     |   4 +-
 drivers/ata/libata-core.c                          |  13 +-
 drivers/ata/libata-eh.c                            |  13 +-
 drivers/ata/libata-transport.c                     |  22 ++
 drivers/ata/pata_hpt366.c                          |   4 +-
 drivers/ata/pata_samsung_cf.c                      |   2 +-
 drivers/ata/sata_highbank.c                        |   3 +-
 drivers/ata/sata_nv.c                              |   2 +-
 include/linux/ata.h                                |  12 +-
 include/linux/libata.h                             |   1 +
 26 files changed, 988 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
 create mode 100644 drivers/ata/ahci_brcmstb.c
 create mode 100644 drivers/ata/ahci_ceva.c

-- 
tejun
