From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Overagressive failing of disk reads, both LIBATA and IDE
Date: Sun, 22 Mar 2009 11:15:47 +0900
Message-ID: <B102BBC50D804F2AB32D6519849EF6F6@DIAMOND8600>
References: <F79C774361EF45A6A68BC08F8621E406@DIAMOND8600> <49C30E67.4060702@rtr.ca> <1237645333.4600.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp01.mail.tnz.yahoo.co.jp ([203.216.246.64]:32031 "HELO
	smtp01.mail.tnz.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752331AbZCVCQB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Mar 2009 22:16:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Mark Lord <liml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

James Bottomley wrote:
> On Thu, 2009-03-19 at 23:32 -0400, Mark Lord wrote:
>> Norman Diamond wrote:
>>> For months I was wondering how a disk could do this:
>>> dd if=/dev/hda of=/dev/null bs=512 skip=551540 count=4  # succeeds
>>> dd if=/dev/hda of=/dev/null bs=512 skip=551544 count=4  # succeeds
>>> dd if=/dev/hda of=/dev/null bs=512 skip=551540 count=8  # fails
>
> This basically means the drive doesn't report where in the requested
> transfer the error occurred.  If we have that information, we'd return all
> sectors up to that LBA as OK and all at or beyond as -EIO, so the
> readahead wouldn't matter.

That's exactly what my submission suggested Linux should do, because that's
exactly what Linux isn't doing.  The defective sector number is 551562.
Linux makes varying decisions on how much to read ahead, and when its
readahead includes the defective sector Linux doesn't do what you and I want
it to do.

The way I discovered the actual defective sector number is that one time
last week I noticed it in dmesg output.  After noticing it, investigation
became a lot easier.  I don't remember if I noticed it for hda (old IDE) or
sda (LIBATA) but either way the drive put the defective sector number in its
error report.  When readahead was long enough to reach sector 551562 the
drive told the PC.

Regarding other threads of this discussion, I/Os are not being merged with 
other processes.  I'm running either Slax or Knoppix from a live CD, and the 
only one accessing the hard drive is me.

In cases where Slax or Knoppix includes a sufficiently recent hdparm, I 
could attempt reads of individual sectors.  551561 is OK.  551563 is OK. 
551562 has an uncorrectable media error.  I had mentioned that the drive has 
egregiously bad firmware (which doesn't excuse Linux).  That includes an 
effort to relocate the sector by using hdparm to write sector 551562, 
whereupon Hitachi drives me crazy.  The drive reports success but subsequent 
reads still fail. 

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
