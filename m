From: Catalin BOIE <util@deuroconsult.ro>
Subject: Re: [PATCH] Fix IDE bus reset and DMA disable when reading blank
 DVD-R
Date: Mon, 5 Jan 2004 12:32:48 +0200 (EET)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0401051231420.19869@hosting.rdsbv.ro>
References: <3FDDBACE.5060300@jburgess.uklinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webhosting.rdsbv.ro ([213.157.185.164]:46035 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S263775AbUAEKc5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2004 05:32:57 -0500
In-Reply-To: <3FDDBACE.5060300@jburgess.uklinux.net>
List-Id: linux-ide@vger.kernel.org
To: Jon Burgess <mplayer@jburgess.uklinux.net>
Cc: linux-ide@vger.kernel.org

On Mon, 15 Dec 2003, Jon Burgess wrote:

> I've had a problems burning DVD's in linux-2.6.0-test11 using the ide-cd
> driver.
>
> The DVD writing tool, growisofs, attempts to read the blank disk before
> it writes the new data. The drive responds to the read request on blank
> DVD-R's by returning a "blank media" error. The kernel doesn't have any
> special case handling for this sense value and retries the request a
> couple of times, then gives up and does a bus reset and disables DMA to
> the device. Here is the log:
>
> hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
> hdd: cdrom_decode_status: error=0x80LastFailedSense 0x08
> hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
> hdd: cdrom_decode_status: error=0x80LastFailedSense 0x08
> hdd: DMA disabled
> hdd: ide_intr: huh? expected NULL handler on exit
> hdd: ATAPI reset complete

Same problem here.
When I start writing a dvd, the kernel disables DMA. I can, immediately,
enable DMA and all comes back to normal.
So I wish this patch merged.
Thanks!

>
> The same thing occurs if I simply try "mount /dev/dvd" on a DVD-R blank.
>
> The sense key value of 8 isn't listed in ide-cd.h, but it is listed in
> scsi.h as a "BLANK_CHECK" error.
>
> I took a look at the code in ide-cd.c and developed the patch attached.
> This handles treats this error condition as a reason to abort the
> request. This behaviour is the same as when I try to do the same thing
> on another drive with a CD-R blank.
>
> With this patch I just get a single "blank media" error, but no bus
> reset and DMA is left enabled. This makes DVD writing with ide-cd work
> well for me.
>
> It looks like the same fix might be desired for 2.4 as well, although is
> perhaps not so important since scsi-ide is normally used instead.
>
> Does the patch look correct?
> Should it be applied to 2.6?
>
> Please CC me on any response.
>
> Thanks,
>     Jon
>
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
