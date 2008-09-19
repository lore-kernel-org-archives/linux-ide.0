From: Elias Oltmanns <eo@nebensachen.de>
Subject: [PATCH 1/2 v3] Introduce ata_id_has_unload()
Date: Fri, 19 Sep 2008 23:46:01 +0200
Message-ID: <20080919214359.7183.81870.stgit@denkblock.local>
References: <87tzcb7r0r.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:47008 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbYISVrE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Sep 2008 17:47:04 -0400
In-Reply-To: <87tzcb7r0r.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Add a function to check an ATA device's id for head unload support as
specified in ATA-7.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

 include/linux/ata.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index cea079c..c66a7d6 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -707,6 +707,15 @@ static inline int ata_id_has_dword_io(const u16 *id)
 	return 0;
 }
 
+static inline int ata_id_has_unload(const u16 *id)
+{
+	if (ata_id_major_version(id) >= 7 &&
+	    (id[ATA_ID_CFSSE] & 0xC000) == 0x4000 &&
+	    id[ATA_ID_CFSSE] & (1 << 13))
+		return 1;
+	return 0;
+}
+
 static inline int ata_id_current_chs_valid(const u16 *id)
 {
 	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command


