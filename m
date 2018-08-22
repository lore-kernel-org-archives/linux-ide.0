From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Tue, 21 Aug 2018 22:17:50 -0700 (PDT)
Message-ID: <20180821.221750.2043917894955366743.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


1) Remove redundant variables, from Colin Ian King.

2) Expected switch fall-through annotations, from Gustavo A. R. Silva

Please pull, thanks!

The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to a2eed33dcdb7663170b01f05dd8d0a3323ffe4b3:

  ide: mark expected switch fall-throughs (2018-08-13 11:48:54 -0700)

----------------------------------------------------------------
Colin Ian King (2):
      ide: remove redundant variables queue_run_ms and left
      ide-tape: remove redundant variable buffer_size

Gustavo A. R. Silva (1):
      ide: mark expected switch fall-throughs

 drivers/ide/hpt366.c       | 5 +++--
 drivers/ide/ide-floppy.c   | 1 +
 drivers/ide/ide-io.c       | 4 ----
 drivers/ide/ide-probe.c    | 1 +
 drivers/ide/ide-tape.c     | 2 --
 drivers/ide/ide-taskfile.c | 3 ++-
 drivers/ide/sis5513.c      | 1 +
 7 files changed, 8 insertions(+), 9 deletions(-)
