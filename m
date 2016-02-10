From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.5-rc3
Date: Wed, 10 Feb 2016 12:37:28 -0500
Message-ID: <20160210173728.GQ3741@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

libata fixes for v4.5-rc3.

* PORTS_IMPL workaround for very early ahci controllers is misbehaving
  on new systems.  Disabled on recent ahci versions.

* Old-style PIO state machine had a horrible locking problem.  Don't
  know how we've been getting away this far.  Fixed.

* Other device specific updates.

Thanks.

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.5-fixes

for you to fetch changes up to 342decff2b846b46fa61eb5ee40986fab79a9a32:

  ahci: Intel DNV device IDs SATA (2016-02-10 11:35:55 -0500)

----------------------------------------------------------------
Alexandra Yates (1):
      ahci: Intel DNV device IDs SATA

Danesh Petigara (1):
      drivers: ata: wake port before DMA stop for ALPM

Shikha Jain (1):
      libata: blacklist a Viking flash model for MWDMA corruption

Tejun Heo (3):
      libata: disable forced PORTS_IMPL for >= AHCI 1.3
      libata-sff: use WARN instead of BUG on illegal host state machine state
      libata: fix sff host state machine locking while polling

 drivers/ata/ahci.c         | 20 ++++++++++++++++++++
 drivers/ata/ahci.h         |  1 +
 drivers/ata/ahci_brcmstb.c |  1 +
 drivers/ata/libahci.c      | 27 ++++++++++++++++++++++++---
 drivers/ata/libata-core.c  |  1 +
 drivers/ata/libata-sff.c   | 35 +++++++++++++----------------------
 include/linux/libata.h     |  1 +
 7 files changed, 61 insertions(+), 25 deletions(-)

-- 
tejun
