From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 03/12] sata_mv wait for empty+idle
Date: Fri, 2 May 2008 11:39:25 -0700
Message-ID: <da824cf30805021139p1e859419u38d7b808e4f8a06e@mail.gmail.com>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>
	 <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca>
	 <da824cf30805020942q27466cbbk5c7877d6caa6c3d1@mail.gmail.com>
	 <481B5334.7030200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:40224 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762226AbYEBSjd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 14:39:33 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id m42IdQGD003757
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 19:39:27 +0100
Received: from wf-out-1314.google.com (wfg24.prod.google.com [10.142.7.24])
	by zps35.corp.google.com with ESMTP id m42IdDSm017814
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 11:39:25 -0700
Received: by wf-out-1314.google.com with SMTP id 24so1373605wfg.31
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2008 11:39:25 -0700 (PDT)
In-Reply-To: <481B5334.7030200@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, May 2, 2008 at 10:45 AM, Mark Lord <liml@rtr.ca> wrote:
> Grant Grundler wrote:
...
> > I reccomend setting per_loop to 10 or 20 at least. 5us is not very long.
> > It takes about 1us to do an MMIO read. Each additional MMIO read will
> exacerbate
> > the problem of DMA not finishing since MMIO reads interfere with DMA
> streams.
> >
> > Also can you add a comment why 15ms is right amount of time to wait?
> >
>  ..
>
>  I would, if I knew.  That's just a random number.
>  My own timings with a handful of drives here indicated
>  that it takes a few hundred microseconds worst case,
>  so I just picked a bigger number to start with.
>
>  No rationale == no comment in the original.

Ok. Often there is a rationale and the original author just
didn't include it.

>  But if you have a good theory for what that number ought to be,
>  then go for it -- just patch it and stick an explanation in.

I'd need to study the EDMA engine docs more carefully than
I have to date.


> > BTW, I have no idea when EDMA stops on it's own or if we could
> > safely get EDMA to stop "prematurely" (e.g. disable PCI Bus Master).
> >
>  ..
>
>  I don't know what you're talking about there.

I don't either. :)
Just trying to explain I was making up the example.

thanks,
grant

>
>  ???
>
