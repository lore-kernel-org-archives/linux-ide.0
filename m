From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.8-rc4
Date: Tue, 30 Aug 2016 12:02:07 -0400
Message-ID: <20160830160207.GB12660@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33385 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755016AbcH3QCK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2016 12:02:10 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Two libata driver specific fixes for v4.8-rc4.  Nothing too scary.

Thanks.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.8-fixes

for you to fetch changes up to 9ebae9e4bcd7dff22536af8a969d8f66e6f23900:

  pata_ninja32: Avoid corrupting status flags (2016-08-30 11:59:47 -0400)

----------------------------------------------------------------
Alan Cox (1):
      pata_ninja32: Avoid corrupting status flags

Christoph Hellwig (1):
      ahci: disable correct irq for dummy ports

 drivers/ata/libahci.c      | 2 +-
 drivers/ata/pata_ninja32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
tejun
