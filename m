From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v3.11-rc6
Date: Fri, 23 Aug 2013 11:55:11 -0400
Message-ID: <20130823155511.GG3277@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

This pull request contains three commits all of which are updates for
specific devices which aren't too widespread.  Pretty limited scope
and nothing too interesting or dangerous.

The three commits are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.11-fixes

for you to fetch changes up to 99bbdfa6bdcb4bdf5be914a48e9b46941bf30819:

  sata_fsl: save irqs while coalescing (2013-08-20 08:38:23 -0400)

Thanks.

----------------------------------------------------------------
Anthony Foiani (1):
      sata_fsl: save irqs while coalescing

Mark Langsdorf (1):
      sata, highbank: fix ordering of SGPIO signals

Terry Suereth (1):
      libata: apply behavioral quirks to sil3826 PMP

 drivers/ata/libata-pmp.c    | 12 ++++++------
 drivers/ata/sata_fsl.c      |  5 +++--
 drivers/ata/sata_highbank.c |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
tejun
