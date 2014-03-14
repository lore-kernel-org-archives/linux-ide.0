From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/3] ata: acpi/zpodd: some small fixes
Date: Fri, 14 Mar 2014 13:46:07 +0800
Message-ID: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37840 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbaCNFpk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Mar 2014 01:45:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Two small fix for libata-acpi and libata-zpodd and one simplification
for libata-zpodd.

Aaron Lu (3):
  libata: zpodd: should depend on PM_RUNTIME
  libata: acpi: avoid passing NULL to ACPI evaluation method
  libata: zpodd: eliminate odd_can_poweroff

 drivers/ata/Kconfig        |  2 +-
 drivers/ata/libata-acpi.c  |  1 +
 drivers/ata/libata-zpodd.c | 21 ++-------------------
 3 files changed, 4 insertions(+), 20 deletions(-)

-- 
1.8.5.3

