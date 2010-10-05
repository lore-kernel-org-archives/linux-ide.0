From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_sil680: make sil680_sff_exec_command() 'static'
Date: Tue, 5 Oct 2010 20:31:47 +0400
Message-ID: <201010052031.48164.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:36245 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751429Ab0JEQc3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2010 12:32:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

... since, of course, it's not used outside this driver.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_sil680.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/pata_sil680.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sil680.c
+++ linux-2.6/drivers/ata/pata_sil680.c
@@ -202,8 +202,8 @@ static void sil680_set_dmamode(struct at
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void sil680_sff_exec_command(struct ata_port *ap,
-					const struct ata_taskfile *tf)
+static void sil680_sff_exec_command(struct ata_port *ap,
+				    const struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 	iowrite8(tf->command, ap->ioaddr.command_addr);
