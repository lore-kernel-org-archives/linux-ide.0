From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
 side speed detection
Date: Thu, 24 Aug 2006 10:41:55 -0400
Message-ID: <44EDBAB3.3000404@pobox.com>
References: <1156188229.18887.56.camel@localhost.localdomain>	 <44ED4DB5.10400@pobox.com> <1156417070.3007.64.camel@localhost.localdomain>	 <44EDAEFC.6000609@pobox.com> <1156431385.3007.153.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:1161 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932096AbWHXOmC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2006 10:42:02 -0400
In-Reply-To: <1156431385.3007.153.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-08-24 am 09:51 -0400, ysgrifennodd Jeff Garzik:
>> The standard policy, in place since you began, has been to push core 
>> stuff into #upstream, and the driver side into #pata-drivers.
> 
> Jeff, I've no problem with putting it in upstream but all this talk of
> "standard policy" is crap. Or at least "standard policy" is a concept
> existing only in Jeff's brain and not documented clearly externally in
> this case...

The pata-drivers branch has never received any libata*.[ch] changes in 
its entire lifetime, and you've no doubt noticed libata*.[ch] PATA work 
appearing in the upstream kernel, even when pata_*.c continues to not 
exist in the upstream kernel.  Core stuff has always been split up; 
maybe I just didn't say that explicitly.  Its pretty self-evident by 
looking at public commits, though.

	Jeff



