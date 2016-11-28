From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.9-rc7
Date: Mon, 28 Nov 2016 16:06:33 -0500
Message-ID: <20161128210633.GA11003@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33400 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755287AbcK1VGg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Nov 2016 16:06:36 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Linus.

The recent changes in ahci MSI handling need one more fix.  Hopefully,
this restores parity with before.  The other two are minor fixes with
both low impact and risk.

Thanks.

The following changes since commit 0ce57f8af1782fd12d3a81872a4ab97244989802:

  ahci: fix the single MSI-X case in ahci_init_one (2016-10-25 11:43:07 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.9-fixes

for you to fetch changes up to 6929ef385e09c0065b87fda3e7b872a5070ac783:

  ahci: always fall back to single-MSI mode (2016-11-21 11:06:57 -0500)

----------------------------------------------------------------
Christoph Hellwig (1):
      ahci: always fall back to single-MSI mode

Hannes Reinecke (1):
      libata-scsi: Fixup ata_gen_passthru_sense()

Wei Yongjun (1):
      mvsas: fix error return code in mvs_task_prep()

 drivers/ata/ahci.c          | 7 -------
 drivers/ata/libata-scsi.c   | 2 +-
 drivers/scsi/mvsas/mv_sas.c | 4 +++-
 3 files changed, 4 insertions(+), 9 deletions(-)
