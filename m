From: Mark Lord <liml@rtr.ca>
Subject: Re: CF flash PATA on libata failure to attach
Date: Thu, 28 Jun 2007 22:26:12 -0400
Message-ID: <46846DC4.4070800@rtr.ca>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca> <468453f8.13578c0a.3c99.ffffa514@mx.google.com> <46845BEE.90801@rtr.ca> <46846230.6080908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2861 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757300AbXF2C0P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 22:26:15 -0400
In-Reply-To: <46846230.6080908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Hall <andrew.a.hall@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Tejun Heo wrote:
> Hello,
> 
> Mark Lord wrote:
>> Here's a slightly modified hack, which should leave your SATA
>> drive working as well as the CF card.
>>
>> Tejun / Alan : do we really want to continue attempting mdma2
>> on a modern chipset such as ICH8 ???
> 
> One thing that worries me is that we have reports where the IDE piix can
> do mwdma but ata_piix can't.  I wonder whether Andrew is hitting the
> same problem.

I think Andrew said he had tried the old IDE driver,
but perhaps it didn't match his PCI IDs ?

Andrew?
