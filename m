From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Mon, 23 May 2011 00:58:22 -0400 (EDT)
Message-ID: <20110523.005822.594376829594567304.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:38568 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1EWE6y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2011 00:58:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just a few small fixes and cleanups, nothing major.

Please pull, thanks a lot!

The following changes since commit df8d06ade6eed9077f658ac8696fc1cb5c081220:

  Merge branch 'omap-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6 (2011-05-16 08:55:49 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

Anton Blanchard (1):
      ide: Use linux/mutex.h

Jiri Slaby (1):
      IDE: ide-floppy, remove unnecessary NULL check

Joe Perches (1):
      drivers/ide/pmac.c: Remove unnecessary casts of pci_get_drvdata

Mariusz Kozlowski (1):
      ide: fix use after free in ide-acpi

Thiago Farina (1):
      ide/ide-scan-pci.c: Use for_each_pci_dev().

 drivers/ide/ide-acpi.c     |    4 ++--
 drivers/ide/ide-floppy.c   |    2 +-
 drivers/ide/ide-scan-pci.c |    2 +-
 drivers/ide/pmac.c         |    4 ++--
 include/linux/ide.h        |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
