From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-sff: Correct use of check_status()
Date: Mon, 22 Oct 2007 11:40:56 +0100
Message-ID: <20071022114056.78bafbf1@the-village.bc.nu>
References: <20071015192529.2365b636@the-village.bc.nu>
	<4716AFCA.4080509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:60000 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751742AbXJVKhz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 06:37:55 -0400
In-Reply-To: <4716AFCA.4080509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

> > +	tf->command = ata_chk_status(ap);
> >  	tf->feature = ioread8(ioaddr->error_addr);
> >  	tf->nsect = ioread8(ioaddr->nsect_addr);
> >  	tf->lbal = ioread8(ioaddr->lbal_addr);
> 
> applied, with a sigh:  it's in SFF, so I saw nothing wrong with 
> ata_check_status().  I checked -- no SFF driver overrides it according 
> to my audit, therefore the previous version was faster while still correct.

I hit it with the NS87415 where ata_check_status() doesn't do the right
thing. Later on it turned out that there were enough other bugs when
enabling DMA that it needed its own tf read method anyway.

Alternative is to go through and clear up chk_atatus v check_status
(rename one sff_ to be clear), and explicitly document the assumption in
tf_read. That way it'll be obvious to whoever hits it in future and they
can supply their own tf_read method.

Preferences ?

Alan
