From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.7-rc1
Date: Tue, 17 May 2016 17:07:11 -0700
Message-ID: <20160518000711.GA5632@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

Trivial changes except for special case timeout bumping.  I have two
more libata branches which depend on SCSI and dmaengine tree
respectively.  I'll send pull requests for them once the prerequisite
trees are pulled in.

Thanks.

The following changes since commit 535dac4ab5f42e040e8405b31e309a6b6d4eee57:

  ata: add AMD Seattle platform driver (2016-04-13 15:14:24 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.7

for you to fetch changes up to f8d1a93930a754c4ea27238ae1c0fb2356d12e9a:

  Merge branch 'for-4.6-fixes' into for-4.7 (2016-05-13 17:20:48 -0400)

----------------------------------------------------------------
Andy Shevchenko (1):
      libata-scsi: use %*ph to dump small buffers

Damien Le Moal (1):
      libata-core: Allow longer timeout for drive spinup from PUIS

Masanari Iida (1):
      treewide: Fix typos in libata.xml

Sander Eikelenboom (1):
      libata: Fixup awkward whitespace in warning by removing line continuation.

Tejun Heo (1):
      Merge branch 'for-4.6-fixes' into for-4.7

 drivers/ata/libahci.c     |  4 ++--
 drivers/ata/libata-core.c | 22 +++++++++++++---------
 drivers/ata/libata-scsi.c |  9 +++------
 include/linux/ata.h       |  3 ++-
 4 files changed, 20 insertions(+), 18 deletions(-)

-- 
tejun
