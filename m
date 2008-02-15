From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [libata-dev #upstream-fixes] pata_legacy: don't call ata_host_detach()
 after initialization failure
Date: Fri, 15 Feb 2008 13:52:06 -0500
Message-ID: <47B5DF56.9040707@garzik.org>
References: <alpine.LFD.1.00.0802101603240.2920@woody.linux-foundation.org> <20080212081816.GA17820@elte.hu> <20080212071452.5c58ae6d@laptopd505.fenrus.org> <20080213090159.GA21614@elte.hu> <47B2B653.7020408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54646 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759824AbYBOSwU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Feb 2008 13:52:20 -0500
In-Reply-To: <47B2B653.7020408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mark Lord <mlord@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> ata_host_detach() detaches an attached port and shouldn't be called on
> a port which hasn't been attached yet.  pata_legacy incorrectly calls
> ata_host_detach() on unattached port after initialization failure
> causing oops.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Arjan van de Ven <arjan@infradead.org>
> ---
>  drivers/ata/pata_legacy.c |    2 --
>  1 file changed, 2 deletions(-)

applied


