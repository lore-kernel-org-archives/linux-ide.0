From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.7-rc5
Date: Tue, 28 Jun 2016 14:07:54 -0400
Message-ID: <20160628180754.GG5185@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

Two trivial fixes - one for a bug in the allocation failure path and
the other a compiler warning fix.

Thanks.

The following changes since commit db06d759d6cf903aeda8c107fd3abd366dd80200:

  Merge branch 'for-4.7-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu (2016-06-13 19:54:46 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.7-fixes

for you to fetch changes up to 76bf3441ad6584ddc3aea1501927f21b21ba3a3a:

  ata: sata_mv: fix mis-conversion in mv_write_cached_reg() (2016-06-17 12:15:17 -0400)

----------------------------------------------------------------
Ben Dooks (1):
      ata: sata_mv: fix mis-conversion in mv_write_cached_reg()

Wei Yongjun (1):
      ata: fix return value check in ahci_seattle_get_port_info()

 drivers/ata/ahci_seattle.c | 2 +-
 drivers/ata/sata_mv.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
tejun
