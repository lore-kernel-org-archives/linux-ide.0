From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 00:47:28 +0200
Message-ID: <200806240047.29118.bzolnier@gmail.com>
References: <87k5gmz596.fsf@denkblock.local> <87r6apuk16.fsf@denkblock.local> <87wskgtwwm.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:15237 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbYFWWqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 18:46:09 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2504439fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 23 Jun 2008 15:46:08 -0700 (PDT)
In-Reply-To: <87wskgtwwm.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

On Monday 23 June 2008, Elias Oltmanns wrote:
> Elias Oltmanns <eo@nebensachen.de> wrote:
> [...]
> > @@ -941,6 +949,7 @@ static ide_startstop_t atapi_reset_pollfunc (ide_drive_t *drive)
> >  	/* done polling */
> >  	hwgroup->polling = 0;
> >  	hwgroup->resetting = 0;
> 
> Actually, ->resetting needs to be protected by the ide_lock here.
> 
> [...]
> > @@ -1005,6 +1014,8 @@ static ide_startstop_t reset_pollfunc (ide_drive_t *drive)
> >  	}
> >  	hwgroup->polling = 0;	/* done polling */
> >  	hwgroup->resetting = 0; /* done reset attempt */
> 
> Same as above.  Unless I have missed something, a simple
> 
> spin_lock(&ide_lock)
> 
> should suffice since there cannot possibly be another interrupt that
> changes ->resetting behind our back.  I'll send an updated version of
> patches 1 and 4 once I have your opinion on the current series.

With patch #1 we may as well just remove ->resetting and allow the next
reset request to be added to the queue.
