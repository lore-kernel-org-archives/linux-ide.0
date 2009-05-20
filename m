From: Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH 0/2] libata: switch to block layer tagging
Date: Wed, 20 May 2009 08:59:42 +0200
Message-ID: <20090520065942.GD11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:45580 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbZETG7l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 02:59:41 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, htejun@gmail.com

Hi,

This patchset switches libata to block layer tagging. It gets rid of yet
another O(N) command loop.

 block/blk-tag.c           |   99 +++++++++++++++++++++++++++-----------
 drivers/ata/libata-core.c |   94 ++++++++++--------------------------
 drivers/ata/libata-scsi.c |   23 ++++++++
 drivers/ata/libata.h      |   19 ++++++-
 include/linux/blkdev.h    |    3 +
 include/linux/libata.h    |    1 
 6 files changed, 139 insertions(+), 100 deletions(-)

-- 
Jens Axboe

