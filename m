From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata: sata_down_spd_limit should return if driver has not recorded sstatus speed
Date: Tue, 14 Nov 2017 16:17:25 -0600
Message-ID: <1510697845-58071-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753921AbdKNWR0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 14 Nov 2017 17:17:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

During hotplug, it is possible for 6Gbps link speed to
be limited all the way down to 1.5 Gbps which may lead
to a slower link speed when drive is re-connected.

This behavior has been seen on a Intel Lewisburg SATA
controller (8086:a1d2) with HGST HUH728080ALE600 drive
where SATA link speed was limited to 1.5 Gbps and
when re-connected the link came up 3.0 Gbps.

This patch was retested on above configuration and
showed the hotplugged link to come back online at max
speed (6Gbps). I did not see the downgrade when testing
on Intel C600/X79, but retested patched linux-4.14-rc5
kernel and didn't see any side effects from this
change. Also, successfully retested hotplug on port
multiplier 3Gbps link.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/libata-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ee4c1ec..b72b242 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3081,12 +3081,17 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 	mask &= ~(1 << bit);
 
 	/* Mask off all speeds higher than or equal to the current
-	 * one.  Force 1.5Gbps if current SPD is not available.
+	 * one. At this point if current SPD is not available and we
+	 * previously recorded the link speed from the Status register,
+	 * the driver has already masked off the highest bit so mask
+	 * should already be set to 1 or 0. Otherwise, we should
+	 * not force 1.5Gbps on a link where we have not previously 
+	 * recorded speed from Status register, just return in this case.
 	 */
 	if (spd > 1)
 		mask &= (1 << (spd - 1)) - 1;
 	else
-		mask &= 1;
+		return -EINVAL;
 
 	/* were we already at the bottom? */
 	if (!mask)
-- 
1.8.3.1

