From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix NULL sdev dereference race in
 atapi_qc_complete()
Date: Mon, 01 Nov 2010 11:39:19 +0100
Message-ID: <4CCE98D7.1030906@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53998 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab0KAKjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Nov 2010 06:39:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>

SCSI commands may be issued between __scsi_add_device() and dev->sdev
assignment, so it's unsafe for ata_qc_complete() to dereference
dev->sdev->locked without checking whether it's NULL or not.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@kernel.org
---
I actually hit this race condition.  Lucky me.  :-)

Thanks.

 drivers/ata/libata-scsi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -2552,8 +2552,11 @@ static void atapi_qc_complete(struct ata
 		 *
 		 * If door lock fails, always clear sdev->locked to
 		 * avoid this infinite loop.
+		 *
+		 * This may happen before SCSI scan is complete.  Make
+		 * sure qc->dev->sdev isn't NULL before dereferencing.
 		 */
-		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL)
+		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL && qc->dev->sdev)
 			qc->dev->sdev->locked = 0;

 		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
