From: David Miller <davem@davemloft.net>
Subject: [GIT] IDE
Date: Tue, 03 Nov 2015 16:44:30 -0500 (EST)
Message-ID: <20151103.164430.31403028935157072.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:47960 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492AbbKCVod (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2015 16:44:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just a y2038 fix to the pdc202xx_new IDE driver.

Please pull, thanks a lot!

The following changes since commit 6a13feb9c82803e2b815eca72fa7a9f5561d7861:

  Linux 4.3 (2015-11-01 16:05:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 353b39d1b1511376aca71bc3aba62831370561ca:

  ide: pdc202xx_new: Replace timeval with ktime_t (2015-11-03 11:51:08 -0500)

----------------------------------------------------------------
Amitoj Kaur Chawla (1):
      ide: pdc202xx_new: Replace timeval with ktime_t

 drivers/ide/pdc202xx_new.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
