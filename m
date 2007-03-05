From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATA] Failed to set xfermode on LITE-ON LTR-48246S
Date: Mon, 05 Mar 2007 13:10:10 +0900
Message-ID: <45EB9822.40300@gmail.com>
References: <Pine.LNX.4.64.0702041057090.8424@woody.linux-foundation.org> <20070227135838.GA4328@titan.lahn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020905040601020300000706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:47396 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbXCEEKN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 23:10:13 -0500
Received: by py-out-1112.google.com with SMTP id a29so790280pyi
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 20:10:12 -0800 (PST)
In-Reply-To: <20070227135838.GA4328@titan.lahn.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020905040601020300000706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philipp Matthias Hahn wrote:
> Hello!
> 
> As reported by John Williams and others like in
> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg03088.html
> I too have a problem with 2.6.20.1 using ata_piix not detecting the
> CD-ROM any more. Applying the patch from
> http://lkml.org/lkml/2007/2/12/24 did not help, but additionally
> applying
> http://readlist.com/lists/vger.kernel.org/linux-kernel/45/228948.html
> made it work. Here's the relevant extra debugging output:

* Did it work with previous kernels?

* Does applying the attached patch over unpatched 2.6.20.1 fix the problem?

-- 
tejun

--------------020905040601020300000706
Content-Type: text/x-patch;
 name="ata_piix-polling-xfer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ata_piix-polling-xfer.patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index dc42ba1..78e6ac5 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -105,8 +105,10 @@ enum {
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 
-	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
-	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
+	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS |
+				  ATA_FLAG_SETXFER_POLLING,
+	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_SETXFER_POLLING,
 
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.

--------------020905040601020300000706--
