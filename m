From: Elias Oltmanns <eo@nebensachen.de>
Subject: [PATCH 2/5] Introduce ata_id_has_unload()
Date: Sat, 26 Jul 2008 08:24:35 +0200
Message-ID: <20080726062142.29070.87751.stgit@denkblock.local>
References: <87prp1kvyy.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:37635 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbYGZGYs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jul 2008 02:24:48 -0400
In-Reply-To: <87prp1kvyy.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Add a function to check an ATA device's id for head unload support as
specified in ATA-7.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

 include/linux/ata.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index cf4ef6d..c92ac10 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -530,6 +530,21 @@ static inline bool ata_id_has_dipm(const u16 *id)
 }
 
 
+static inline int ata_id_has_unload(const u16 *id)
+{
+	/*
+	 * ATA-7 specifies two places to indicate unload feature support.
+	 * Since I don't really understand the difference, I'll just check
+	 * both and only return zero if none of them indicates otherwise.
+	 */
+	if ((id[ATA_ID_CFSSE] & 0xC000) == 0x4000
+	    && id[ATA_ID_CFSSE] & (1 << 13))
+		return id[ATA_ID_CFSSE] & (1 << 13);
+	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) == 0x4000)
+		return id[ATA_ID_CSF_DEFAULT] & (1 << 13);
+	return 0;
+}
+
 static inline int ata_id_has_fua(const u16 *id)
 {
 	if ((id[ATA_ID_CFSSE] & 0xC000) != 0x4000)


