From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_legacy: correctly mask recovery field for HT6560B
Date: Thu, 19 Jan 2012 19:09:56 +0300
Message-ID: <201201191909.56745.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:52281 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932169Ab2ASPLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2012 10:11:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com
Cc: stable@kernel.org

According to the HT6560H datasheet, the recovery timing field is 4-bit wide,
with a value of 0 meaning 16 cycles. Correct obvious thinko in the recovery
field mask.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: stable@kernel.org

---
The patch is against the current Linus' tree.
The bug was there from the day one, so the fix needs to be merged to
all stable kernels since 2.6.19 (when PATA driver were merged)...

 drivers/ata/pata_legacy.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/pata_legacy.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_legacy.c
+++ linux-2.6/drivers/ata/pata_legacy.c
@@ -401,8 +401,7 @@ static void ht6560b_set_piomode(struct a
 	ata_timing_compute(adev, adev->pio_mode, &t, 20000, 1000);
 
 	active = clamp_val(t.active, 2, 15);
-	recover = clamp_val(t.recover, 2, 16);
-	recover &= 0x15;
+	recover = clamp_val(t.recover, 2, 16) & 0x0F;
 
 	inb(0x3E6);
 	inb(0x3E6);
