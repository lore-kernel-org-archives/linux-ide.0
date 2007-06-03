From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Sun, 3 Jun 2007 12:40:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706031238420.23741@woody.linux-foundation.org>
References: <46598350.6030403@gmail.com> <4662E5B3.4020205@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:55748 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750823AbXFCTky (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jun 2007 15:40:54 -0400
In-Reply-To: <4662E5B3.4020205@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>



On Sun, 3 Jun 2007, Jeff Garzik wrote:
> 
> If we have another -rc, I would probably be OK with pushing it for 2.6.22,
> otherwise I would prefer to wait for 2.6.23.

We'll definitely have another -rc. I'll push -rc4 tonight, and while I'm 
hoping that we'll have resolved a number of the regressions, I can 
guarantee an -rc5 and I'd be very surprised if we don't have an -rc6 too.

(In fact, -rc6 tends to be what I consider the sweet spot for when I start 
thinking that I'm ready for a release).

		Linus
