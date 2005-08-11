From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 13:19:27 -0400
Message-ID: <42FB889F.50607@pobox.com>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org> <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca> <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:60070 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751134AbVHKRTf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 13:19:35 -0400
In-Reply-To: <42FB853E.4070100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>> currently no one should be using libata for PATA support.
> 
> 
> We emailed back and forth extensively about how this has
> not been true since early this year.  Modern laptops are
> using libata for the ICH6M support, simply because libata
> claims that chipset, and the IDE driver does not.
> These laptops are using PATA drives (eg. "FUJITSU MHV2100AH").

This sounds like a misconfigured kernel.  The IDE driver should pick up 
the PATA port, and libata should pick up the SATA port.  Anything else 
is a bug, and should be addressed by me or Bart.


>> Exaggeration.  We're talking about a single #define here, to enable 
>> ATAPI.
> 
> 
> Fine for ATAPI, though it's two defines -- need to also enable DMA.

What define enables/disables DMA, in your opinion?


> And Passthru is much bigger than a pair of #defines.

That is a separate $thread.


> Push some of this stuff out to the -mm tree, and maybe we'll get
> more people exercising the code, and it'll progress more quickly.

Both passthru and ATAPI code are already available in the -mm tree, 
unless Andrew made a mistake and accidentally dropped passthru.

	Jeff


