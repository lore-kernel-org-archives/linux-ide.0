From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] libata: don't configure downstream links faster than the upstream link
Date: Wed, 31 Oct 2007 10:17:07 +0900
Message-ID: <11937934282500-git-send-email-htejun@gmail.com>
References: <11937934273607-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:9120 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbXJaB2r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 21:28:47 -0400
In-Reply-To: <11937934273607-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

There's nothing to be gained by configuring downstream links faster
than the upstream link and such configurations cause problems on
certain PMPs.  Limit downstream link speed by the upstream link speed.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fd46606..9b6e7b8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2545,17 +2545,27 @@ int sata_down_spd_limit(struct ata_link *link)
 
 static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
 {
-	u32 spd, limit;
+	struct ata_link *host_link = &link->ap->link;
+	u32 limit, target, spd;
 
-	if (link->sata_spd_limit == UINT_MAX)
-		limit = 0;
+	limit = link->sata_spd_limit;
+
+	/* Don't configure downstream link faster than upstream link.
+	 * It doesn't speed up anything and some PMPs choke on such
+	 * configuration.
+	 */
+	if (!ata_is_host_link(link) && host_link->sata_spd)
+		limit &= (1 << host_link->sata_spd) - 1;
+
+	if (limit == UINT_MAX)
+		target = 0;
 	else
-		limit = fls(link->sata_spd_limit);
+		target = fls(limit);
 
 	spd = (*scontrol >> 4) & 0xf;
-	*scontrol = (*scontrol & ~0xf0) | ((limit & 0xf) << 4);
+	*scontrol = (*scontrol & ~0xf0) | ((target & 0xf) << 4);
 
-	return spd != limit;
+	return spd != target;
 }
 
 /**
-- 
1.5.2.4

