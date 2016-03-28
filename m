From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Mon, 28 Mar 2016 15:45:25 -0400 (EDT)
Message-ID: <20160328.154525.965454271200417711.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49432 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbcC1Tp1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2016 15:45:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just two small changes:

1) Remove bogus init annotation in icside, from Arnd Bergmann.

2) Don't use zero clock rates in palm_bk3710 driver, from Wolfram
   Sang.

Please pull, thanks a lot!

The following changes since commit 142b9e6c9de0fd7c0dff9a1d4a25390de46abf5e:

  x86/kallsyms: fix GOLD link failure with new relative kallsyms table format (2016-03-20 13:52:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 0d7ef45cdeebcc95d581703f45f6de7b2ee89b8d:

  ide: palm_bk3710: test clock rate to avoid division by 0 (2016-03-20 16:59:27 -0400)

----------------------------------------------------------------
Arnd Bergmann (1):
      ide: icside: remove incorrect initconst annotation

Wolfram Sang (1):
      ide: palm_bk3710: test clock rate to avoid division by 0

 drivers/ide/icside.c      | 2 +-
 drivers/ide/palm_bk3710.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
