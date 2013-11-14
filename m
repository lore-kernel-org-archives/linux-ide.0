From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Thu, 14 Nov 2013 18:29:18 -0500 (EST)
Message-ID: <20131114.182918.7368302396246095.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:53743 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab3KNX3U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Nov 2013 18:29:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just some minor cleanups and simplifications.

Please pull, thanks a lot!

The following changes since commit 4fbf888accb39af423f271111d44e8186f053723:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2013-11-14 17:19:58 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git master

for you to fetch changes up to c2f7d1e103ef1b5f3bd6a8a09aebf5eac7df4aca:

  ide: pmac: remove unnecessary pci_set_drvdata() (2013-11-14 18:21:25 -0500)

----------------------------------------------------------------
Jingoo Han (3):
      ide: pmac: Remove casting the return value which is a void pointer
      ide: cs5536: use module_pci_driver()
      ide: pmac: remove unnecessary pci_set_drvdata()

 drivers/ide/cs5536.c | 13 +------------
 drivers/ide/pmac.c   | 52 +++++++++++++++++-----------------------------------
 2 files changed, 18 insertions(+), 47 deletions(-)
