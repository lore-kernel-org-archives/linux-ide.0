From: David Miller <davem@davemloft.net>
Subject: [GIT]: IDE
Date: Wed, 07 Oct 2009 04:10:23 -0700 (PDT)
Message-ID: <20091007.041023.205207417.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758887AbZJGLK3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Please pull to get the sis5513 PIO bug fix from Bart, and
the revert that is no longer necessary as the real problem
is now solved.

Thanks!

The following changes since commit 0eca52a92735f43462165efe00a7e394345fb38e:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/ide-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

Bartlomiej Zolnierkiewicz (2):
      sis5513: fix PIO setup for ATAPI devices
      Revert "Revert "ide: try to use PIO Mode 0 during probe if possible""

 drivers/ide/ide-probe.c |    9 +++++++++
 drivers/ide/sis5513.c   |   10 ++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)
