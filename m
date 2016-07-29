From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Fri, 29 Jul 2016 10:57:52 -0700 (PDT)
Message-ID: <20160729.105752.576720640744458862.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:51772 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbcG2R5z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jul 2016 13:57:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just a couple small bug fixes, nothing overly exciting in
here.

Please pull, thanks a lot!

The following changes since commit 107df03203bb66de56e2caec3bde6d22b55480c5:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2016-07-23 15:44:31 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide 

for you to fetch changes up to d4f8c2e0f827a0b3a322c449ac331ae41feeb359:

  ide: missing break statement in set_timings_mdma() (2016-07-26 15:25:31 -0700)

----------------------------------------------------------------
Alexey Khoroshilov (1):
      ide-tape: fix misprint in failure handling in idetape_init()

Colin Ian King (1):
      ide: hpt366: fix incorrect mask when checking at cmd_high_time

Dan Carpenter (1):
      ide: missing break statement in set_timings_mdma()

Julia Lawall (1):
      cmd640: add __init attribute

 drivers/ide/cmd640.c   | 2 +-
 drivers/ide/hpt366.c   | 2 +-
 drivers/ide/ide-tape.c | 6 +++---
 drivers/ide/pmac.c     | 1 +
 4 files changed, 6 insertions(+), 5 deletions(-)
