From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH (for comment): ide-cd possible race in PIO mode
Date: Wed, 24 Nov 2004 11:35:51 +0000
Message-ID: <1101137446.2756.3.camel@localhost.localdomain>
References: <1100697589.32677.3.camel@localhost.localdomain>
	 <20041117153706.GH26240@suse.de>  <20041122075802.GL26240@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263060AbUKZTkh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Nov 2004 14:40:37 -0500
In-Reply-To: <20041122075802.GL26240@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Llu, 2004-11-22 at 07:58, Jens Axboe wrote:
> > > +		spin_unlock_irqsave(&ide_lock, flags);
> > >  		return (*handler) (drive);
> > >  	}
> 
> btw alan, have you attempted to compile this? It averages 2 errors out
> of 4 lines :)

Guess why it said "for comment". The one that does compile is in current
-ac
but the fixes are kind of obvious 8)

