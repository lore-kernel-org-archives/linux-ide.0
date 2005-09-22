From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
Date: Thu, 22 Sep 2005 11:04:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221103230.2553@g5.osdl.org>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>
  <20050922061849.GJ7929@suse.de>  <1127398679.18840.84.camel@localhost.localdomain>
  <20050922135607.GK4262@suse.de> <1127399409.18840.95.camel@localhost.localdomain>
 <4332F085.9060909@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:16014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbVIVSFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2005 14:05:21 -0400
In-Reply-To: <4332F085.9060909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>, Joshua Kwan <joshk@triplehelix.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>



On Thu, 22 Sep 2005, Jeff Garzik wrote:

> Alan Cox wrote:
> > SCSI suspend should not be blocking SATA suspend. If SCSI isn't with the
> > program yet then SCSI should just not support suspend while allowing
> > SATA to do so.
> 
> Jens' patch updates the SCSI layer -- as is proper and needed.
> 
> Someone needs to take Jens patch to linux-scsi as Christoph mentioned, 
> maybe there is a change in the wind...

Why not just send it to me and Andrew and get it merged.

The way we keep everybody honest (me, maintainers, and random developers) 
is with this concept called "open source", which means that anybody can 
fix a problem, and you don't need to wait for the "vendor". 

Yes, it's good to go through channels, but when that doesn't work, it's 
good to go _past_ them too.

			Linus
