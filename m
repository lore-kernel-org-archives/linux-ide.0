From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Mon, 21 Jul 2014 22:37:08 -0700 (PDT)
Message-ID: <20140721.223708.524693301044885285.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:41759 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaGVFhL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2014 01:37:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these IDE fixes:

1) Fix interrupt registry for some Atari IDE chipsets.

2) Adjust Kconfig dependencies for x86_32 specific chips.

Thanks!

The following changes since commit 0c0bd34a142963ca3454f530e47ce1c230d8cc9d:

  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2014-03-03 10:49:24 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git master

for you to fetch changes up to 5b40dd30bbfaa7fcba0cd945a4852a146c552ea7:

  ide: Fix SC1200 dependencies (2014-03-17 15:57:28 -0400)

----------------------------------------------------------------
Jean Delvare (2):
      ide: Fix CS5520 and CS5530 dependencies
      ide: Fix SC1200 dependencies

Michael Schmitz (1):
      m68k/atari - ide: do not register interrupt if host->get_lock is set

 drivers/ide/Kconfig     | 5 ++++-
 drivers/ide/ide-probe.c | 8 +++++---
 2 files changed, 9 insertions(+), 4 deletions(-)
