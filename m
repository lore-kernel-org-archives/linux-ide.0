From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [patch] cdrom: Handle TOC
Date: Thu, 7 Aug 2008 06:23:02 +0200
Message-ID: <20080807042302.GB2394@gollum.tnic>
References: <20080806210358.GA7386@shurick.s2s.msu.ru> <489A2FB1.1060603@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:39461 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbYHGEWx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Aug 2008 00:22:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so142027fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 21:22:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <489A2FB1.1060603@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Inyukhin <shurick@sectorb.msk.ru>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, Aug 07, 2008 at 08:11:45AM +0900, Tejun Heo wrote:
> Alexander Inyukhin wrote:
> > index d9d1b65..efc3aa0 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -394,6 +394,8 @@ int register_cdrom(struct cdrom_device_info *cdi)
> >  
> >  	if (cdo->open == NULL || cdo->release == NULL)
> >  		return -EINVAL;
> > +	if (cdo->audio_ioctl == NULL)
> > +		return -EINVAL;
> 
> Maybe sticking a BUG_ON() is a good idea just in case?

I'd do it only temporary so that we could catch drivers which do not set
cdo->audio_ioctl and then remove it after having fixed those. Otherwise it is a
bit too much, imho.

-- 
Regards/Gruss,
    Boris.
