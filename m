From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] ahci: kill 'intr_status'
Date: Wed, 11 Nov 2015 16:37:12 -0800
Message-ID: <20151112003613.10105.35435.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15808 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbbKLAhl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Nov 2015 19:37:41 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

This field in achi_port_priv was only used to support threaded
interrupts.  Now that we are hardirq only it can be deleted.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Tejun,

Feel free to fold this into "ahci: switch from 'threaded' to 'hardirq'
interrupt handling".  I noticed it shortly after hitting send on that
series.

 drivers/ata/ahci.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 9e60c50b2103..878470f9c3e2 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -309,7 +309,6 @@ struct ahci_port_priv {
 	unsigned int		ncq_saw_d2h:1;
 	unsigned int		ncq_saw_dmas:1;
 	unsigned int		ncq_saw_sdb:1;
-	atomic_t		intr_status;	/* interrupts to handle */
 	spinlock_t		lock;		/* protects parent ata_port */
 	u32 			intr_mask;	/* interrupts to enable */
 	bool			fbs_supported;	/* set iff FBS is supported */

