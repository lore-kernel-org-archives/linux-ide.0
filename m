From: David Miller <davem@davemloft.net>
Subject: [GIT]: IDE
Date: Tue, 21 Jul 2009 21:21:52 -0700 (PDT)
Message-ID: <20090721.212152.43170346.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39483
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816AbZGVEVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jul 2009 00:21:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


1) When FS delivers flush commands to an IDE disk (as XFS does, for
   example) we leak memory.  Fix from Maxime Bizon.

2) IDE tape can leak kstack to userspace, fix from Michael Buesch.

Please pull, thanks a lot!

The following changes since commit aea1f7964ae6cba5eb419a958956deb9016b3341:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../sam/kbuild-fixes

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

Maxime Bizon (1):
      ide: fix memory leak when flush command is issued

Michael Buesch (1):
      ide-tape: Don't leak kernel stack information

 drivers/ide/ide-disk.c |    1 +
 drivers/ide/ide-tape.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)
