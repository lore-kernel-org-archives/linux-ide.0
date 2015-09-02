From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for 4.3
Date: Wed, 2 Sep 2015 08:31:36 -0400
Message-ID: <20150902123136.GB22326@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

Nothing interesting.  A couple device specific minor updates and a
kernel doc change.

Thanks.

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.3

for you to fetch changes up to d6e9b704d9553ee9d54baddcc6d9b63a4574f272:

  ata: pata_arasam_cf: Use devm_clk_get (2015-08-22 09:36:06 -0700)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ata: sata_rcar: Remove obsolete sata-r8a779* platform_device_id entries

Randy Dunlap (1):
      libata: fix libata-core.c kernel-doc warning

Vaishali Thakkar (1):
      ata: pata_arasam_cf: Use devm_clk_get

 drivers/ata/libata-core.c    |  1 +
 drivers/ata/pata_arasan_cf.c | 11 ++++-------
 drivers/ata/sata_rcar.c      |  4 ----
 3 files changed, 5 insertions(+), 11 deletions(-)

-- 
tejun
