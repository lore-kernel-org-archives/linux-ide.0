From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Sat, 21 Mar 2009 10:59:40 -0400
Message-ID: <49C500DC.7020006@rtr.ca>
References: <49C1047D.4000008@rtr.ca>	<49C11A0C.3070502@rtr.ca>	<49C11ED4.2030307@rtr.ca>	<49C19087.5000307@gmail.com>	<49C190F1.7010202@kernel.org>	<49C28133.8050401@rtr.ca>	<49C281A5.5080404@rtr.ca>	<49C2D642.90706@kernel.org>	<49C39690.6090802@rtr.ca>	<49C396CF.7030202@rtr.ca>	<20090320140714.2e7770d0@lxorguk.ukuu.org.uk>	<49C3B7E9.2000505@rtr.ca>	<49C4235D.5070303@kernel.org>	<49C43ABA.4010601@pobox.com> <20090321140250.6569644d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44331 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754856AbZCUO7r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Mar 2009 10:59:47 -0400
In-Reply-To: <20090321140250.6569644d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> Yeah, that has long been a design decision -- avoid all the mechanics of 
>> PIO-Multi, simply because we did not have much of a need for it (and 
>> still don't).
>>
>> Albert Lee worked on PIO-Multi a while ago, which was mainly to get 
>> ATA_{12,16} working, IIRC.
>>
>> But overall, I don't see much of a need to introduce it into the main stack?
> 
> I don't see a need - and if we do its more important IMHO to get the PIO
> paths out of the irq handlers before doing so.
..

That's not a new concern, given that we *already* perform multi-sector I/O.

And it's not really related to improving the implementation to be better
aware of multi-sector I/O and interaction with EH.

But yeah, a good thing nonetheless.

Cheers
