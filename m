From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] icside: register second channel of version 6 PCB
Date: Fri, 15 May 2009 20:08:29 +0400
Message-ID: <200905152008.29452.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40402 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755408AbZEOQHs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 May 2009 12:07:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The second IDE channel of version 6 PCB is not being registered anymore since
the commit 48c3c1072651922ed153bcf0a33ea82cf20df390 (ide: add struct ide_host
(take 3)).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is aginst the recent Linus' tree...

 drivers/ide/icside.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/icside.c
===================================================================
--- linux-2.6.orig/drivers/ide/icside.c
+++ linux-2.6/drivers/ide/icside.c
@@ -466,7 +466,7 @@ icside_register_v6(struct icside_state *
 	struct ide_host *host;
 	unsigned int sel = 0;
 	int ret;
-	hw_regs_t hw[2], *hws[] = { &hw[0], NULL, NULL, NULL };
+	hw_regs_t hw[2], *hws[] = { &hw[0], &hw[1], NULL, NULL };
 	struct ide_port_info d = icside_v6_port_info;
 
 	ioc_base = ecardm_iomap(ec, ECARD_RES_IOCFAST, 0, 0);

