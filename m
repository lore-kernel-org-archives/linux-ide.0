From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.10-rc6
Date: Tue, 31 Jan 2017 11:46:34 -0500
Message-ID: <20170131164634.GB23970@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35006 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdAaQqm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2017 11:46:42 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Three libata fixes.  An error handling fix, blacklist addition for
another fallout from upping the default max sectors, and fix for a
sense data reporting bug which affects new harddrives which can report
sense data.

Thanks.

The following changes since commit 88ba6cae15e38f609aba4f3881e1c404c432596c:

  Merge tag 'platform-drivers-x86-v4.10-3' of git://git.infradead.org/users/dvhart/linux-platform-drivers-x86 (2017-01-05 23:17:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.10-fixes

for you to fetch changes up to 064c3db9c564cc5be514ac21fb4aa26cc33db746:

  ata: sata_mv:- Handle return value of devm_ioremap. (2017-01-06 15:45:32 -0500)

----------------------------------------------------------------
Arvind Yadav (1):
      ata: sata_mv:- Handle return value of devm_ioremap.

Damien Le Moal (1):
      libata: Fix ATA request sense

Tejun Heo (1):
      libata: apply MAX_SEC_1024 to all CX1-JB*-HP devices

 drivers/ata/libata-core.c | 6 ++++--
 drivers/ata/sata_mv.c     | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
tejun
