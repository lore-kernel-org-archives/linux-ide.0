From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Mon, 4 Jun 2007 13:34:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706041332050.23741@woody.linux-foundation.org>
References: <46598350.6030403@gmail.com> <4662E5B3.4020205@garzik.org>
 <20070604154231.708b2b9b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:33248 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752701AbXFDUfL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2007 16:35:11 -0400
In-Reply-To: <20070604154231.708b2b9b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>



On Mon, 4 Jun 2007, Alan Cox wrote:

> > At this point, I am only reluctant to push it for 2.6.22 since it is so 
> > late in the -rc series.
> > 
> > If we have another -rc, I would probably be OK with pushing it for 
> > 2.6.22, otherwise I would prefer to wait for 2.6.23.
> > 
> > Comments solicited, from all involved...
> 
> Without a doubt it should be merged

Ok, I think everybody agreed.

Jeff, do you want me to just take the patch you sent earlier if I can 
still find it, or should I pull it from somewhere (btw, the changelog 
should probably be fixed, since there were at least two people who were 
confused by the fact that it mentioned VIA controllers and LITE-ON 
devices, even though it definitely wasn't restricted to that set).

I was going to do an -rc4 yesterday, but slipped, so since I slipped 
anyway, I would prefer to just get this in before doing the -rc..

		Linus
