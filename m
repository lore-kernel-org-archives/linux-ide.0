From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.0-rc5
Date: Tue, 24 Mar 2015 14:36:45 -0400
Message-ID: <20150324183645.GO3880@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33429 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbbCXShJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Mar 2015 14:37:09 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Shaohua Li <shli@fb.com>

Hello, Linus.

One patch to fix a regression from the recent switch to blk-mq tag
allocation which can cause oops on SAS-attached SATA drives.

Thanks.

The following changes since commit 29200f12a1167076346415e18eee9065cb77a859:

  sata-fsl: Apply link speed limits (2015-03-02 12:08:43 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.0-fixes

for you to fetch changes up to 5067c0469c643512f24786990e315f9c15cc7d24:

  ata: Add a new flag to destinguish sas controller (2015-03-19 14:14:43 -0400)

----------------------------------------------------------------
Shaohua Li (1):
      ata: Add a new flag to destinguish sas controller

 drivers/ata/libata-core.c     | 4 ++--
 drivers/scsi/ipr.c            | 3 ++-
 drivers/scsi/libsas/sas_ata.c | 3 ++-
 include/linux/libata.h        | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
tejun
