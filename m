From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Wed, 08 May 2019 16:53:20 -0700 (PDT)
Message-ID: <20190508.165320.2267661705586017777.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Finally deprecate the legacy IDE layer.

Frankly this is long overdue.

Please pull, thanks a lot!

The following changes since commit ef75bd71c5d31dc17ae41ff8bec92630a3037d69:

  Merge tag 'gfs2-for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2019-05-08 13:16:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide 

for you to fetch changes up to 7ad19a99ad431b5cae005c30b09096517058e84e:

  ide: officially deprecated the legacy IDE driver (2019-05-08 16:47:23 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
      ide: officially deprecated the legacy IDE driver

 drivers/ide/ide-probe.c | 3 +++
 1 file changed, 3 insertions(+)
