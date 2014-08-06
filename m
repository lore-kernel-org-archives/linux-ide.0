From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Tue, 05 Aug 2014 22:03:12 -0700 (PDT)
Message-ID: <20140805.220312.1017005928261423242.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:36064 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbaHFFDN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2014 01:03:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just one minor cleanup, please pull!

The following changes since commit e7fda6c4c3c1a7d6996dd75fd84670fa0b5d448f:

  Merge branch 'timers-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2014-08-05 17:46:42 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git master

for you to fetch changes up to a53dae49b2fea43d8f4ec5aeca0e288bbc8d6895:

  ide: use module_platform_driver() (2014-08-05 21:16:46 -0700)

----------------------------------------------------------------
Christoph Jaeger (1):
      ide: use module_platform_driver()

 drivers/ide/au1xxx-ide.c   | 13 +------------
 drivers/ide/ide_platform.c | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)
