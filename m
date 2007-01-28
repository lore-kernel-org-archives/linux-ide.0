From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_sil680: PIO1 taskfile transfers overclocking fix (repost)
Date: Sun, 28 Jan 2007 21:33:44 +0300
Message-ID: <200701282133.44760.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:16231 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752479AbXA1Sdu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 13:33:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Fix PIO mode 1 overclocked taskfile transfers -- probably a typo carried over
from drivers/ide/pci/siimage.c where I've found it by documentation check...

 drivers/ata/pata_sil680.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: linux-2.6/drivers/ata/pata_sil680.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sil680.c
+++ linux-2.6/drivers/ata/pata_sil680.c
@@ -135,7 +135,7 @@ static void sil680_error_handler(struct 
 static void sil680_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	static u16 speed_p[5] = { 0x328A, 0x2283, 0x1104, 0x10C3, 0x10C1 };
-	static u16 speed_t[5] = { 0x328A, 0x1281, 0x1281, 0x10C3, 0x10C1 };
+	static u16 speed_t[5] = { 0x328A, 0x2283, 0x1281, 0x10C3, 0x10C1 };
 
 	unsigned long tfaddr = sil680_selreg(ap, 0x02);
 	unsigned long addr = sil680_seldev(ap, adev, 0x04);

