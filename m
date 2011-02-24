From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix hotplug for drivers which
 don't implement LPM
Date: Thu, 24 Feb 2011 19:30:37 +0100
Message-ID: <20110224183037.GS7840@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44100 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab1BXSam (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 13:30:42 -0500
Received: by bwz15 with SMTP id 15so1290283bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2011 10:30:41 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

ata_eh_analyze_serror() suppresses hotplug notifications if LPM is
being used because LPM generates spurious hotplug events.  It compared
whether link->lpm_policy was different from ATA_LPM_MAX_POWER to
determine whether LPM is enabled; however, this is incorrect as for
drivers which don't implement LPM, lpm_policy is always
ATA_LPM_UNKNOWN.  This disabled hotplug detection for all drivers
which don't implement LPM.

Fix it by comparing whether lpm_policy is greater than
ATA_LPM_MAX_POWER.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@kernel.org
---
 drivers/ata/libata-eh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 17a6378..e16850e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1618,7 +1618,7 @@ static void ata_eh_analyze_serror(struct ata_link *link)
 	 * host links.  For disabled PMP links, only N bit is
 	 * considered as X bit is left at 1 for link plugging.
 	 */
-	if (link->lpm_policy != ATA_LPM_MAX_POWER)
+	if (link->lpm_policy > ATA_LPM_MAX_POWER)
 		hotplug_mask = 0;	/* hotplug doesn't work w/ LPM */
 	else if (!(link->flags & ATA_LFLAG_DISABLED) || ata_is_host_link(link))
 		hotplug_mask = SERR_PHYRDY_CHG | SERR_DEV_XCHG;
