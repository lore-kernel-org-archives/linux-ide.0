From: Jens Axboe <axboe@suse.de>
Subject: Re: [BUG] Kernel disables DMA on RICOH CD-R/RW
Date: Wed, 17 Nov 2004 22:06:57 +0100
Message-ID: <20041117210657.GP26240@suse.de>
References: <20041116124656.82075.qmail@web52601.mail.yahoo.com> <58cb370e04111605019fc1df8@mail.gmail.com> <1100706838.420.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:14981 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262608AbUKQVJp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Nov 2004 16:09:45 -0500
Content-Disposition: inline
In-Reply-To: <1100706838.420.47.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, Nov 17 2004, Alan Cox wrote:
> On Maw, 2004-11-16 at 13:01, Bartlomiej Zolnierkiewicz wrote:
> > Previously VIA IDE driver ignored DMA blacklists completely
> > (which was of course wrong), it was fixed.
> > 
> > Probably this drive should be removed from the blacklist.
> > Does anybody remember why was it added there?
> 
> As I said before almost all of our blacklist is junk from when the IDE
> ATAPI DMA bug wasn't fixed.

I sure don't remember why, so sounds plausible.

-- 
Jens Axboe

