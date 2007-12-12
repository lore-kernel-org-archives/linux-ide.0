From: Will Trives <will@trivescon.com.au>
Subject: Re: [PATCH #upstream-fixes]
	libata:	update	atapi_eh_request_sense() such that lbam/lbah contains buffer
	size
Date: Wed, 12 Dec 2007 19:50:25 +1100
Message-ID: <1197449425.3467.16.camel@Athas>
References: <475F51AE.1010305@gmail.com> <1197446739.3467.4.camel@Athas>
	 <475F98C9.6080804@gmail.com> <1197447366.3467.10.camel@Athas>
	 <475F9E20.4000800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail12.tpgi.com.au ([203.12.160.162]:55135 "EHLO
	mail12.tpgi.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbXLLI42 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 03:56:28 -0500
In-Reply-To: <475F9E20.4000800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

I'm no expert but it might have something to do with the disc supporting
that incremental stuff, so you don't need to blank the disc the
traditional way.

On Wed, 2007-12-12 at 17:38 +0900, Tejun Heo wrote:
> Hello,
> 
> Will Trives wrote:
> >> This drive or media does not support the 'BLANK media' command
> >>> wodim: Cannot blank disk, aborting.
> >>> wodim: Some drives do not support all blank types.
> >>> wodim: Try again with wodim blank=all.
> >> wodim suggests "blank=all", does it work?
> >>
> > Nope same thing happens.
> > 
> > "dvd+rw-format /dev/sr0 -force"  Works ok though.
> 
> This looks like a wodim or drive/media problem and for some reason wodim
> thinks that the media can't be blanked.  Hmmm.. why do you need -force
> to dvd+rw-format?  What happens if you don't use -force?
> 

