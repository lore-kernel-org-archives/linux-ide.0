From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 3/4] libata: use ata_link_printk() when printing
 SError
Date: Thu, 31 Jul 2008 16:08:38 +0900
Message-ID: <489164F6.4080602@kernel.org>
References: <48916498.20703@kernel.org> <489164D2.9000009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58258 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbYGaHJk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 03:09:40 -0400
In-Reply-To: <489164D2.9000009@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

SError belongs to link not port.  Use ata_link_printk() to print it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b82e8ae..5de0bf3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2040,7 +2040,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	}
 
 	if (ehc->i.serror)
-		ata_port_printk(ap, KERN_ERR,
+		ata_link_printk(link, KERN_ERR,
 		  "SError: { %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s}\n",
 		  ehc->i.serror & SERR_DATA_RECOVERED ? "RecovData " : "",
 		  ehc->i.serror & SERR_COMM_RECOVERED ? "RecovComm " : "",
-- 
1.5.4.5

