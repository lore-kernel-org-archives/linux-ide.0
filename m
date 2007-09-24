From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/9] dtc2278: set ->pio_mask also for the second port
Date: Mon, 24 Sep 2007 22:39:20 +0200
Message-ID: <200709242239.20621.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29604 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbXIXUqM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485932nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/dtc2278.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -130,6 +130,7 @@ static int __init dtc2278_probe(void)
 
 	mate->serialized = 1;
 	mate->chipset = ide_dtc2278;
+	mate->pio_mask = ATA_PIO4;
 	mate->drives[0].no_unmask = 1;
 	mate->drives[1].no_unmask = 1;
 	mate->mate = hwif;
