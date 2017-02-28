From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Mon, 27 Feb 2017 20:50:45 -0500 (EST)
Message-ID: <20170227.205045.1881831523761993209.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Just one actual change here this time around, adding some init data
annotations.  The other change was bogus and got reverted.

Please pull, thanks!

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 96297aee8bce237961b0e1b99e22913c5726af12:

  ide: palm_bk3710: add __initdata to palm_bk3710_port_info (2017-02-27 20:43:26 -0500)

----------------------------------------------------------------
Bhumika Goyal (1):
      ide: palm_bk3710: add __initdata to palm_bk3710_port_info

David S. Miller (1):
      Revert "ide: Fix interface autodetection in legacy IDE driver (trial #2)"

lramos.prof@yahoo.com.br (1):
      ide: Fix interface autodetection in legacy IDE driver (trial #2)

 drivers/ide/palm_bk3710.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
