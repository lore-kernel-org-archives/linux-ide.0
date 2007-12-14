From: akpm@linux-foundation.org
Subject: [patch 6/9] libata-set-proper-ata-udma-mode-for-bf548-according-to-system-clock-checkpatch-fixes
Date: Thu, 13 Dec 2007 16:01:41 -0800
Message-ID: <200712140001.lBE01gGH025441@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48390 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754391AbXLNABy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 19:01:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, htejun@gmail.com, sonic.adi@gmail.com, sonic.zhang@analog.com

From: Andrew Morton <akpm@linux-foundation.org>

WARNING: line over 80 characters
#36: FILE: drivers/ata/pata_bf54x.c:1512:
+	while (bfin_port_info[board_idx].udma_mask>0 && udma_fsclk[udma_mode] > fsclk) {

ERROR: need spaces around that '>' (ctx:VxV)
#36: FILE: drivers/ata/pata_bf54x.c:1512:
+	while (bfin_port_info[board_idx].udma_mask>0 && udma_fsclk[udma_mode] > fsclk) {
 	                                          ^

total: 1 errors, 1 warnings, 19 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Please run checkpatch prior to sending patches

Cc: Jeff Garzik <jeff@garzik.org>
Cc: Sonic Zhang <sonic.zhang@analog.com>
Cc: Tejun Heo <htejun@gmail.com>
Cc: sonic zhang <sonic.adi@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_bf54x.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/ata/pata_bf54x.c~libata-set-proper-ata-udma-mode-for-bf548-according-to-system-clock-checkpatch-fixes drivers/ata/pata_bf54x.c
--- a/drivers/ata/pata_bf54x.c~libata-set-proper-ata-udma-mode-for-bf548-according-to-system-clock-checkpatch-fixes
+++ a/drivers/ata/pata_bf54x.c
@@ -1509,7 +1509,8 @@ static int __devinit bfin_atapi_probe(st
 	if (res == NULL)
 		return -EINVAL;
 
-	while (bfin_port_info[board_idx].udma_mask>0 && udma_fsclk[udma_mode] > fsclk) {
+	while (bfin_port_info[board_idx].udma_mask > 0 &&
+			udma_fsclk[udma_mode] > fsclk) {
 		udma_mode--;
 		bfin_port_info[board_idx].udma_mask >>= 1;
 	}
_
