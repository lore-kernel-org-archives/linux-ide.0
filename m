From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-generic: add missing hwif->chipset setup
Date: Sat, 31 May 2008 15:43:30 +0200
Message-ID: <200805311543.30501.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:63261 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbYEaNtE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 May 2008 09:49:04 -0400
Received: by mu-out-0910.google.com with SMTP id w8so511644mue.1
        for <linux-ide@vger.kernel.org>; Sat, 31 May 2008 06:49:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, John Keller <jpk@sgi.com>, Dmitri Vorobiev <dmitri.vorobiev@gmail.com>, Mel Gorman <mel@csn.ul.ie>

hwif->chipset need to be set properly or ide-generic driver will break once
we make a final step in fixing host drivers' dependence on ide_hwifs[].

Problem was catched early thanks to IDE tree exposure in -mm / -next trees
and reported by people listed people (thank you guys!).

Reported-by: "John Keller" <jpk@sgi.com>
Reported-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Reported-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
With this patch applied we can bring "ide: fix hwif-s initialization"
and "ide: make ide_hwifs[] static" patches back into IDE tree! :)

 drivers/ide/ide-generic.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -125,6 +125,7 @@ static int __init ide_generic_init(void)
 			memset(&hw, 0, sizeof(hw));
 			ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
 			hw.irq = ide_default_irq(io_addr);
+			hw.chipset = ide_generic;
 			ide_init_port_hw(hwif, &hw);
 
 			idx[i] = i;
