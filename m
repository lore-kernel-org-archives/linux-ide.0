From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Fri, 12 Dec 2014 16:00:21 -0500 (EST)
Message-ID: <20141212.160021.1536714250429818025.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:38532 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964796AbaLLVAY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Dec 2014 16:00:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two small IDE layer adjustments.

Thanks!

The following changes since commit 6ce4436c9cbe903af935291aa219fd6f4c85722d:

  Merge tag 'please-pull-morepstore' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2014-12-12 11:34:13 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git master

for you to fetch changes up to ca957b6a34a6f7014828f235e35c1945cb955795:

  drivers: ide: Fix mostly harmless off-by-one hardcoded value (2014-12-12 15:26:31 -0500)

----------------------------------------------------------------
Markus Elfring (1):
      IDE: Deletion of an unnecessary check before the function call "module_put"

Rasmus Villemoes (1):
      drivers: ide: Fix mostly harmless off-by-one hardcoded value

 drivers/ide/ide-floppy.c | 4 ++--
 drivers/ide/ide.c        | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)
