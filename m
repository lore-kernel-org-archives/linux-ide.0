From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH] sata_sil: fix uninitialized variable use when
 sil_scr_read() fails
Date: Tue, 20 Oct 2009 15:34:56 +0900
Message-ID: <20091020153456.9104e044.yuasa@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:21974 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbZJTGev (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Oct 2009 02:34:51 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1107555eyd.19
        for <linux-ide@vger.kernel.org>; Mon, 19 Oct 2009 23:34:54 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: yuasa@linux-mips.org, linux-ide@vger.kernel.org


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

---
 drivers/ata/sata_sil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3cb69d5..d7fff6b 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -439,7 +439,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 	u8 status;
 
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
-		u32 serror;
+		u32 serror = 0;
 
 		/* SIEN doesn't mask SATA IRQs on some 3112s.  Those
 		 * controllers continue to assert IRQ as long as
-- 
1.6.5.1


