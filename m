From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/7] sata_nv: add hotplug support
Date: Wed, 14 Jun 2006 06:31:04 +0900
Message-ID: <11502342641705-git-send-email-htejun@gmail.com>
References: <11502342632913-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:50617 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932309AbWFMVa7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 17:30:59 -0400
Received: by py-out-1112.google.com with SMTP id x31so73102pye
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 14:30:59 -0700 (PDT)
In-Reply-To: <11502342632913-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

272a9ef56e7ac2fa38ddde41af45b59f8cfe61ff
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index b041c13..d88eeed 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -69,7 +69,8 @@ enum {
 	NV_INT_PORT_SHIFT		= 4,	/* each port occupies 4 bits */
 
 	NV_INT_ALL			= 0x0f,
-	NV_INT_MASK			= NV_INT_DEV,
+	NV_INT_MASK			= NV_INT_DEV |
+					  NV_INT_ADDED | NV_INT_REMOVED,
 
 	/* INT_CONFIG */
 	NV_INT_CONFIG			= 0x12,
@@ -293,6 +294,13 @@ static int nv_host_intr(struct ata_port 
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	int handled;
 
+	/* freeze if hotplugged */
+	if (irq_stat_valid &&
+	    unlikely(irq_stat & (NV_INT_ADDED | NV_INT_REMOVED))) {
+		ata_port_freeze(ap);
+		return 1;
+	}
+
 	/* bail out if not our interrupt */
 	if (irq_stat_valid && !(irq_stat & NV_INT_DEV))
 		return 0;
-- 
1.3.2


