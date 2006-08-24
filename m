From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
 side speed detection
Date: Thu, 24 Aug 2006 09:51:56 -0400
Message-ID: <44EDAEFC.6000609@pobox.com>
References: <1156188229.18887.56.camel@localhost.localdomain>	 <44ED4DB5.10400@pobox.com> <1156417070.3007.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19335 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751536AbWHXNwE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2006 09:52:04 -0400
In-Reply-To: <1156417070.3007.64.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-08-24 am 02:56 -0400, ysgrifennodd Jeff Garzik:
>> ACK, but you need to split this up into core (#upstream) and PATA 
>> (#pata-drivers) patches.
> 
> Its not really needed until you have pata drivers so I was planning to
> submit it only for the pata-drivers side of things ?

The standard policy, in place since you began, has been to push core 
stuff into #upstream, and the driver side into #pata-drivers.

That way core changes aren't hidden away in #pata-drivers, and new 
PATA-related code is always compiled -- just like it will be, when the 
PATA drivers are in mainline.

	Jeff


