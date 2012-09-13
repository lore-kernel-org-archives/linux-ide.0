From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/2] Support runtime power off of HDD
Date: Thu, 13 Sep 2012 15:40:47 +0800
Message-ID: <1347522049-1836-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:55472 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab2IMHlI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2012 03:41:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>, Jack Wang <jack_wang@usish.com>, Shane Huang <shane.huang@amd.com>, Oliver Neukum <oliver@neukum.org>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>

This patch set is baed on v7 ZPODD patches.

Aaron Lu (2):
  scsi: sd: set ready_to_power_off for scsi disk
  libata: acpi: set can_power_off for both ODD and HDD

 drivers/ata/libata-acpi.c | 25 +++++++++++++++++--------
 drivers/scsi/sd.c         |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

-- 
1.7.12.21.g871e293

