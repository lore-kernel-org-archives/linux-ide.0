From: David Miller <davem@davemloft.net>
Subject: [GIT]: IDE
Date: Sun, 06 Sep 2009 14:13:44 -0700 (PDT)
Message-ID: <20090906.141344.140762454.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758755AbZIFVNb@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Please pull to get this device ID addition which fixes a
bugzilla.

Thanks!

The following changes since commit e07cccf4046978df10f2e13fe2b99b2f9b3a65db:
  Linus Torvalds (1):
        Linux 2.6.31-rc9

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

Wolfram Sang (1):
      pcmcia: add CNF-CDROM-ID for ide

 drivers/ide/ide-cs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
