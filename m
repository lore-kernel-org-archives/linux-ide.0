From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Mon, 2 Mar 2009 20:43:33 +0900
Message-ID: <F7E647DEED424BF1BAE2924A6D8DE755@DIAMOND8600>
References: <20090302002434.62707.qmail@web4109.mail.ogk.yahoo.co.jp> <49AB468D.6030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp07.mail.tnz.yahoo.co.jp ([203.216.226.135]:21450 "HELO
	smtp07.mail.tnz.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758002AbZCBLnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 06:43:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mark Lord <liml@rtr.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, Robert Hancock <hancockrwd@gmail.com>

Robert Hancock wrote:
> Norman Diamond wrote:
>> In the third VT, dmesg showed this error message:
>> hda-intel: Invalid position buffer, using LPIB read method instead.
>>
>> Google found several threads where people are blaming this error message 
>> on audio drivers or wireless LAN drivers.  Some people are saying it was 
>> fixed somewhere earlier than 2.6.28.4.  2.6.28.4 tells me it's not fixed, 
>> and the timing sure doesn't look like audio or wireless LAN.
>
> I'm guessing that's a symptom and not a cause, if the IDE driver is 
> causing some kind of partial lockup then that could be messing with the 
> audio driver..
>
>> I'll try building a kernel without legacy IDE drivers, but I wonder which 
>> kernel version to try.
>
> Normally latest is best..

Yeah but "normally" doesn't help a lot with this problem.  I do plan to see 
if I can build a Slax CD with the latest kernel with a configuration to omit 
legacy IDE drivers, but meanwhile I'm still primarily using Slax 6.0.3 with 
kernel 2.6.24.3 because I could use Slax's tools to build it and it seemed 
to work.

Well, it turns out that 2.6.24.3 doesn't work either.  Sometimes 
HDIO_DRIVE_TASKFILE doesn't just hang a process without a dump, sometimes it 
hangs other stuff too.  This time I could still switch VT's (after booting 
Slax to text mode) but couldn't type the name "root" to log in.

So, why sometimes but not other times?  Here's some evidence.
(1)  A 40GB PATA hard drive supports LBA48, and is connected through a 
moderately old Intel controller which presents a PATA interface that 
supports LBA48, but I used an LBA28 WRITE_DMA to write 126 sectors starting 
at sector 0, and it worked perfectly.
(2)  A 250GB SATA hard drive supports LBA48, and is connected through a 
moderately new Intel controller which presents a PATA interface that 
supports LBA48, but I used an LBA28 WRITE_DMA to write 126 sectors starting 
at sector 0, and it hanged.
(3)  A 250GB SATA hard drive supports LBA48, and is connected through an 
Nvidia controller which presents a SATA interface ... oops, that means I 
used SG_IO instead of HDIO_DRIVE_TASKFILE, so there's no surprise that it 
worked.

So does this mean that some part of HDIO_DRIVE_TASKFILE doesn't want to 
believe the flags I set to use or not use the HOB registers?  If the total 
number of sectors on the drive is larger than 0x0fffffff then the driver 
wants me to use HOB registers even when lower sector numbers don't need 
them?  Notice that it doesn't seem to matter if the drive supports LBA48 or 
not.  It seems to matter if some other sectors, which aren't involved in 
this I/O, would need LBA48 when someone else accesses them.

I plan to experiment tomorrow, using LBA48 even when it shouldn't be 
necessary, to see if it avoids that hang. 

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
