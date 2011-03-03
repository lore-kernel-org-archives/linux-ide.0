From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] Power off empty ports
Date: Thu,  3 Mar 2011 10:21:16 -0800
Message-ID: <1299176478-2999-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32825 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758627Ab1CCSS5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Mar 2011 13:18:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>

Give users the option of completely powering off unoccupied
SATA ports by introducing a new link_power_mananagement policy
option "power_off".  When the user selects this option on an
empty port, we will power off the port by setting DET to off.

Kristen Carlson Accardi (2):
  libata: add power_off policy for unoccupied ports
  Documentation: document new link power management policy option

 .../scsi/link_power_management_policy.txt          |    6 ++++--
 drivers/ata/libata-core.c                          |    4 ++++
 drivers/ata/libata-eh.c                            |    5 +++++
 drivers/ata/libata-scsi.c                          |    1 +
 include/linux/libata.h                             |    1 +
 5 files changed, 15 insertions(+), 2 deletions(-)

-- 
1.7.3.1

