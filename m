From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.9-rc2
Date: Wed, 26 Oct 2016 14:29:11 -0400
Message-ID: <20161026182911.GB23927@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33316 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbcJZS3O (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Oct 2016 14:29:14 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Linus.

The AHCI MSI handling change in rc1 was a bit broken and caused disk
probing failures on some machines.  These three patches should fix the
issues.

Thanks.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.9-fixes

for you to fetch changes up to 0ce57f8af1782fd12d3a81872a4ab97244989802:

  ahci: fix the single MSI-X case in ahci_init_one (2016-10-25 11:43:07 -0400)

----------------------------------------------------------------
Christoph Hellwig (3):
      ahci: only try to use multi-MSI mode if there is more than 1 port
      ahci: fix nvec check
      ahci: fix the single MSI-X case in ahci_init_one

 drivers/ata/ahci.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

-- 
tejun
