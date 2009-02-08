From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] libata-sff: fix 32-bit PIO regression
Date: Sun, 8 Feb 2009 23:53:07 +0400
Message-ID: <200902082253.07438.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:11435 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753286AbZBHTwo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Feb 2009 14:52:44 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rjw@sisk.pl

Commit 871af1210f13966ab911ed2166e4ab2ce775b99d (libata: Add 32bit PIO support)
caused all kind of errors on the ATAPI devices, so it's been empirically proven
that one shouldn't read/write an extra data word when a device isn't expecting
it already. "Don't do it then"; however still taking a chance to use 32-bit I/O
one last  time when there are exactly 3 trailing bytes.  Oh, and stop pointless
swapping bytes to and fro as well by using io*_rep() which shouldn't byte-swap.

This should fix the kernel.org bug #12609.

---
This is hopefully better replacement for Hugh Dickins most recent patch
(http://marc.info/?l=linux-ide&m=123352294619281)...

 drivers/ata/libata-sff.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/ata/libata-sff.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-sff.c
+++ linux-2.6/drivers/ata/libata-sff.c
@@ -773,18 +773,27 @@ unsigned int ata_sff_data_xfer32(struct 
 	else
 		iowrite32_rep(data_addr, buf, words);
 
+	/* Transfer trailing bytes, if any */
 	if (unlikely(slop)) {
-		__le32 pad;
+		unsigned char pad[4];
+
+		/* Point buf to the tail of buffer */
+		buf += buflen - slop;
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
 

