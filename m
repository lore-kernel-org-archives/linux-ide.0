From: Alexander Inyukhin <shurick@sectorb.msk.ru>
Subject: Re: [patch] cdrom: Handle TOC
Date: Thu, 7 Aug 2008 21:11:17 +0400
Message-ID: <20080807171117.GA15748@shurick.s2s.msu.ru>
References: <20080806210358.GA7386@shurick.s2s.msu.ru> <20080807041837.GA2394@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from forum.snto-msu.net ([194.88.210.5]:34196 "EHLO
	hq.sectorb.msk.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbYHGRLT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Aug 2008 13:11:19 -0400
Content-Disposition: inline
In-Reply-To: <20080807041837.GA2394@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, Aug 07, 2008 at 06:18:37AM +0200, Borislav Petkov wrote:
> On Thu, Aug 07, 2008 at 01:03:58AM +0400, Alexander Inyukhin wrote:
> >  	if (cdo->open == NULL || cdo->release == NULL)
> >  		return -EINVAL;
> > +	if (cdo->audio_ioctl == NULL)
> > +		return -EINVAL;
> 
> How about putting all checks above together:
> 	if (!cdo->open || !cdo->release || !cdo->audio_ioctl)
> 		return -EINVAL;
> 
> ?

I thought to place a warning message here and it is easier to blame separate check.
Feel free to modify these lines.
