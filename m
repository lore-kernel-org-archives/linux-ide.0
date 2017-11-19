From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Sun, 19 Nov 2017 21:43:18 +0900 (KST)
Message-ID: <20171119.214318.1422123071254634419.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:53068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdKSMnW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Nov 2017 07:43:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this small cleanup.

Thanks a lot!

The following changes since commit 510c8a899caf095cb13d09d203573deef15db2fe:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-08-15 18:52:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to b671e1703394d77163130c91f53b075db1c446bf:

  PNP: ide: constify pnp_device_id (2017-08-16 11:25:16 -0700)

----------------------------------------------------------------
Arvind Yadav (1):
      PNP: ide: constify pnp_device_id

 drivers/ide/ide-pnp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
