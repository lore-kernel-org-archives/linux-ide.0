From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] pata_scc: kill useless check in scc_postreset()
Date: Sat, 24 Apr 2010 20:29:58 +0400
Message-ID: <201004242029.59003.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47067 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752525Ab0DXQar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Apr 2010 12:30:47 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

The device control register exists and its address is set by scc_setup_ports(),
hence the check is useless...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_scc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/pata_scc.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_scc.c
+++ linux-2.6/drivers/ata/pata_scc.c
@@ -903,8 +903,7 @@ static void scc_postreset(struct ata_lin
 	}
 
 	/* set up device control */
-	if (ap->ioaddr.ctl_addr)
-		out_be32(ap->ioaddr.ctl_addr, ap->ctl);
+	out_be32(ap->ioaddr.ctl_addr, ap->ctl);
 
 	DPRINTK("EXIT\n");
 }
