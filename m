Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647182CCD1
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2024 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 94A2D151D5F; Thu,  4 Jan 2024 17:40:17 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 3/4] libata: avoid waking disk for several commands
Date: Thu,  4 Jan 2024 17:39:39 -0500
Message-Id: <20240104223940.339290-3-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104223940.339290-1-phill@thesusis.net>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a disk is in SLEEP mode it can not respond to any
commands.  Instead of waking up the sleeping disk, fake the
commands.  The commands include:

CHECK POWER
FLUSH CACHE
SLEEP
STANDBY IMMEDIATE
IDENTIFY

If we konw the disk is sleeping, we don't need to wake it up
to to find out if it is in standby, so just pretend it is in
standby.  While alseep, there's no dirty pages in the cache,
so there's no need to flush it.  There's no point in waking
a disk from sleep just to put it back to sleep.  We also have
a cache of the IDENTIFY information so just return that
instead of waking the disk.
---
 drivers/ata/libata-core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1244da8f77e2..d9e889fa2881 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5045,6 +5045,22 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 
 	/* if device is sleeping, schedule reset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
+		if (unlikely(qc->tf.command == ATA_CMD_CHK_POWER ||
+			     qc->tf.command == ATA_CMD_SLEEP ||
+			     qc->tf.command == ATA_CMD_FLUSH ||
+			     qc->tf.command == ATA_CMD_FLUSH_EXT ||
+			     qc->tf.command == ATA_CMD_STANDBYNOW1 ||
+			     (qc->tf.command == ATA_CMD_ID_ATA &&
+			      !ata_tag_internal(qc->tag))))
+		{
+			/* fake reply to avoid waking drive */
+			qc->flags |= ATA_QCFLAG_RTF_FILLED;
+			qc->result_tf.nsect = 0;
+			if (qc->tf.command == ATA_CMD_ID_ATA)
+				sg_copy_from_buffer(qc->sg, 1, qc->dev->id, 2 * ATA_ID_WORDS);
+			ata_qc_complete(qc);
+			return;
+		}
 		link->eh_info.action |= ATA_EH_RESET;
 		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
 		ata_link_abort(link);
-- 
2.30.2

