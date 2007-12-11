From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH -stable] libata: kill spurious NCQ completion
	detection
Date: Tue, 11 Dec 2007 14:51:49 -0800
Message-ID: <20071211225149.GB17643@kroah.com>
References: <4759E47B.8000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:34073 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759342AbXLKWww (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 17:52:52 -0500
Content-Disposition: inline
In-Reply-To: <4759E47B.8000108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: stable@kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Jeff Garzik <jeff@garzik.org>, Diego Torres <dtorres@coral.dnsalias.org>

On Sat, Dec 08, 2007 at 09:25:31AM +0900, Tejun Heo wrote:
> Spurious NCQ completion detection implemented in ahci was incorrect.
> On AHCI receving and processing FISes and raising interrupts are not
> interlocked and spurious interrupts are expected.
> 
> For example, if an interrupt occurs while interrupt handler is running
> and the running interrupt handler handles the event the new IRQ
> indicated, after IRQ handler finishes, it will be executed again
> because IRQ pending bit is set by the new interrupt but there won't be
> anything to process.
> 
> Please read the following message for more information.
> 
>   http://article.gmane.org/gmane.linux.ide/26012
> 
> This patch...

Is this already in Linus's tree?  Is this for 2.6.23-stable, and/or
older ones too?

thanks,

greg k-h
