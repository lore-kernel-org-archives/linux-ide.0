From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix hw_sata_spd_limit initialization
Date: Wed, 6 Jun 2007 16:35:55 +0900
Message-ID: <20070606073555.GA29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:11144 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbXFFHf7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jun 2007 03:35:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so70586wah
        for <linux-ide@vger.kernel.org>; Wed, 06 Jun 2007 00:35:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

hw_sata_spd_limit used to be incorrectly initialized to zero instead
of UINT_MAX if SPD is zero in SControl register.  This breaks PHY
speed down.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6318,7 +6318,8 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		/* init sata_spd_limit to the current value */
 		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
-			ap->hw_sata_spd_limit &= (1 << spd) - 1;
+			if (spd)
+				ap->hw_sata_spd_limit &= (1 << spd) - 1;
 		}
 		ap->sata_spd_limit = ap->hw_sata_spd_limit;
 
