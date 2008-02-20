From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-generic: Fix no initalization of idx in some case
Date: Wed, 20 Feb 2008 15:35:18 +0100
Message-ID: <200802201535.18288.bzolnier@gmail.com>
References: <1203515735.26116.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:15179 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbYBTOXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 09:23:11 -0500
Received: by nf-out-0910.google.com with SMTP id g13so804634nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 06:23:10 -0800 (PST)
In-Reply-To: <1203515735.26116.4.camel@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johann Felix Soden <johfel@gmx.de>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-ide@vger.kernel.org

On Wednesday 20 February 2008, Johann Felix Soden wrote:
> From: Johann Felix Soden <johfel@users.sourceforge.net>
> 
> If the slot is already occupied, there should be written 0xff to idx[i].
> In the ongoing code and in this case there are no writings to idx[i], so
> garbage stays in idx. The kernel get into a endless loop printing:
> 
> : I/O resource 0x0-0x0 not free.
> Trying to free nonexistent resource <0000000000000000-0000000000000000>
> Trying to free nonexistent resource <0000000000000000-0000000000000000>
> 
> This patch solves http://article.gmane.org/gmane.linux.ide/28810 .
> 
> Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
> CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Thanks!  I integrated it with the original patch to preserve bisectability:

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-generic: use ide_find_port() (take 3)

There should be no functional changes caused by this patch.

v2:
* Fix comment (noticed by Sergei Shtylyov).

v3:
* Fix no initalization of idx in some case. (Johann Felix Soden)

Cc: Johann Felix Soden <johfel@users.sourceforge.net>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -90,18 +90,29 @@ static int __init ide_generic_init(void)
 	int i;
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		ide_hwif_t *hwif = &ide_hwifs[i];
+		ide_hwif_t *hwif;
 		unsigned long io_addr = ide_default_io_base(i);
 		hw_regs_t hw;
 
-		if (hwif->chipset == ide_unknown && io_addr) {
-			u8 oldnoprobe = hwif->noprobe;
+		if (io_addr) {
+			u8 oldnoprobe;
+
+			/*
+			 * Skip probing if the corresponding
+			 * slot is already occupied.
+			 */
+			hwif = ide_find_port();
+			if (hwif == NULL || hwif->index != i) {
+				idx[i] = 0xff;
+				continue;
+			}
 
 			memset(&hw, 0, sizeof(hw));
 			ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
 			hw.irq = ide_default_irq(io_addr);
-			ide_init_port_hw(hwif, &hw);
 
+			oldnoprobe = hwif->noprobe;
+			ide_init_port_hw(hwif, &hw);
 			hwif->noprobe = oldnoprobe;
 
 			idx[i] = i;
