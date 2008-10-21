From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-eh: fix slave link EH action mask
 handling
Date: Tue, 21 Oct 2008 13:47:28 +0900
Message-ID: <48FD5EE0.9040407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44153 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbYJUEtf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 00:49:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Slave link action mask is transferred to masater link and all the EH
actions are taken by the master link.  ata_eh_about_to_do() and
ata_eh_done() are called with ATA_EH_ALL_ACTIONS to clear the slave
link actions during transfer.  This always sets ATA_PFLAG_RECOVERED
flag causing spurious "EH complete" messages.

Don't set ATA_PFLAG_RECOVERED for slave link actions.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1206,7 +1206,10 @@ void ata_eh_about_to_do(struct ata_link
 
 	ata_eh_clear_action(link, dev, ehi, action);
 
-	if (!(ehc->i.flags & ATA_EHI_QUIET))
+	/* About to take EH action, set RECOVERED.  Ignore actions on
+	 * slave links as master will do them again.
+	 */
+	if (!(ehc->i.flags & ATA_EHI_QUIET) && link != ap->slave_link)
 		ap->pflags |= ATA_PFLAG_RECOVERED;
 
 	spin_unlock_irqrestore(ap->lock, flags);
