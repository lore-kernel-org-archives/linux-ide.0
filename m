From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/4] libata: fix EH action overwriting in
 ata_eh_reset()
Date: Thu, 31 Jul 2008 16:07:04 +0900
Message-ID: <48916498.20703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58257 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbYGaHJk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 03:09:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

ehc->i.action got accidentally overwritten to ATA_EH_HARD/SOFTRESET in
ata_eh_reset().  The original intention was to clear reset action
which wasn't selected.  This can cause unexpected behavior when other
EH actions are scheduled together with reset.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 58bdc53..a3c0139 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2247,10 +2247,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ehc->i.action &= ~ATA_EH_RESET;
 	if (hardreset) {
 		reset = hardreset;
-		ehc->i.action = ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_HARDRESET;
 	} else if (softreset) {
 		reset = softreset;
-		ehc->i.action = ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_SOFTRESET;
 	}
 
 	if (prereset) {
-- 
1.5.4.5

