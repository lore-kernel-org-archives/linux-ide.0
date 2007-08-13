From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 3/4] Enable link power management for ata drivers
Date: Mon, 13 Aug 2007 10:26:23 -0700
Message-ID: <20070813102623.7ef91e1e.kristen.c.accardi@intel.com>
References: <20070809211800.022150464@intel.com>
	<20070809142416.a110ba25.kristen.c.accardi@intel.com>
	<9122.1186808329@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41788 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S948118AbXHMR30 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Aug 2007 13:29:26 -0400
In-Reply-To: <9122.1186808329@turing-police.cc.vt.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: jeff@garzik.org, htejun@gmail.com, akpm@linux-foundation.org, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew, can you fold this into this patch


change to KERN_INFO for failure to set pm policy

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-git/drivers/ata/libata-scsi.c
===================================================================
--- 2.6-git.orig/drivers/ata/libata-scsi.c	2007-08-13 09:40:18.000000000 -0700
+++ 2.6-git/drivers/ata/libata-scsi.c	2007-08-13 10:23:04.000000000 -0700
@@ -3009,7 +3009,7 @@ int ata_scsi_set_link_pm_policy(struct a
  		 */
 		if ((dev->horkage & ATA_HORKAGE_IPM) ||
 			!(dev->flags & ATA_DFLAG_IPM)) {
-			ata_dev_printk(dev, KERN_ERR,
+			ata_dev_printk(dev, KERN_INFO,
 				"Unable to set Link PM policy\n");
 			ap->pm_policy = MAX_PERFORMANCE;
 		}
