From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Mon, 03 Oct 2011 15:35:09 -0400 (EDT)
Message-ID: <20111003.153509.1840897953839267838.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:46398 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab1JCTfN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Oct 2011 15:35:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this request leak fix from Borislav Petkov.

Thanks!

The following changes since commit 9b13776977d45505469edc6decc93e9e3799afe2:

  Merge branch 'for-linus' of git://git.infradead.org/users/sameo/mfd-2.6 (2011-10-02 19:23:44 -0700)

are available in the git repository at:

  git://github.com/davem330/ide.git master

Borislav Petkov (1):
      ide-disk: Fix request requeuing

 drivers/ide/ide-disk.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)
