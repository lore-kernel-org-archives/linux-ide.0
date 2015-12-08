From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.4-rc4
Date: Tue, 8 Dec 2015 11:39:08 -0500
Message-ID: <20151208163908.GF30240@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

libata fixes.  Nothing too interesting.  All are device specific
additions and workarounds.

Thanks.

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.4-fixes

for you to fetch changes up to 4f2568f5cb475529aa2894adc7c7912517c83cb0:

  ata/sata_fsl.c: add ATA_FLAG_NO_LOG_PAGE to blacklist the controller for log page reads (2015-12-07 10:25:57 -0500)

----------------------------------------------------------------
Alexandra Yates (1):
      ahci: Order SATA device IDs for codename Lewisburg

Andreas Werner (2):
      libata-eh.c: Introduce new ata port flag for controller which lockup on read log page
      ata/sata_fsl.c: add ATA_FLAG_NO_LOG_PAGE to blacklist the controller for log page reads

Arnd Bergmann (1):
      sata/mvebu: use #ifdef around suspend/resume code

Charles_Rose@Dell.com (1):
      ahci: Add Device ID for Intel Sunrise Point PCH

Mikulas Patocka (1):
      sata_sil: disable trim

Xiangliang Yu (1):
      AHCI: Fix softreset failed issue of Port Multiplier

 drivers/ata/ahci.c       | 22 ++++++++++++----------
 drivers/ata/ahci_mvebu.c |  5 +++++
 drivers/ata/libahci.c    |  9 +++++++++
 drivers/ata/libata-eh.c  |  8 ++++++++
 drivers/ata/sata_fsl.c   |  3 ++-
 drivers/ata/sata_sil.c   |  3 +++
 include/linux/libata.h   |  1 +
 7 files changed, 40 insertions(+), 11 deletions(-)

-- 
tejun
