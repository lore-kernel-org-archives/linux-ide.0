From: Elias Oltmanns <eo@nebensachen.de>
Subject: [PATCH 1/4] Introduce ata_id_has_unload()
Date: Fri, 29 Aug 2008 23:16:47 +0200
Message-ID: <20080829211345.4355.63012.stgit@denkblock.local>
References: <87wshzplvk.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:51620 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756123AbYH2VRZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 17:17:25 -0400
In-Reply-To: <87wshzplvk.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dun>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Add a function to check an ATA device's id for head unload support as
specified in ATA-7.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

 include/linux/ata.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 80364b6..d9a94bd 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -707,6 +707,23 @@ static inline int ata_id_has_dword_io(const u16 *id)
 	return 0;
 }
 
+static inline int ata_id_has_unload(const u16 *id)
+{
+	/*
+	 * ATA-7 specifies two places to indicate unload feature
+	 * support. Since I don't really understand the difference,
+	 * I'll just check both and only return zero if none of them
+	 * indicates otherwise.
+	 */
+	if (ata_id_major_version(id) >= 7
+	    && (((id[ATA_ID_CFSSE] & 0xC000) == 0x4000
+		 && id[ATA_ID_CFSSE] & (1 << 13))
+		|| ((id[ATA_ID_CSF_DEFAULT] & 0xC000) == 0x4000
+		    && (id[ATA_ID_CSF_DEFAULT] & (1 << 13)))))
+		return 1;
+	return 0;
+}
+
 static inline int ata_id_current_chs_valid(const u16 *id)
 {
 	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command


