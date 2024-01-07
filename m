Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A313FE0
	for <linux-ide@vger.kernel.org>; Sun,  7 Jan 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 9E42315231F; Sun,  7 Jan 2024 13:03:01 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 1/3] libata: avoid waking disk for several commands
Date: Sun,  7 Jan 2024 13:02:56 -0500
Message-Id: <20240107180258.360886-2-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240107180258.360886-1-phill@thesusis.net>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a disk is in SLEEP mode it can not respond to any
any commands.  Several commands are simply a NOOP to a disk
that is in standby mode, but when a disk is in SLEEP mode,
they frequencly cause the disk to spin up for no reason.
To avoid this, complete these commands in libata without
waking the disk.  These commands are:

CHECK POWER MODE
FLUSH CACHE
SLEEP
STANDBY IMMEDIATE
IDENTIFY

If we know the disk is sleeping, we don't need to wake it up
to find out if it is in standby, so just pretend it is in
standby.  While asleep, there's no dirty pages in the cache,
so there's no need to flush it.  There's no point in waking
a disk from sleep just to put it back to sleep.  We also have
a cache of the IDENTIFY information so just return that
instead of waking the disk.
---
 drivers/ata/libata-core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 09ed67772fae..6c5269de4bf2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5040,6 +5040,26 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 
 	/* if device is sleeping, schedule reset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
+		switch (qc->tf.command)
+		{
+		case ATA_CMD_CHK_POWER:
+		case ATA_CMD_SLEEP:
+		case ATA_CMD_FLUSH:
+		case ATA_CMD_FLUSH_EXT:
+		case ATA_CMD_STANDBYNOW1:
+			if (qc->tf.command == ATA_CMD_ID_ATA)
+			{
+				/* only fake the reply for IDENTIFY if it is from userspace */
+				if (ata_tag_internal(qc->tag))
+					break;
+				sg_copy_from_buffer(qc->sg, 1, qc->dev->id, 2 * ATA_ID_WORDS);
+			}
+			/* fake reply to avoid waking drive */
+			qc->flags |= ATA_QCFLAG_RTF_FILLED;
+			qc->result_tf.nsect = 0;
+			ata_qc_complete(qc);
+			return;
+		}
 		link->eh_info.action |= ATA_EH_RESET;
 		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
 		ata_link_abort(link);
-- 
2.30.2

