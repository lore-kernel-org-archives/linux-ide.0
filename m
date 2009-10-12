From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH 1/1] sata_mv: Prevent PIO commands to be defered too long if traffic in progress.
Date: Mon, 12 Oct 2009 15:44:00 -0700
Message-ID: <1255387440-13313-2-git-send-email-gwendal@google.com>
References: <>
 <1255387440-13313-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:12842 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758144AbZJLWpO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2009 18:45:14 -0400
In-Reply-To: <1255387440-13313-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mlord@pobox.com
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

Use excl_link when non NCQ commands are defered, to be sure they are processed
as soon as outstanding commands are completed. It prevents some commands to be
defered indifinitely when using a port multiplier.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/sata_mv.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 17f9ff9..6f5093b 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1382,6 +1382,25 @@ static int mv_qc_defer(struct ata_queued_cmd *qc)
 	 */
 	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH)
 		return ATA_DEFER_PORT;
+
+	/* PIO commands need exclusive link: no other commands [DMA or PIO]
+	 * can run concurrently.
+	 * set excl_link when we want to send a PIO command in DMA mode
+	 * or a non-NCQ command in NCQ mode.
+	 * When we receive a command from that link, and there are no
+	 * outstanding commands, mark a flag to clear excl_link and let
+	 * the command go through.
+	 */
+	if (unlikely(ap->excl_link)) {
+		if (link == ap->excl_link) {
+			if (ap->nr_active_links)
+				return ATA_DEFER_PORT;
+			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
+			return 0;
+		} else
+			return ATA_DEFER_PORT;
+	}
+
 	/*
 	 * If the port is completely idle, then allow the new qc.
 	 */
@@ -1395,8 +1414,14 @@ static int mv_qc_defer(struct ata_queued_cmd *qc)
 	 * doesn't allow it.
 	 */
 	if ((pp->pp_flags & MV_PP_FLAG_EDMA_EN) &&
-	    (pp->pp_flags & MV_PP_FLAG_NCQ_EN) && ata_is_ncq(qc->tf.protocol))
-		return 0;
+	    (pp->pp_flags & MV_PP_FLAG_NCQ_EN)) {
+		if (ata_is_ncq(qc->tf.protocol))
+			return 0;
+		else {
+			ap->excl_link = link;
+			return ATA_DEFER_PORT;
+		}
+	}
 
 	return ATA_DEFER_PORT;
 }
-- 
1.5.4.3

