From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: 17 May 2004 15:06:05 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084827965.3211.10.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:13216 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261862AbUEQVGX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 17:06:23 -0400
In-Reply-To: <40A90D96.2040002@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> Re: [PATCH] libata-core when not ata_id_use_dmadir despite yes SiliconI
> From: Jeff Garzik <jgarzik () pobox ! com>
> Date: 2004-05-15 16:39:57
> ...
> > Do you know of some way to detect SI 3611CT80 1.4?
>
> Not right now.
>
> I need to see the full IDENTIFY PACKET DEVICE
> data to discover a way...  (and I need to
> write some code before libata dumps the full
> identify-device page)
>
> Other bridges add an identifying string to the
> -end- of the ATA device's model name, maybe
> SiI does too.

Sorry to say,

My op xA1 "IDENTIFY" bytes appear nybble-for-nybble identical, no matter
if sampled via the SATA ATAPI of Si 3611CT80 r1.4 or if sampled via the
original PATA ATAPI.

I quote:

$ cat /var/log/messages | grep ata_dump_id >sata
$ emacs sata
$ # reboot to disconnect bridge from host and from device
$ sudo cat /proc/ide/hdc/identify >pata
$ diff sata pata
12c12
< 203f 0000 0000 0000 0000 404f 0000 0000
---
> 043f 0000 0000 0000 0000 604f 0000 0000
$ #88 . 89 . 90 . 91 . 92 . 93 . 94 . 95 are the "word" indices
$

At first glance, you might think you just saw the upper halves of
"word"s 88 and 93 change, after calculating 88 = 8 * (line 12 - 1)). 
But all that's actually changed in "word" 88 is the initially "selected"
UDMA "mode".  x20XX = UDMA 5, x04XX = UDMA 2.  And all that's actually
changed in "word" 93 is the CBLDID- detect of mask x2000 i.e. you caught
me using a 40-pin PATA cable in place of an 80-pin PATA cable.

Bottom line, all the bits of the "F" set ("F" = "Fixed" = change no more
often than discs change) have not changed.

I presume by intent as yet we don't mean to appear among the devices of
/proc/ide/.  I checked all /proc and all /sys, saw our SATA host appear
there voluminously, but nothing that my newbie eye recognised as device
data.

Pat LaVarre

P.S. As I wrote the trivial experimental patch below to gather op xA1
"IDENTIFY" data, I was painfully reminded that DPRINTK flushes per
invocation, not only at EOL, and that /var/log/messages omits duplicate
lines.

diff -Nurp linux-2.6.6-bk4/drivers/scsi/libata-core.c linux-2.6.6-bk4-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk4/drivers/scsi/libata-core.c	2004-05-17 12:50:15.000000000 -0600
+++ linux-2.6.6-bk4-pel/drivers/scsi/libata-core.c	2004-05-17 14:18:37.000000000 -0600
@@ -974,6 +974,24 @@ static inline void ata_dump_id(struct at
 		"93==0x%04x\n",
 		dev->id[88],
 		dev->id[93]);
+
+	/* all "word"s, as in lk 2.4 `sudo cat /proc/ide/hd$v/identify` */
+	do {
+		int ix;
+		for (ix = 0; ix < 0x100; ix += 8) {
+			DPRINTK("0x%03X: "
+				"%04x %04x %04x %04x %04x %04x %04x %04x\n",
+				ix * 2,
+				dev->id[ix+0],
+				dev->id[ix+1],
+				dev->id[ix+2],
+				dev->id[ix+3],
+				dev->id[ix+4],
+				dev->id[ix+5],
+				dev->id[ix+6],
+				dev->id[ix+7]);
+		}
+	} while (0);
 }
 
 /**


