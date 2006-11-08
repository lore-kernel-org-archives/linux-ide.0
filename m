From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_mv 7042 support and port multipliers
Date: Wed, 08 Nov 2006 08:42:29 -0500
Message-ID: <4551DEC5.4000307@pobox.com>
References: <20061106043114.GO15897@curie-int.orbis-terrarum.net> <454ED4A0.2090408@pobox.com> <20061108133511.GH16523@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:16774 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965750AbWKHNnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 08:43:04 -0500
In-Reply-To: <20061108133511.GH16523@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@orbis-terrarum.net>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Robin H. Johnson wrote:
> On Mon, Nov 06, 2006 at 01:22:24AM -0500, Jeff Garzik wrote:
>> That's what I had to do.  I have the docs, which cover the programming 
>> interface, but it doesn't cover a lot of the associated errata.  I had 
>> to dig that out of the mvSata driver myself.
>>
>> I had thought that Mark Lord was working on improving sata_mv, but 
>> outside of a locking bugfixes, I haven't seen anything since mid-May.
>>
>> So I guess sata_mv is in limbo again...
> Ok, since Mark says he doesn't have the 6081 anymore I guess if I want
> this working at all, I get to write and maintain it myself :-).
> 
> Are those Marvell docs under some form of protection (NDA etc)? Can I
> get a copy of them? There a few questions (around NCQ/PMP) that the
> mvSata driver raises for me, and I think the docs would help there.

Yes, they're under NDA.  If you have specific programming questions that 
deal directly with the functioning of the driver (i.e. imparting facts 
necessary for the operation of the open source driver), I can help out 
though.

	Jeff



