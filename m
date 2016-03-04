From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.5-rc6
Date: Fri, 4 Mar 2016 17:04:45 -0500
Message-ID: <20160304220445.GA3567@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34159 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759058AbcCDWEs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2016 17:04:48 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>

Hello, Linus.

Assorted fixes for libata drivers.

* Turns out HDIO_GET_32BIT ioctl was subtly broken all along.

* Recent update to ahci external port handling was incorrectly marking
  hotpluggable ports as external making userland handle devices
  connected to those ports incorrectly.

* ahci_xgene needs its own irq handler to work around a hardware
  erratum.  libahci updated to allow irq handler override.

* Misc driver specific updates.

Thanks.

The following changes since commit 342decff2b846b46fa61eb5ee40986fab79a9a32:

  ahci: Intel DNV device IDs SATA (2016-02-10 11:35:55 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.5-fixes

for you to fetch changes up to dc8b4afc4a04fac8ee55a19b59f2356a25e7e778:

  ata: ahci: don't mark HotPlugCapable Ports as external/removable (2016-02-29 16:17:57 -0500)

----------------------------------------------------------------
Alexandra Yates (1):
      Adding Intel Lewisburg device IDs for SATA

Arnd Bergmann (1):
      libata: fix HDIO_GET_32BIT ioctl

Gabor Juhos (1):
      pata-rb532-cf: get rid of the irq_to_gpio() call

Harvey Hunt (1):
      libata: Align ata_device's id on a cacheline

Manuel Lauss (1):
      ata: ahci: don't mark HotPlugCapable Ports as external/removable

Suman Tripathi (3):
      libahci: Implement the capability to override the generic ahci interrupt handler.
      ata: Remove the AHCI_HFLAG_EDGE_IRQ support from libahci.
      ahci_xgene: Implement the workaround to fix the missing of the edge interrupt for the HOST_IRQ_STAT.

Tirumalesh Chalamarla (1):
      ahci: Workaround for ThunderX Errata#22536

 drivers/ata/ahci.c          | 49 ++++++++++++++++++++++++++
 drivers/ata/ahci.h          |  5 +--
 drivers/ata/ahci_xgene.c    | 85 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libahci.c       | 63 +++++++++------------------------
 drivers/ata/libata-scsi.c   | 11 +++---
 drivers/ata/pata_rb532_cf.c | 11 +++++-
 include/linux/ata.h         |  4 +--
 include/linux/libata.h      |  2 +-
 8 files changed, 171 insertions(+), 59 deletions(-)

-- 
tejun
