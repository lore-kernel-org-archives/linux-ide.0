From: David Miller <davem@davemloft.net>
Subject: [GIT]: IDE
Date: Mon, 06 Jul 2009 14:51:44 -0700 (PDT)
Message-ID: <20090706.145144.173645961.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39555
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753059AbZGFVvi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jul 2009 17:51:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


This reverts a power-management fix we tried a week ago.

It doesn't work and it looks like we'll need to attack this in 2.6.32
instead.

Please pull, thanks a lot.

The following changes since commit 8e4a718ff38d8539938ec3421935904c27e00c39:
  Linus Torvalds (1):
        Linux 2.6.31-rc2

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

David S. Miller (1):
      Revert "ide: improve handling of Power Management requests"

 drivers/ide/ide-io.c |   54 +++++++++++++++++++++++++++++--------------------
 1 files changed, 32 insertions(+), 22 deletions(-)
