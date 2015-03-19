From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Thu, 19 Mar 2015 00:59:19 -0400 (EDT)
Message-ID: <20150319.005919.1254990682721385315.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Just one fix to convert a by-hand conversion of jiffies to
msecs, from Nicholas McGuire.

Please pull, thanks a lot!

The following changes since commit 7b09ac704bac2de5bf0362793edc22a0094e381c:

  Merge tag 'sound-4.0-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2015-03-18 11:17:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 842159640782539a80153c040d6fc2b80756aa3a:

  ide_tape: convert jiffies with jiffies_to_msecs (2015-03-18 23:25:57 -0400)

----------------------------------------------------------------
Nicholas Mc Guire (1):
      ide_tape: convert jiffies with jiffies_to_msecs

 drivers/ide/ide-tape.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
