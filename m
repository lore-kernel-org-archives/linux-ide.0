From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Sun, 10 Mar 2019 22:00:58 -0700 (PDT)
Message-ID: <20190310.220058.191106608509733546.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Please pull to get the following IDE changes, nothing super exciting as
usual:

1) Switch fallthrus from Gustavo A. R. Silva

2) Kconfig formatting cleanup from Enrico Weigelt

3) OF interface adjustment from Rob Herring

Thanks!

The following changes since commit cf76c364a1e1e5224af80edf70a1e3023e1fcf8c:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-12-05 17:06:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to dc5c37736d16ec90559888fb4c974977fc8ed1ca:

  drivers: ide: Kconfig: pedantic formatting (2019-03-10 11:12:38 -0700)

----------------------------------------------------------------
Enrico Weigelt, metux IT consult (1):
      drivers: ide: Kconfig: pedantic formatting

Gustavo A. R. Silva (2):
      ide: hpt366: mark expected switch fall-throughs
      ide: mark expected switch fall-through

Rob Herring (1):
      ide: Use of_node_name_eq for node name comparisons

 drivers/ide/Kconfig      | 26 +++++++++++++-------------
 drivers/ide/hpt366.c     |  4 ++--
 drivers/ide/ide-floppy.c |  2 +-
 drivers/ide/pmac.c       |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)
