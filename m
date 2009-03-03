From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Tue, 3 Mar 2009 20:44:49 +0900
Message-ID: <A1CD73CEEE9F4B0C8020D11EA243D460@DIAMOND8600>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp08.mail.tnz.yahoo.co.jp ([203.216.226.136]:34888 "HELO
	smtp08.mail.tnz.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752617AbZCCMnZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Mar 2009 07:43:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mark Lord <liml@rtr.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, Robert Hancock <hancockrwd@gmail.com>

I (Norman Diamond) wrote:

> Well, it turns out that 2.6.24.3 doesn't work either.  Sometimes
> HDIO_DRIVE_TASKFILE doesn't just hang a process without a dump, sometimes
> it hangs other stuff too.  This time I could still switch VT's (after
> booting Slax to text mode) but couldn't type the name "root" to log in.

Sorry, that one was my fault.

> So does this mean that some part of HDIO_DRIVE_TASKFILE doesn't want to
> believe the flags I set to use or not use the HOB registers?

No, that problem doesn't occur (in 2.6.24.3 anyway).

WRITE_DMA doesn't work very well when DMA isn't enabled on the drive.  I
wonder why there was such a widespread hang but not complete hang.  I can
imagine the driver not checking because the caller is responsible for the
contents of the taskfile, but I would have expected the drive to return an
error and the driver to push the error back up, instead of hanging.  Anyway 
it was my fault.

This unfortunate case was on a Dell Latitude D820 with an Intel ICH7M
chipset.  The hard drive is SATA and I don't know the interface of the DVD
drive, but Dell's BIOS sets the ICH7M to present a PATA interface with no
option to change it.  The hard drive gets /dev/hda, the DVD drive gets
/dev/hdc, DMA is disabled, and hdparm can't enable DMA on the hard drive.
Google showed me lots of complaints from people who couldn't enable DMA on
the DVD drive but it looks like I'm the only one who couldn't enable DMA on
the hard drive.  Putting hda=noprobe in the boot command line let the hard
drive become /dev/sda and speed up by a factor of 40.

I understand libata is the biggest answer.  I hope it really handles
everything but that's going to take a lot of testing to confirm.

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
