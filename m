From: David Miller <davem@davemloft.net>
Subject: Re: [GIT]: IDE
Date: Sun, 28 Mar 2010 19:01:28 -0700 (PDT)
Message-ID: <20100328.190128.187555861.davem@davemloft.net>
References: <20100327.192929.35046895.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41422
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755629Ab0C2CBE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2010 22:01:04 -0400
In-Reply-To: <20100327.192929.35046895.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 27 Mar 2010 19:29:29 -0700 (PDT)

> 
> Please pull to get this revert which should fix regressions
> reported by users with VIA IDE chips.

Linus, if you haven't pulled yet I pushed another revert
which fixes disappearing slave CDROM devices.

Just FYI...

The following changes since commit b72c40949b0f04728f2993a1434598d3bad094ea:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

David S. Miller (2):
      Revert "via82cxxx: workaround h/w bugs"
      Revert "ide: skip probe if there are no devices on the port (v2)"

 drivers/ide/ide-probe.c |   12 ++-------
 drivers/ide/via82cxxx.c |   57 -----------------------------------------------
 2 files changed, 3 insertions(+), 66 deletions(-)
