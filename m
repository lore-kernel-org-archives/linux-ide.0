From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/8] ide-cd: first conversion batch
Date: Mon, 29 Dec 2008 19:57:39 +0100
Message-ID: <200812291957.39757.bzolnier@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com> <200812212005.56973.bzolnier@gmail.com> <20081226134556.GA23503@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:7223 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbYL2TCM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:02:12 -0500
In-Reply-To: <20081226134556.GA23503@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 26 December 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> On Sun, Dec 21, 2008 at 08:05:56PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> [.. ]
> > > don't do cdrom_decode_status for DRQ_INTERRUPT devices but this is
> > > probably not that relevant anymore since we busy-wait for DRQ to get set
> > > through ide_wait_stat, as we talked about it before - it being a bugfix for
> > > all atapi devices. If there's still interest for that (and I think it
> > 
> > Yes, this change is OK but for bisectability reasons it would be better
> > to do it in pre-patch (which would fix ide-cd.c accordingly).
> > 
> > [ The other changes in functionality are small and acceptable for this
> >   patch (i.e. ide_wait_stat() prints error message now) except the change
> >   of the ordering between ->dma_start and ->output_data calls -- which
> >   also seems to deserve patch on its own. ]
> 
> sorry for the delay but you know how it is, Christmas and all. Anyway,
> here are the patches attached as you requested, just in time for the
> merge window.

np, I was busy with Christmas-fu myself...

I applied all three patches but I want them to see some time in linux-next
before push to mainline (just-in-case, they should make it into 2.6.29).

Thanks,
Bart
