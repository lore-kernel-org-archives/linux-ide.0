From: David Greaves <david@dgreaves.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 01 Mar 2006 17:33:18 +0000
Message-ID: <4405DADE.10206@dgreaves.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34>	 <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34>	 <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com>	 <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34>	 <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com>	 <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>	 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca>	 <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca>	 <44042863.2050703@dgreaves.com>  <44046074.4070201@rtr.ca> <1141139776.3089.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:25534 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751493AbWCARdE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 12:33:04 -0500
In-Reply-To: <1141139776.3089.78.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>

Alan Cox wrote:

>On Maw, 2006-02-28 at 09:38 -0500, Mark Lord wrote:
>  
>
>>The error handling still sucks, regardless of FUA.
>>All of this nonsense about "Medium Error" is pure bogosity here.
>>    
>>
>
>I've flipped my tree to report Aborted Command. Not sure there is a
>better scsi sense match for "it broke and I dont know why"
>  
>
As a user I prefer
  It Broke And I Dont Know Why
to
  Aborted Command

(honesty is the best policy)

I certainly hate Medium Error as modern hard disks seem to be flakier
than ever.

David
