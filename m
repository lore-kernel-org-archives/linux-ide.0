From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: transfer EHI control flags to slave
 ehc.i
Date: Tue, 21 Oct 2008 14:26:39 +0900
Message-ID: <48FD680F.3090206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48747 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbYJUF2p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 01:28:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

ATA_EHI_NO_AUTOPSY and ATA_EHI_QUIET are used to control the behavior
of EH.  As only the master link is visible outside EH, these flags are
set only for the master link although they should also apply to the
slave link, which causes spurious EH messages during probe and
suspend/resume.

This patch transfers those two flags to slave ehc.i before performing
slave autopsy and reporting.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |    5 +++++
 include/linux/libata.h  |    3 +++
 2 files changed, 8 insertions(+)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2013,8 +2013,13 @@ void ata_eh_autopsy(struct ata_port *ap)
 		struct ata_eh_context *mehc = &ap->link.eh_context;
 		struct ata_eh_context *sehc = &ap->slave_link->eh_context;
 
+		/* transfer control flags from master to slave */
+		sehc->i.flags |= mehc->i.flags & ATA_EHI_TO_SLAVE_MASK;
+
+		/* perform autopsy on the slave link */
 		ata_eh_link_autopsy(ap->slave_link);
 
+		/* transfer actions from slave to master and clear slave */
 		ata_eh_about_to_do(ap->slave_link, NULL, ATA_EH_ALL_ACTIONS);
 		mehc->i.action		|= sehc->i.action;
 		mehc->i.dev_action[1]	|= sehc->i.dev_action[1];
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -340,6 +340,9 @@ enum {
 
 	ATA_EHI_DID_RESET	= ATA_EHI_DID_SOFTRESET | ATA_EHI_DID_HARDRESET,
 
+	/* mask of flags to transfer *to* the slave link */
+	ATA_EHI_TO_SLAVE_MASK	= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET,
+
 	/* max tries if error condition is still set after ->error_handler */
 	ATA_EH_MAX_TRIES	= 5,
 
