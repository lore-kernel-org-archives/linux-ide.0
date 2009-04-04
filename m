From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide-cd: cleanup cdrom_decode_status
Date: Sat, 4 Apr 2009 14:17:20 +0200
Message-ID: <200904041417.21125.bzolnier@gmail.com>
References: <1238655519-10074-2-git-send-email-petkovbb@gmail.com> <200904030108.39927.bzolnier@gmail.com> <20090403045803.GA3732@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:33793 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbZDDMRL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Apr 2009 08:17:11 -0400
In-Reply-To: <20090403045803.GA3732@liondog.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 03 April 2009, Borislav Petkov wrote:

[...]

> > > @@ -614,14 +589,15 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
> > >  	struct request *rq = hwif->rq;
> > >  	ide_expiry_t *expiry = NULL;
> > >  	int dma_error = 0, dma, thislen, uptodate = 0;
> > > -	int write = (rq_data_dir(rq) == WRITE) ? 1 : 0, rc, nsectors;
> > > +	int write, uninitialized_var(rc), nsectors;
> > 
> > Why is uninitialized_var() here now?
> 
> because gcc is whining that it might be uninitialized although I've
> doublechecked all codepaths returning a valid error. It is there to shut
> up this warning, actually.

It is gcc's fault (version dependent on top of it).  However since it may
affect other people and workarounding it costs us absolutely nothing lets
be pragmatic about it.

Please resend this change in a separate patch so it can be applied.
