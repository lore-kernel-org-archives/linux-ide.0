From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] hpt366: fix clock turnaround
Date: Mon, 27 Sep 2010 18:09:43 +0400
Message-ID: <201009271809.44135.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:45553 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932939Ab0I0ORH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Sep 2010 10:17:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

DPLL clock (0x21) should be used for writes and PCI clock (0x23) for reads,
not vice versa.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: stable@kernel.org

---
The patch is atop of ide-2.6.git tree.

Not sure why I didn't fix this back in 2007... well, nobody has ever
complained. :-)

 drivers/ide/hpt366.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: ide-2.6/drivers/ide/hpt366.c
===================================================================
--- ide-2.6.orig/drivers/ide/hpt366.c
+++ ide-2.6/drivers/ide/hpt366.c
@@ -838,7 +838,7 @@ static void hpt3xxn_set_clock(ide_hwif_t
 
 static void hpt3xxn_rw_disk(ide_drive_t *drive, struct request *rq)
 {
-	hpt3xxn_set_clock(drive->hwif, rq_data_dir(rq) ? 0x23 : 0x21);
+	hpt3xxn_set_clock(drive->hwif, rq_data_dir(rq) ? 0x21 : 0x23);
 }
 
 /**
