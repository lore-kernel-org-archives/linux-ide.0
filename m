From: akpm@linux-foundation.org
Subject: [patch 1/1] drivers/ata/pata_it821x.c: fix warning
Date: Wed, 20 Aug 2008 16:48:52 -0700
Message-ID: <200808202348.m7KNmqxR005825@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38829 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755951AbYHTXtq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Aug 2008 19:49:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk

From: Andrew Morton <akpm@linux-foundation.org>

drivers/ata/pata_it821x.c: In function 'it821x_port_start':
drivers/ata/pata_it821x.c:609: warning: 'mtype' may be used uninitialized in this function

Pretty horrid fix, but so's a warning..

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_it821x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/pata_it821x.c~drivers-ata-pata_it821xc-fix-warning drivers/ata/pata_it821x.c
--- a/drivers/ata/pata_it821x.c~drivers-ata-pata_it821xc-fix-warning
+++ a/drivers/ata/pata_it821x.c
@@ -619,9 +619,9 @@ static void it821x_display_disk(int n, u
 
 	ata_id_c_string((u16 *)buf, id, 0, 41); 
 
+	mtype = "UDMA";
 	if (buf[51]) {
 		mode = ffs(buf[51]);
-		mtype = "UDMA";
 	} else if (buf[49]) {
 		mode = ffs(buf[49]);
 		mtype = "MWDMA";
_
