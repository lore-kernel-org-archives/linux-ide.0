From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] libata-sff: fix 32-bit PIO ATAPI regression
Date: Sun, 15 Feb 2009 23:24:24 +0400
Message-ID: <200902152224.25144.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:26167 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751262AbZBOTYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 14:24:08 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rjw@sisk.pl, akpm@linux-foundation.org

Commit 871af1210f13966ab911ed2166e4ab2ce775b99d (libata: Add 32bit PIO support)
has caused all kinds of errors on the ATAPI devices, so it has been empirically
proven that one shouldn't try to read/write an extra data word when a device is
not expecting it already. "Don't do it then"; however, still use a chance to do
32-bit read/write one last time when there are exactly 3 trailing bytes.

Oh, and stop pointlessly swapping the bytes to and fro on big-endian machines
by using io*_rep() accessors which shouldn't byte-swap.

This patch should fix the kernel.org bug #12609.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Added the comments and signoff.
The patch is against the recent Linus' tree.
It's a hopefully better replacement for Hugh Dickins most recent patch
(http://marc.info/?l=linux-ide&m=123352294619281)...

 drivers/ata/libata-sff.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/ata/libata-sff.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-sff.c
+++ linux-2.6/drivers/ata/libata-sff.c
@@ -773,18 +773,32 @@ unsigned int ata_sff_data_xfer32(struct 
 	else
 		iowrite32_rep(data_addr, buf, words);
 
+	/* Transfer trailing bytes, if any */
 	if (unlikely(slop)) {
-		__le32 pad;
+		unsigned char pad[4];
+
+		/* Point buf to the tail of buffer */
+		buf += buflen - slop;
+
+		/*
+		 * Use io*_rep() accessors here as well to avoid pointlessly
+		 * swapping bytes to and fro on the big endian machines...
+		 */
 		if (rw == READ) {
-			pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
-			memcpy(buf + buflen - slop, &pad, slop);
+			if (slop < 3)
+				ioread16_rep(data_addr, pad, 1);
+			else
+				ioread32_rep(data_addr, pad, 1);
+			memcpy(buf, pad, slop);
 		} else {
-			memcpy(&pad, buf + buflen - slop, slop);
-			iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
+			memcpy(pad, buf, slop);
+			if (slop < 3)
+				iowrite16_rep(data_addr, pad, 1);
+			else
+				iowrite32_rep(data_addr, pad, 1);
 		}
-		words++;
 	}
-	return words << 2;
+	return (buflen + 1) & ~1;
 }
 EXPORT_SYMBOL_GPL(ata_sff_data_xfer32);
 

