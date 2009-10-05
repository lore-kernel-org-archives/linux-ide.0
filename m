From: David Miller <davem@davemloft.net>
Subject: [GIT]: IDE
Date: Mon, 05 Oct 2009 14:05:35 -0700 (PDT)
Message-ID: <20091005.140535.205685992.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34045
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753511AbZJEVFl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Oct 2009 17:05:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Here is the PIO-0 revert as well as a printk_once conversion.

Please pull, thanks a lot!

The following changes since commit 90d5ffc729e92bffc0f84e2447e2e6dc280240a5:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

David S. Miller (1):
      Revert "ide: try to use PIO Mode 0 during probe if possible"

Marcin Slusarz (1):
      ide: use printk_once

 drivers/ide/ide-probe.c |    9 ---------
 drivers/ide/ide-proc.c  |    8 +-------
 2 files changed, 1 insertions(+), 16 deletions(-)
