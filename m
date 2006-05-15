From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 19:19:26 -0400
Message-ID: <44690C7E.10908@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515230256.GB4699@animx.eu.org> <4469081D.7080608@garzik.org> <20060515231304.GC4699@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31442 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750745AbWEOXT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 19:19:28 -0400
In-Reply-To: <20060515231304.GC4699@animx.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Wakko Warner wrote:
> Jeff Garzik wrote:
>> Wakko Warner wrote:
>>> How about PATA?  Specifically intel's IDE chip.  I have a machine that I 
>>> can
>>> blow the hard drive away if I want to.
>> Always helpful.  ata_piix should support Intel PATA controllers, modulo 
>> some bugs that Alan is fixing / has fixed.  If your PCI ID isn't listed, 
>> you will have to add it, and an associated info entry.  Again, take a 
>> look at Alan's libata PATA patches for guidance.
> 
> Do I need his patches as well?  If so, where do I retrieve them?  I lost the
> url for it.

Me too, hopefully he'll chime in.  In any case, it's highly likely that 
things will work out of the box.

	Jeff



