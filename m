From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: New CD/DVD drive - 80-wire cable detection failure
Date: Wed, 24 Oct 2007 01:33:08 +0200
Message-ID: <200710240133.08425.bzolnier@gmail.com>
References: <200710181832.42906.nick@ukfsn.org> <200710201037.31283.nick@ukfsn.org> <200710201322.57178.nick@ukfsn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:58421 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbXJWX1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 19:27:43 -0400
Received: by nf-out-0910.google.com with SMTP id g13so15405nfb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 16:27:41 -0700 (PDT)
In-Reply-To: <200710201322.57178.nick@ukfsn.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nick@ukfsn.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Saturday 20 October 2007, Nick Warne wrote:
> Hi all,
> 
> SOLVED!
> 
> On Saturday 20 October 2007 10:37:31 Nick Warne wrote:
> > On Friday 19 October 2007 23:28:21 Bartlomiej Zolnierkiewicz wrote:
> > > On Saturday 20 October 2007, Nick Warne wrote:
> > > > On Friday 19 October 2007 22:44:27 Bartlomiej Zolnierkiewicz wrote:
> > > >
> > > > hdparm -I
> > >
> > > It should have been hdparm --Istdout (sorry, once again).
> >
> > hdparm --Istdout /dev/hdd

Thanks, the identify block looks quite "interesting".

85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 5342
3030 2020 2020 5453 5354 636f 7270 2043
4444 5644 5720 5348 2d53 3230 324a 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0b00 0000 0200 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0007
0003 0078 0078 017f 0078 0000 0000 0000
0000 00f8 0210 0000 0000 0000 0000 0000
00f8 0210 0210 0000 0000 0000 0000 0000
041f 0000 8005 3200 005b 2000 0000 0000
[...]

word 93 is 0x2000

bit 0x4000 is not set despite the fact that ATA spec (>= ATA-5) requires
it to be set (the device claims ATA/ATAPI-3/4/5/6/7 compatiblity, a bit too
optimistic since it looks like the firmware was based on ATA/ATAPI-4 spec)

bit 0x2000 is set which would indicate that the 80-wires cable is
correctly detected by the device

=> the device/firmware pair is a good candidate for ivb_list[]

There seems to be a new firmware (SB01) for this device:
http://www.samsungodd.com/Lib/popup/Download.asp?path=FW_FWDownload&fname=200710011656260232_SH-S202J_%20SB01.exe

It would be useful to know whether it has the same problem...

> I built a new kernel today 2.6.23.1, and looked very closely at kernel 
> options.
> 
> Setting:
> 
> CONFIG_IDEDMA_IVB
> 
> did the trick!

We want kernel to automatically detect problematic hardware and apply
needed workarounds, _without_ the need for manual user intervention.

[ + CONFIG_IDEDMA_IVB is gone 2.6.24 (but "idex=ata66" is still there) ]

> hdd: TSSTcorp CDDVDW SH-S202J, ATAPI CD/DVD-ROM drive
> hdd: selected mode 0x44
> hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(66)
> 
> Thank you all for looking at this non-issue.  Sorry for the noise!!!

Definitely not the noise, quite the contrary (valuable input). :)

Could you try this patch?

[PATCH] ide: add SH-S202J to ivb_list[]

>From the report by Nick Warne.

Cc: Nick Warne <nick@ukfsn.org>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    3 +++
 1 file changed, 3 insertions(+)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -582,9 +582,12 @@ EXPORT_SYMBOL_GPL(ide_in_drive_list);
 /*
  * Early UDMA66 devices don't set bit14 to 1, only bit13 is valid.
  * We list them here and depend on the device side cable detection for them.
+ *
+ * Some optical devices with the buggy firmwares have the same problem.
  */
 static const struct drive_list_entry ivb_list[] = {
 	{ "QUANTUM FIREBALLlct10 05"	, "A03.0900"	},
+	{ "TSSTcorp CDDVDW SH-S202J"	, "SB00"	},
 	{ NULL				, NULL		}
 };
 
