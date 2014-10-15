From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Wed, 15 Oct 2014 14:44:58 -0400 (EDT)
Message-ID: <20141015.144458.419565536254879281.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:53303 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaJOSpA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2014 14:45:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this one IDE driver cleanup.

Thanks!

The following changes since commit 0429fbc0bdc297d64188483ba029a23773ae07b0:

  Merge branch 'for-3.18-consistent-ops' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu (2014-10-15 07:48:18 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git master

for you to fetch changes up to 7546e52b5e3d46d0deae4a336252b6dfd52c6571:

  Drivers: ide: Remove typedef atiixp_ide_timing (2014-10-15 14:27:38 -0400)

----------------------------------------------------------------
Himangi Saraogi (1):
      Drivers: ide: Remove typedef atiixp_ide_timing

 drivers/ide/atiixp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
