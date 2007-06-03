From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Sun, 3 Jun 2007 11:45:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706031141491.23741@woody.linux-foundation.org>
References: <46598350.6030403@gmail.com> <4662E5B3.4020205@garzik.org>
 <200706031924.46238.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:55059 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbXFCSqI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jun 2007 14:46:08 -0400
In-Reply-To: <200706031924.46238.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>



On Sun, 3 Jun 2007, Bartlomiej Zolnierkiewicz wrote:
> 
> The patch should be safe (drivers/ide has been doing SETXFER this way for
> ages) and fixes real user problems (which becomes even more important now as
> distros are converting to libata PATA).

I hadn't realized that Fedora 7 had converted entirely to libata, but 
considering that it apparently has, I can almost guarantee that the Fedora 
people would need to merge that patch, whether it's in the standard kernel 
or not. If it hit me with an all-intel chipset (and not even a very 
strange drive), it will hit others.

Of course, maybe that TDK drive really is more unusual than I thought it 
was, so I can't really back that gut feel up. But yeah, I think we might 
as well merge it sooner rather than later - we'll have to bite the bullet 
at some point anyway.

			Linus
