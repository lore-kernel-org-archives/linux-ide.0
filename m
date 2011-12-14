From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 0/3] fixes for ata port runtime pm support
Date: Wed, 14 Dec 2011 11:17:58 +0800
Message-ID: <1323832681-7177-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53347 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048Ab1LNDSP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2011 22:18:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, James Bottomley <JBottomley@parallels.com>, Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org

Hi Jeff,

Here are some fixes for ata port runtime pm support.
Applied on top of libata tree.

Lin Ming (3):
      [SCSI] sd: fix runtime status check in sd_shutdown
      [SCSI]: runtime resume parent for child's system-resume
      ata: update ata port's runtime status during system resume

 drivers/ata/libata-core.c |   18 ++++++++++++++++--
 drivers/scsi/scsi_pm.c    |   11 ++++++++++-
 drivers/scsi/sd.c         |    7 ++++++-
 3 files changed, 32 insertions(+), 4 deletions(-)

Thanks,
Lin Ming

