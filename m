From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH: ALI15x3, 200GB HD, dma broken, no_lba48_dma
Date: Thu, 10 Mar 2005 17:30:57 +0100
Message-ID: <58cb370e0503100830533f54b9@mail.gmail.com>
References: <Pine.LNX.4.60.0503042332240.1782@thelonious.dnsalias.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.200]:13082 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262718AbVCJQbF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Mar 2005 11:31:05 -0500
Received: by wproxy.gmail.com with SMTP id 68so816058wra
        for <linux-ide@vger.kernel.org>; Thu, 10 Mar 2005 08:30:57 -0800 (PST)
In-Reply-To: <Pine.LNX.4.60.0503042332240.1782@thelonious.dnsalias.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bram Verweij <bram.verweij@wanadoo.nl>
Cc: linux-ide@vger.kernel.org

good catch, I overlooked lba48 flag when introducing no_lba48_dma

I slightly modified your patch:

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-03-10 16:07:50 +01:00
+++ b/drivers/ide/ide-disk.c	2005-03-10 16:07:50 +01:00
@@ -168,6 +168,8 @@
 	if (hwif->no_lba48_dma && lba48 && dma) {
 		if (block + rq->nr_sectors > 1ULL << 28)
 			dma = 0;
+		else
+			lba48 = 0;
 	}
 
 	if (!dma) {
@@ -181,7 +183,7 @@
 	/* FIXME: SELECT_MASK(drive, 0) ? */
 
 	if (drive->select.b.lba) {
-		if (drive->addressing == 1) {
+		if (lba48) {
 			task_ioreg_t tasklets[10];
 
 			pr_debug("%s: LBA=0x%012llx\n", drive->name, block);

and applied it, thanks

Bartlomiej
