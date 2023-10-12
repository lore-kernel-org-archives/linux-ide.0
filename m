Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79DCDB46E
	for <linux-ide@archiver.kernel.org>; Thu, 12 Oct 2023 07:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347100AbjJLHSG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Oct 2023 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347098AbjJLHSF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Oct 2023 03:18:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD066CF
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 00:18:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E351DC433C7;
        Thu, 12 Oct 2023 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697095083;
        bh=MsLoOVEv/wxEK2vHrrsy6BnjG8FoUuX8k/1vA7fmr7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAjclp0d3/yY2ZMPD8nFvrYa63SxIp+DrifGlNm1zOTwWp6iJGuaD1maMXOG1jYFe
         t5Ytu/mePOsAMAebFsBIOsXuYqoteaGjURBkqvCu0TL3A6F6blEsMCntgxnr2A0/w4
         Iyd9ivXKEu5XQjXoCjq3HZsba+CX5j0W+F2ORBmO67lY2jrXaFJ3PTSgUzlsd0R+GX
         /s7QSEvYU319wmBhkj3BftnsGgnBRGN67cHwRwPmXmKDcl9o0foZuNqpyhYUmoC99Z
         iBdZRsEaVXkOtkP8zWYYCVlBzzd3mATXTCilBVRZzbekgmabnopc6hd+dRETVH0xk9
         3RuDgtorzMHIg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Phillip Susi <phill@thesusis.net>
Subject: [PATCH 1/2] ata: libata-eh: Spinup disk on resume after revalidation
Date:   Thu, 12 Oct 2023 16:17:59 +0900
Message-ID: <20231012071800.468868-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012071800.468868-1-dlemoal@kernel.org>
References: <20231012071800.468868-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Move the call to ata_dev_power_set_active() to transition a disk in
standby power mode to the active power mode from
ata_eh_revalidate_and_attach() before doing revalidation to the end of
ata_eh_recover(), after the link speed for the device is reconfigured
(if that was necessary). This is safer as this ensure that the VERIFY
command executed to spinup the disk is executed with the drive properly
reconfigured first.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 945675f6b822..b0d6e69c4a5b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3051,15 +3051,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 		if (ehc->i.flags & ATA_EHI_DID_RESET)
 			readid_flags |= ATA_READID_POSTRESET;
 
-		/*
-		 * When resuming, before executing any command, make sure to
-		 * transition the device to the active power mode.
-		 */
-		if ((action & ATA_EH_SET_ACTIVE) && ata_dev_enabled(dev)) {
-			ata_dev_power_set_active(dev);
-			ata_eh_done(link, dev, ATA_EH_SET_ACTIVE);
-		}
-
 		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			WARN_ON(dev->class == ATA_DEV_PMP);
 
@@ -3856,6 +3847,17 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			}
 		}
 
+		/*
+		 * Make sure to transition devices to the active power mode
+		 * if needed (e.g. if we were scheduled on system resume).
+		 */
+		ata_for_each_dev(dev, link, ENABLED) {
+			if (ehc->i.dev_action[dev->devno] & ATA_EH_SET_ACTIVE) {
+				ata_dev_power_set_active(dev);
+				ata_eh_done(link, dev, ATA_EH_SET_ACTIVE);
+			}
+		}
+
 		/* retry flush if necessary */
 		ata_for_each_dev(dev, link, ALL) {
 			if (dev->class != ATA_DEV_ATA &&
-- 
2.41.0

