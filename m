From: David Miller <davem@davemloft.net>
Subject: [GIT]: IDE
Date: Sat, 27 Mar 2010 19:29:29 -0700 (PDT)
Message-ID: <20100327.192929.35046895.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36749
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751710Ab0C1C3F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2010 22:29:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this revert which should fix regressions
reported by users with VIA IDE chips.

Thanks!

The following changes since commit b72c40949b0f04728f2993a1434598d3bad094ea:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

David S. Miller (1):
      Revert "via82cxxx: workaround h/w bugs"

 drivers/ide/via82cxxx.c |   57 -----------------------------------------------
 1 files changed, 0 insertions(+), 57 deletions(-)

