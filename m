From: Jens Axboe <axboe@suse.de>
Subject: Re: [RFC/PATCH 0/7] enable honoring write cache setting of IDE drive
Date: Mon, 31 Jan 2005 09:35:37 +0100
Message-ID: <20050131083537.GB9446@suse.de>
References: <200501281816.j0SIG1mP021074@falcon10.austin.ibm.com> <58cb370e05012811112c3c0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:25054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261841AbVAaIfy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jan 2005 03:35:54 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e05012811112c3c0b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Doug Maxey <dwm@austin.ibm.com>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>

On Fri, Jan 28 2005, Bartlomiej Zolnierkiewicz wrote:
> On Fri, 28 Jan 2005 12:16:01 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> > Howdy!
> 
> Hi,
>  
> > Some IDE drives destined for use in server class or datacenter
> > machines will come with "write cache" disabled.  With the current
> > code, the setting of the drive is effectively ignored, and the cache
> > is always enabled if the drive has cache.
> > 
> > It is hard to define or enable certain behaviors that will keep
> > everyone happy, but hey, this is my (and a certain vendor's) take on
> > this.  If you are happy with the status quo, no behavior change.  If
> > the user desires to have write cache disabled by default (per the
> > drive), she can enable a more server friendly behavior.
> >
> > These patches are against BK5.  No attempt has been made to integrate
> > with Jens' latest "scsi/sata write barrier" patches, but will look
> > into that when the dust has settled for both.
> > 
> > With BLK_DEV_HDWC at the default of 0, the current driver behavior is
> > maintained, i.e., the drive will always use the write cache per the
> > current code.  With the setting enabled, the driver will use the
> > default value of the drive write cache.
> 
> We have too many config options already.
> 
> Behavior should be simple:
> * no cache flushes - wcache off by default
> * cache flushes - wcache on by default
> * inform user about the wcache status 
> * allow changing of wcache by user

Fully agree, there's no point in making this a config option. Then you
could add options for tens of drive options. The default should be to
leave the drive setting alone.

If ->wcache is always correct, then I don't see an issue. User space can
change the write cache setting as they please, the barrier handling
should work accordingly. Always enable barriers on the journalled fs, if
write cache is off the pre and post flushes are not sent.

-- 
Jens Axboe

