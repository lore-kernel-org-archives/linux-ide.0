From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
Date: Sun, 16 May 2004 23:30:35 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405162330.35547.bzolnier@elka.pw.edu.pl>
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <200405162220.23971.bzolnier@elka.pw.edu.pl> <40A7D9E6.1090900@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26616 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263641AbUEPV31
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 17:29:27 -0400
In-Reply-To: <40A7D9E6.1090900@keyaccess.nl>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>, Jens Axboe <axboe@suse.de>

On Sunday 16 of May 2004 23:15, Rene Herman wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 16 of May 2004 21:58, Alan Cox wrote:
> >>On Fri, May 14, 2004 at 01:58:58PM +0200, Rene Herman wrote:
> >>>Have again attached a 'rollup' patch against vanilla 2.6.6, including
> >>>this, Andrew's SYSTEM_SHUTDOWN split and the quick "don't switch of
> >>>spindle if rebooting" hack. Again, just in case anyone finds it useful.
> >>
> >>This reintroduces corruption on my thinkpad 600.
> >
> > [ this corruption was fixed by kernel 2.6.6 ]
> >
> > Please see if reverting changes to ide_device_shutdown() helps.
>
> Bart, could something like:
>
> if (system_state == SYSTEM_RESTART) {
> 	ide_cache_flush_p(drive)
> 	return;
> }
>
> (as opposed to just the return in that patch and -mm3) possibly help? I

Yep, this may fix it.

> sort of expect that ide_cache_flush_p() is already called further on up?
>
> Alan, if you know, that drive fails ide_id_has_flush_cache()?
>
> Note, very aware I don't know what the fuck I'm doing here (and equally
> aware I don't _want_ to be here :-) Having the drive spin down on each

hehe

> reboot is totally unacceptable though. Not only does spinning up again
> take significant time and noise, it's also actively bad for the drive.
>
> If there's no sane way to fix this, an explicit blacklist for drives
> that really need to be shutdown? Eew.
>
> Rene.

