From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC/PATCH 0/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 23:32:53 +0100
Message-ID: <58cb370e050128143221c7cac8@mail.gmail.com>
References: <58cb370e0501281349543d0d14@mail.gmail.com>
	 <200501282215.j0SMFegK022818@falcon10.austin.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:24139 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262798AbVA1WdR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2005 17:33:17 -0500
Received: by wproxy.gmail.com with SMTP id 67so324449wri
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 14:33:17 -0800 (PST)
In-Reply-To: <200501282215.j0SMFegK022818@falcon10.austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>

On Fri, 28 Jan 2005 16:15:40 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> 
> On Fri, 28 Jan 2005 22:49:08 +0100, Bartlomiej Zolnierkiewicz wrote:
> >On Fri, 28 Jan 2005 15:43:52 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> >>
> >> On Fri, 28 Jan 2005 22:35:17 +0100, Bartlomiej Zolnierkiewicz wrote:
> >> >On Fri, 28 Jan 2005 15:06:22 -0600, Doug Maxey <dwm@maxeymade.com> wrote:
> >> >>
> >> >> On Fri, 28 Jan 2005 20:11:37 +0100, Bartlomiej Zolnierkiewicz wrote:
> >> >> >On Fri, 28 Jan 2005 12:16:01 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> >> >> >
> >> >> >We have too many config options already.
> >> >> >
> >> >> >Behavior should be simple:
> >> >> >* no cache flushes - wcache off by default
> >> >> >* cache flushes - wcache on by default
> >> >> >* inform user about the wcache status
> >> >> >* allow changing of wcache by user
> >> >>
> >> >> My interpretation of what you are saying here is the selection of
> >> >> "cache flush" drives the setting of wcache.  Are you saying that
> >> >> "barrier=off" on the boot line the currently (only and will remain)
> >> >> supported method controlling flushes?
> >> >
> >> >No, I am saying that cache flush is a property of disk not fs.
> >> >On the contrary barrier is a property of filesystem.
> >>
> >> Ok.  We are talking apples and oranges here.  The disk DOES have FLUSH CACHE,
> >> which is the main reason these drives work in the later kernels.  You can
> >> switch wcache back and forth, provided that the correct flushing is done.
> >>
> >> Write cache, on the otherhand, which is disabled on the drive by default,
> >> is not honored.
> >
> >What is the practical reason to honor it?
> 
> The datacenters/server folks that would be using these drives would
> expect them to remain as set.  I have to check, but unless something
> has changed very recently in the kernel, setting with hdparm does not
> "stick" in the sense that the command succeeds to the disk, but no change
> is made to the barrier.

It is not a problem for IDE driver (flushes become no-ops)
and this way you can later enable wcache and still use barries.

> here is the current scenario with a drive that can work with wcache off.
> - idedisk_setup() forces enabled wcache.
> - enabled wcache uses FLUSH.
> - hdparm -W0 disables cache without matching change to barriers.
> 
> - Setting "barrier=off" has the undesired side effect of not flushing
>   with wcache enabled on the drive.  Some people with certain servers are
>   _ssooo_ picky. :)

This is fs layer problem.
