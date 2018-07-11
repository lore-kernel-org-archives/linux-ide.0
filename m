From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.18-rc4
Date: Wed, 11 Jul 2018 11:35:10 -0700
Message-ID: <20180711183510.GI72677@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

* Jens's patches to expand the usable command depth from 31 to 32
  broke sata_fsl due to a subtle command iteration bug.  Fixed by
  introducing explicit iteration helpers and using the correct
  variant.

* On some laptops, enabling LPM by default reportedly led to
  occasional hard hangs.  Blacklist the affected cases.

* Other misc fixes / changes.

Thanks.

The following changes since commit 9ffc59d57228d74809700be6f7ecb1db10292f05:

  Merge tag '4.18-rc1-more-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2018-06-18 14:28:19 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.18-fixes

for you to fetch changes up to d55bac2754476624f23bdf3b908d117f3cdf469b:

  ata: Remove depends on HAS_DMA in case of platform dependency (2018-07-02 13:18:22 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      sata_nv: remove redundant pointers sdev0 and sdev1

Damien Le Moal (2):
      ata: Fix ZBC_OUT command block check
      ata: Fix ZBC_OUT all bit handling

Geert Uytterhoeven (1):
      ata: Remove depends on HAS_DMA in case of platform dependency

Hans de Goede (1):
      ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Jens Axboe (4):
      libata: add command iterator helpers
      libata: convert eh to command iterators
      sata_fsl: convert to command iterator
      sata_fsl: remove dead code in tag retrieval

John Garry (1):
      libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()

Mika Westerberg (1):
      ahci: Add Intel Ice Lake LP PCI ID

Wei Yongjun (1):
      ata: ahci_mvebu: ahci_mvebu_stop_engine() can be static

 drivers/ata/Kconfig       |  2 --
 drivers/ata/ahci.c        | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_mvebu.c  |  2 +-
 drivers/ata/libahci.c     |  7 ++++--
 drivers/ata/libata-core.c |  3 +++
 drivers/ata/libata-eh.c   | 41 +++++++++++++-------------------
 drivers/ata/libata-scsi.c | 18 +++++++++-----
 drivers/ata/sata_fsl.c    |  9 +------
 drivers/ata/sata_nv.c     |  3 ---
 include/linux/libata.h    | 24 +++++++++++++++++++
 10 files changed, 122 insertions(+), 47 deletions(-)

-- 
tejun
