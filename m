From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Fri, 21 Jul 2017 04:40:28 +0100 (WEST)
Message-ID: <20170721.044028.913317684087468028.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Please pull to get this gcc-7 warning fix from Arnd.

Thanks!

The following changes since commit 96080f697786e0a30006fcbcc5b53f350fcb3e9f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-07-20 16:33:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide 

for you to fetch changes up to 921edf312a6a20be16cf2b60e0dec3dce35e5cb9:

  ide: avoid warning for timings calculation (2017-07-21 04:37:22 +0100)

----------------------------------------------------------------
Arnd Bergmann (1):
      ide: avoid warning for timings calculation

 drivers/ide/ide-timings.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)
