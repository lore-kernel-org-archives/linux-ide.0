From: David Miller <davem@davemloft.net>
Subject: [GIT]: IDE fixes
Date: Mon, 22 Jun 2009 02:42:16 -0700 (PDT)
Message-ID: <20090622.024216.03098051.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46148
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755175AbZFVJmM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 05:42:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


1) Update MAINTAINERS

2) Initial cmd64x regression fix, there are more funnies but
   we'll track it down.

Please pull, thanks!

The following changes since commit f234012f52a37e48f2330e1ca2df69800e797c3b:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../drzeus/mmc

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

David S. Miller (2):
      ide: Take over as maintainer.
      ide cmd64x: Remove serialize setting.

 MAINTAINERS          |    6 +++---
 drivers/ide/cmd64x.c |    3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)
