From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Fri, 18 Nov 2011 14:47:48 -0500 (EST)
Message-ID: <20111118.144748.2127699093460246796.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:54322 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1KRTrx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2011 14:47:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just a few small bug fixes, including:

1) Mirror ICH7 MWDMA1 errata fix from libata, from Bartlomiej Zolnierkiewicz.

2) Triflex IDE should not be powered down on suspend, from Mikulas Patocka.

Please pull, thanks!

The following changes since commit b6844523839779030430ff28f036f83e2a3f43e6:

  Merge branch 'stable/for-linus-fixes-3.2' of git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen (2011-11-18 13:18:07 -0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git master

Bartlomiej Zolnierkiewicz (3):
      piix: ICH7 MWDMA1 errata
      icside: DMA support fix
      cy82c693: fix PCI device selection

Mikulas Patocka (1):
      IDE: Don't powerdown Compaq Triflex IDE device on suspend

 drivers/ide/cy82c693.c |    6 +++---
 drivers/ide/icside.c   |    2 +-
 drivers/ide/piix.c     |   18 ++++++++++--------
 drivers/ide/triflex.c  |   16 +++++++++++++++-
 4 files changed, 29 insertions(+), 13 deletions(-)
