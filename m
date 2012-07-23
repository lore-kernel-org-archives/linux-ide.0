From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH 0/5] Fix for ZPODD
Date: Mon, 23 Jul 2012 14:49:35 +0800
Message-ID: <1343026180-22236-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:8823 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752312Ab2GWGu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2012 02:50:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Stern <stern@rowland.harvard.edu>, Lin Ming <minggr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

Here are some patches to make ZPODD easier to use for end users and
a fix for using ZPODD with system suspend.

Aaron Lu (5):
  scsi: sr: fix for sr suspend and resume
  scsi: sr: runtime pm when ODD is open/closed
  scsi: sr: block events when runtime suspended
  scsi: pm: use runtime resume callback if available
  block: genhd: add an interface to set disk's poll interval

 block/genhd.c          | 25 ++++++++++++++++++------
 drivers/scsi/scsi_pm.c | 14 ++++++++-----
 drivers/scsi/sr.c      | 53 ++++++++++++++++++++++++++++++++++++--------------
 include/linux/genhd.h  |  1 +
 4 files changed, 67 insertions(+), 26 deletions(-)

-- 
1.7.11.3


