From: Mark Lord <lkml@rtr.ca>
Subject: Re: [patch] ata: ahci: Enclosure Management via LED
Date: Thu, 29 Nov 2007 15:04:17 -0500
Message-ID: <474F1B41.5040302@rtr.ca>
References: <20071129094802.49e729ed@appleyard>	<474F01E7.5040101@rtr.ca> <20071129112220.55310ff5@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3973 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757802AbXK2UET (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 15:04:19 -0500
In-Reply-To: <20071129112220.55310ff5@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kristen.c.accardi@intel.com
Cc: jeff@garzik.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
> On Thu, 29 Nov 2007 13:16:07 -0500
> Mark Lord <lkml@rtr.ca> wrote:
> 
>> Kristen wrote:
>> ...
>>> +	 * XXX will need Port Multiplier support
>> What's that all about ?
>>
> 
> I didn't have any hardware that had LED support as well as Port
> Multiplier, so I didn't implement port multiplier support for this.  I
> wasn't sure if it was better to just do it anyway, or leave it for when
> we actually have hardware that needs it.
..

Good.  So please replace the "XXX" comment with the better
explanation given in your posting above.  That'll make future
maintenance a lot less guessy.

Cheers
