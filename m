From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] hpt366: fix clock turnaround
Date: Mon, 7 Dec 2009 19:03:36 +0400
Message-ID: <200912071803.37117.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:22000 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932689AbZLGPCS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 10:02:18 -0500
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
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
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: ide-2.6/drivers/ide/hpt366.c
===================================================================
--- ide-2.6.orig/drivers/ide/hpt366.c
+++ ide-2.6/drivers/ide/hpt366.c
@@ -901,7 +901,7 @@ static void hpt3xxn_set_clock(ide_hwif_t
 
 static void hpt3xxn_rw_disk(ide_drive_t *drive, struct request *rq)
 {
-	hpt3xxn_set_clock(drive->hwif, rq_data_dir(rq) ? 0x23 : 0x21);
+	hpt3xxn_set_clock(drive->hwif, rq_data_dir(rq) ? 0x21 : 0x23);
 }
 
 /**

