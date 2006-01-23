From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/13] ahci: fix err_mask setting in ahci_host_intr
Date: Mon, 23 Jan 2006 13:09:36 +0900
Message-ID: <11379893761644-git-send-email-htejun@gmail.com>
References: <11379893762140-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:65043 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751405AbWAWEJm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 23:09:42 -0500
Received: by wproxy.gmail.com with SMTP id 57so810375wri
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2006 20:09:42 -0800 (PST)
In-Reply-To: <11379893762140-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

In ahci_host_intr err_mask is determined from IRQ status but never
used.  This patch sets qc->err_mask to the determined err_mask.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

72a3f6348bd748686e9fdc396dbf05a877da3d91
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 30676b0..a168b52 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -721,7 +721,7 @@ static inline int ahci_host_intr(struct 
 		ahci_restart_port(ap, status);
 
 		if (qc) {
-			qc->err_mask |= AC_ERR_OTHER;
+			qc->err_mask |= err_mask;
 			ata_qc_complete(qc);
 		}
 	}
-- 
1.0.8


