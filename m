From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Fri, 17 Apr 2015 16:14:08 -0400 (EDT)
Message-ID: <20150417.161408.1291414955530392610.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46810 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbbDQUOK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2015 16:14:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just one change, getting rid of usage of the deprecated PCI DMA
interfaces in the IDE drivers.

Please pull, thanks a lot!

The following changes since commit 54e514b91b95d6441c12a7955addfb9f9d2afc65:

  Merge branch 'akpm' (patches from Andrew) (2015-04-17 09:04:38 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to d681f1166919d6829083c069a83edcd59bfd5e34:

  ide: remove deprecated use of pci api (2015-04-17 15:32:07 -0400)

----------------------------------------------------------------
Quentin Lambert (1):
      ide: remove deprecated use of pci api

 drivers/ide/cs5520.c    | 2 +-
 drivers/ide/pmac.c      | 5 ++---
 drivers/ide/setup-pci.c | 2 +-
 drivers/ide/sgiioc4.c   | 4 ++--
 4 files changed, 6 insertions(+), 7 deletions(-)
