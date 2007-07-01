From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/15] libata-pmp: update ata_eh_reset() for PMP
Date: Sun, 1 Jul 2007 19:54:13 +0900
Message-ID: <1183287253915-git-send-email-htejun@gmail.com>
References: <1183287253677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:11952 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835AbXGAKyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:54:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1891696wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:54:18 -0700 (PDT)
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

PMP always requires SRST to be enabled.  Also, hardreset reports
classification code from the first device when PMP is attached, not
from the PMP.  Update ata_eh_reset() such that followup softreset is
performed if the controller is PMP capable and the host link is being
reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 03b1665..01cd3be 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1841,6 +1841,8 @@ static int ata_eh_followup_srst_needed(struct ata_link *link,
 		return 1;
 	if (rc != 0)
 		return 0;
+	if ((link->ap->flags & ATA_FLAG_PMP) && ata_is_host_link(link))
+		return 1;
 	if (classify && !(link->flags & ATA_LFLAG_ASSUME_CLASS) &&
 	    classes[0] == ATA_DEV_UNKNOWN)
 		return 1;
-- 
1.5.0.3


