From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv 7042 support and port multipliers
Date: Tue, 07 Nov 2006 12:10:20 -0500
Message-ID: <4550BDFC.1050408@rtr.ca>
References: <20061106043114.GO15897@curie-int.orbis-terrarum.net> <454ED4A0.2090408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:42246 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964990AbWKGRKW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2006 12:10:22 -0500
In-Reply-To: <454ED4A0.2090408@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Robin H. Johnson wrote:
..
>> The card reports as revision 2, which is not in the code either.
>>
>> I've got the hardware, so I'm willing to do heavy lifting of code (NCQ,
>> Hotplug, PMP) if it hasn't been done yet, if somebody point me to some
>> docs on the matter.  I've seen the mvSata-3.6.1 driver, and it appears
>> to have most of the stuff on revision 1, but nothing on hardware
>> revision 2 either.
>>
>> Jeff: you mentioned back in September about Marvell being a bit more
>> generous with docs? Were 7042 docs amongst them or do I have to slog
>> through the messy mvSata driver to find everything?
> 
> That's what I had to do.  I have the docs, which cover the programming 
> interface, but it doesn't cover a lot of the associated errata.  I had 
> to dig that out of the mvSata driver myself.
> 
> I had thought that Mark Lord was working on improving sata_mv, but 
> outside of a locking bugfixes, I haven't seen anything since mid-May.

I no longer use a system with that chipset (6081), so if someone new (Robin?)
wants to take up the cause, then go for it!

Cheers

