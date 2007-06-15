From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Sat, 16 Jun 2007 01:23:55 +0200
Message-ID: <200706160123.55636.bzolnier@gmail.com>
References: <20070221011922.GA1777@freefall.freebsd.org> <200702210342.20775.bzolnier@gmail.com> <466EEFD6.9030001@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:64985 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670AbXFOX0y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jun 2007 19:26:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so964359ugf
        for <linux-ide@vger.kernel.org>; Fri, 15 Jun 2007 16:26:53 -0700 (PDT)
In-Reply-To: <466EEFD6.9030001@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 12 June 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >>On Feb 20, 2007, at 5:44 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> >>>On Wednesday 21 February 2007 02:19, Suleiman Souhlal wrote:
> 
> >>>>It can be changed via /proc/ide/hd?/settings.
> 
> >>>Why do we need to change IDE DMA timeout dynamically?
> 
> >>I've used it to test error recovery (for example).
> 
> > Seems quite useable for developers but I would prefer not to
> > expose it in production kernels for end users.
> 
>     It seems that I have counter example of a customer asking if this timeout 
> can be done configurable. :-)

May I ask what was the rationale for this request?

I have no strong feelings about adding this /proc/ide/ setting but I worry
that it could be (mis)used just to (unreliably) work-around problems...

>     BTW, why the timeout is so damn long? 2*WAIT_CMD is 20 secs, and if DMA is 
> not complete or interrupt pending, it may wait 10 more secs...

I really don't remember... :)

Maybe Mark or Alan could help with figuring this out.

Thanks,
Bart
