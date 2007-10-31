From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] libata: request PHY speed configuration on SControl access failure
Date: Wed, 31 Oct 2007 10:17:06 +0900
Message-ID: <11937934283415-git-send-email-htejun@gmail.com>
References: <11937934273607-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:9122 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbXJaB2r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 21:28:47 -0400
In-Reply-To: <11937934273607-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

In sata_set_spd_needed(), if SControl read failed, it returned 0 and
skipped PHY speed configuration.  However, if SControl access fails,
it's far more logical to request PHY speed configuration.  Reverse the
logic.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8ee56e5..fd46606 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2578,7 +2578,7 @@ int sata_set_spd_needed(struct ata_link *link)
 	u32 scontrol;
 
 	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
-		return 0;
+		return 1;
 
 	return __sata_set_spd_needed(link, &scontrol);
 }
-- 
1.5.2.4

