From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 3/5] pata_bk3710: clear status bits of BMISP on chipset
 initialization
Date: Wed, 22 Mar 2017 19:21:00 +0100
Message-ID: <1490206862-26065-4-git-send-email-b.zolnierkie@samsung.com>
References: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170322182139epcas5p32d912444c0be8747565a4979f8744572@epcas5p3.samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33829 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965534AbdCVSVo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2017 14:21:44 -0400
In-reply-to: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Clear IORDYINT, INTRSTAT and DMAERROR bits of BMISP register
(value '1' needs to be written to the bit to clear it).

Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_bk3710.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
index f22e4bf..6c3bd5f 100644
--- a/drivers/ata/pata_bk3710.c
+++ b/drivers/ata/pata_bk3710.c
@@ -276,7 +276,7 @@ static void pata_bk3710_chipinit(void __iomem *base)
 	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
 	 * (ATA_BMISP_DMAERROR	, CLEAR)
 	 */
-	iowrite16(0, base + BK3710_BMISP);
+	iowrite16(0xE, base + BK3710_BMISP);
 
 	pata_bk3710_setpiomode(base, NULL, 0, 600, 0);
 	pata_bk3710_setpiomode(base, NULL, 1, 600, 0);
-- 
1.9.1

