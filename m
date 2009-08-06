From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] When a disk needs to be waken up from sleep, ensure that the command is retried by SCSI EH.
Date: Thu,  6 Aug 2009 10:25:47 -0700
Message-ID: <1249579547-21091-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:4633 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbZHFRZy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2009 13:25:54 -0400
In-Reply-To: <>
References: <>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>


Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8ac98ff..5b7616d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5145,6 +5145,8 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	/* if device is sleeping, schedule reset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
 		link->eh_info.action |= ATA_EH_RESET;
+		if (qc->scsicmd) 
+			qc->scsicmd->allowed++;
 		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
 		ata_link_abort(link);
 		return;
-- 
1.5.4.3

