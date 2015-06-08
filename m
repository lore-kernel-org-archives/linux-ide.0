From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.1-rc7
Date: Mon, 8 Jun 2015 15:19:05 +0900
Message-ID: <20150608061905.GE21465@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34608 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbbFHGTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2015 02:19:18 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

This contains one ahci_mvebu fix commit for a controller config bug.

Thanks.

The following changes since commit dbfe8ef5599a5370abc441fcdbb382b656563eb4:

  ahci: avoton port-disable reset-quirk (2015-05-10 11:39:16 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.1-fixes

for you to fetch changes up to e96998fc200867f005dd14c7d1dd35e1107d4914:

  ata: ahci_mvebu: Fix wrongly set base address for the MBus window setting (2015-05-26 14:46:15 -0400)

----------------------------------------------------------------
Nadav Haklai (1):
      ata: ahci_mvebu: Fix wrongly set base address for the MBus window setting

 drivers/ata/ahci_mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
tejun
