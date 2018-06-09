From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Sat, 09 Jun 2018 10:20:02 -0400 (EDT)
Message-ID: <20180609.102002.1007793250109793345.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Please pull to get these IDE updates.  Primarily IRQ disabling
avoidance changes from Sebastian Andrzej Siewior.

Thanks!

The following changes since commit 5037be168f0e4ee910602935b1180291082d3aac:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2018-06-05 11:13:17 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 47b82e88180c3c6db795a43373beab47cb073f7a:

  ide: don't enable/disable interrupts in force threaded-IRQ mode (2018-06-05 16:26:47 -0400)

----------------------------------------------------------------
Sebastian Andrzej Siewior (4):
      alim15x3: move irq-restore before pci_dev_put()
      ide: Handle irq disabling consistently
      ide: don't disable interrupts during kmap_atomic()
      ide: don't enable/disable interrupts in force threaded-IRQ mode

 drivers/ide/alim15x3.c     |  2 +-
 drivers/ide/ide-io.c       |  4 ++--
 drivers/ide/ide-iops.c     | 13 +++++++++----
 drivers/ide/ide-taskfile.c | 10 +---------
 kernel/irq/manage.c        |  1 +
 5 files changed, 14 insertions(+), 16 deletions(-)
