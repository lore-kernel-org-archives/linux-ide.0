From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE S.M.A.R.T. ioctl errors
Date: Sat, 2 Aug 2008 18:38:55 +0200
Message-ID: <200808021838.55477.bzolnier@gmail.com>
References: <20080728060133.GA14007@gollum.tnic> <200807281822.05211.bzolnier@gmail.com> <488E405E.4010300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:8606 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498AbYHBRJf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Aug 2008 13:09:35 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1266121fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2008 10:09:34 -0700 (PDT)
In-Reply-To: <488E405E.4010300@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: petkovbb@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday 28 July 2008, Mark Lord wrote:
> If we're going to continue to keep drivers/ide on life-support,
> then perhaps one should just add SG_IO::ATA_16 support into it
> and leave the "legacy" ioctls alone.

I was actually hoping that somebody will came with this idea (+ patch)
after we unified all separate taskfile execution code-paths and added
struct ide_taskfile (the code is now much more similiar to libata then
it is to old IDE one).

> I've done this for linux-2.2.xx (really!), and the patch was rather
> tiny indeed -- and that custom kernel now supports all of the fancy
> ioctl() needs of hdparm-8.9 and smartctl.
> 
> Perhaps a similar patch for drivers/ide ?
> 
> Here's my 2.2.xx hack for perusal:
>  http://empeg-hijack.sourceforge.net/patches/relative/v489-v490.patch.gz
> 
> It won't work on current kernels, of course, but perhaps something similar would.

Thanks, your 2.2.x patch proves the idea well but we need something
more similar to the current libata code for 2.6.x (the resulting patch
should be both smaller and the easier to make than old IDE backport).

Bart
