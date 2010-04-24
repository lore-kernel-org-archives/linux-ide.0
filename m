From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH resend 1/2] pata_scc: make scc_wait_after_reset() static
Date: Sat, 24 Apr 2010 20:29:45 +0400
Message-ID: <201004242029.45164.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47065 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752525Ab0DXQad (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Apr 2010 12:30:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

... since, of course, it's not used outside this driver.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree indeed now, the previously psted
one wasn't...

 drivers/ata/pata_scc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/pata_scc.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_scc.c
+++ linux-2.6/drivers/ata/pata_scc.c
@@ -501,8 +501,8 @@ static unsigned int scc_devchk (struct a
  *	Note: Original code is ata_sff_wait_after_reset
  */
 
-int scc_wait_after_reset(struct ata_link *link, unsigned int devmask,
-			 unsigned long deadline)
+static int scc_wait_after_reset(struct ata_link *link, unsigned int devmask,
+				unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_ioports *ioaddr = &ap->ioaddr;
