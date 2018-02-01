From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Thu, 01 Feb 2018 10:32:32 -0500 (EST)
Message-ID: <20180201.103232.225802399998503989.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Please pull to get this small IDE cleanup.

Thanks!

The following changes since commit 47d5cc5be396eca67cc89572957ff16f10fd768e:

  Merge tag 'hwmon-for-linus-v4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2018-01-29 11:20:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 8b76f5da49f0d432a747dbc0c4667dcd1ffb9945:

  ide: remove duplicated assignment to 'cursg' (2018-01-29 15:01:09 -0500)

----------------------------------------------------------------
Colin Ian King (1):
      ide: remove duplicated assignment to 'cursg'

 drivers/ide/ide-taskfile.c | 1 -
 1 file changed, 1 deletion(-)
