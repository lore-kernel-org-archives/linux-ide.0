From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] sata_nv: add hotplug support
Date: Sat, 17 Jun 2006 15:49:56 +0900
Message-ID: <11505269964089-git-send-email-htejun@gmail.com>
References: <11505269953650-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:5491 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932468AbWFQGuF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 02:50:05 -0400
Received: by py-out-1112.google.com with SMTP id i49so810088pye
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2006 23:50:04 -0700 (PDT)
In-Reply-To: <11505269953650-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

9e6fcaab7c4457835c1417c45b702945c754bd4f
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 2a1bd85..19deaa4 100644
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
@@ -324,6 +325,12 @@ static int nv_host_intr(struct ata_port 
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	int handled;
 
+	/* freeze if hotplugged */
+	if (unlikely(irq_stat & (NV_INT_ADDED | NV_INT_REMOVED))) {
+		ata_port_freeze(ap);
+		return 1;
+	}
+
 	/* bail out if not our interrupt */
 	if (!(irq_stat & NV_INT_DEV))
 		return 0;
-- 
1.3.2


