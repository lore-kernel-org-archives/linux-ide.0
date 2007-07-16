From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/8] libata-pmp: update ata_eh_reset() for PMP
Date: Mon, 16 Jul 2007 18:46:04 +0900
Message-ID: <11845791643485-git-send-email-htejun@gmail.com>
References: <1184579163885-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:53686 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743AbXGPJqN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:46:13 -0400
Received: by nz-out-0506.google.com with SMTP id s18so784842nze
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:46:13 -0700 (PDT)
In-Reply-To: <1184579163885-git-send-email-htejun@gmail.com>
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
index 3cfa860..bc3e690 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1906,6 +1906,8 @@ static int ata_eh_followup_srst_needed(struct ata_link *link,
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


