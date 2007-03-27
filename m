From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Tue, 27 Mar 2007 10:23:39 -0400
Message-ID: <460928EB.8010605@rtr.ca>
References: <20070324064814.38720.qmail@web802.biz.mail.mud.yahoo.com> <4604D564.9010806@gmail.com> <4608A42D.6080403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:2381 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879AbXC0OXm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Mar 2007 10:23:42 -0400
In-Reply-To: <4608A42D.6080403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Bob Stewart <bob@evoria.net>, linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
>..
> Broken, or LBA28-only?
> 
> I would think that we have other controllers that need an LBA28-only 
> flag.  (note: don't be fooled by ATA_FLAG_PIO_LBA48, that doesn't quite 
> do what we want)
> 
> Alan, Mark, surely some ancient controller simply can't do LBA48 at all, 
> even in PIO mode?

Mmm.. Alan has more docs in his possession than I do for those,
but I'd expect such beasts to be somewhat rare.

I haven't run into any here, but they do exist.

Cheers
