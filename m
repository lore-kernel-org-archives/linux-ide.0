From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Tue, 09 May 2017 16:04:42 -0400 (EDT)
Message-ID: <20170509.160442.1780305209253599723.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:60982 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbdEIUEo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2017 16:04:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull in these two small cleanups in the IDE
layer.

Thanks!

The following changes since commit 2d3e4866dea96b0506395b47bfefb234f2088dac:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2017-05-08 12:37:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to acfead32f3f938e456d7d5e1a82c743d30b8b886:

  ide: don't call memcpy with the same source and destination (2017-05-08 17:36:39 -0400)

----------------------------------------------------------------
Geliang Tang (1):
      ide: use setup_timer

Mikulas Patocka (1):
      ide: don't call memcpy with the same source and destination

 drivers/ide/ide-io.c    | 2 +-
 drivers/ide/ide-probe.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)
