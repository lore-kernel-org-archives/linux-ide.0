From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Linux Kernel 2.6.13-rc7 (WORKS) (2.6.13, DRQ/System CRASH)
Date: Mon, 5 Sep 2005 09:32:22 +0200
Message-ID: <58cb370e050905003270882298@mail.gmail.com>
References: <Pine.LNX.4.63.0508311328230.1945@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.195]:1599 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932271AbVIEHcX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Sep 2005 03:32:23 -0400
Received: by nproxy.gmail.com with SMTP id x37so309643nfc
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2005 00:32:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0508311328230.1945@p34>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, support@promise.com, linux-ide@vger.kernel.org, apiszcz@lucidpixels.com

On 8/31/05, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> All,
> 
> I am trying to get everyone together on this to hopefully solve a serious
> bug that I have seen on multiple machines with:
> 
> a) A Promise ATA/133 controller (ATA/100 works OK)
> b) Kernel 2.6.12 or 2.6.13 (2.6.13-rc7 appears to be OK)
> 
> The drive is a Seagate 7200.8 400GB 7200RPM 8MB cache disk.
> hde: ST3400832A, ATA DISK drive
> 
> With older kernels, if I *DO NOT ENABLE DMA* it does not crash.
> If I *ENABLE DMA* then proceed to do anything with the disk, it will
> FREEZE the box, no oops, etc, *FREEZE*.
> 
> hdparm -t /dev/hde
> mkfs.xfs -f /dev/hde1
> 
> Will freeze the box.
> 
> -------
> 
> Linux Kernel 2.6.13 final experiences the same problems as 2.6.12.5.
> 
> I have e-mailed the list quite a few times with this issue, I am surprised
> very few people run into it.
> 
> Here is the error in the logs:
> 
> Aug 31 11:30:25 p34 kernel: hde: dma_timer_expiry: dma status == 0x20
> Aug 31 11:30:25 p34 kernel: hde: DMA timeout retry
> Aug 31 11:30:25 p34 kernel: PDC202XX: Primary channel reset.
> Aug 31 11:30:25 p34 kernel: hde: timeout waiting for DMA
> Aug 31 11:30:25 p34 kernel: hde: status error: status=0x58 { DriveReady
> SeekComplete DataRequest }
> Aug 31 11:30:25 p34 kernel: hde: drive not ready for command
> Aug 31 11:30:25 p34 kernel: hde: status timeout: status=0xd0 { Busy }
> Aug 31 11:30:25 p34 kernel: PDC202XX: Primary channel reset.
> Aug 31 11:30:25 p34 kernel: hde: no DRQ after issuing MULTWRITE_EXT
> Aug 31 11:30:25 p34 kernel: ide2: reset: success
> 
> After this, the machine locks up with 2.6.13.
> 
> With 2.6.13-rc7, I have not seen this once.

Absolutely no IDE changes from -rc7 to 2.6.13 final
and I don't see anything suspicious in the patch.

You may try using git to track this regression
(but it looks like a bad drive for me).

Bartlomiej

> Can anyone offer any insight to why this is happening? I have a few
> machines with the ATA/133 controller and 400GB drives; therefore, I'd
> prefer to fix the problem rather than hooking up older, ATA/100 drives,
> just so I can run newer kernels...
