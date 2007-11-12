From: Mark Lord <liml@rtr.ca>
Subject: Re: Delkin Cardbus IDE, a.k.a. ASKA "Ninja" chipset
Date: Mon, 12 Nov 2007 15:15:33 -0500
Message-ID: <4738B465.6070401@rtr.ca>
References: <200711031541.lA3FfJ6h006120@harpo.it.uu.se>	<20071103162203.5388a37f@the-village.bc.nu>	<47323E13.3030205@rtr.ca> <20071107232132.238fdf04@the-village.bc.nu> <47324A16.5010205@rtr.ca> <4738B364.5030806@rtr.ca> <4738B3B7.9090306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3918 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758146AbXKLUPe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Nov 2007 15:15:34 -0500
In-Reply-To: <4738B3B7.9090306@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, greg.freemyer@gmail.com, linux-ide@vger.kernel.org

Mark Lord wrote:
> Mark Lord wrote:
>> Mark Lord wrote:
>>> Alan Cox wrote:
>>>> On Wed, 07 Nov 2007 17:37:07 -0500
>>>> Mark Lord <liml@rtr.ca> wrote:
>>>>
>>>>> delkin_cb is also missing from libata.
>>>>>
>>>>> I was going to port it over once, but no longer have a cardbus slot
>>>>> in either of my notebooks here.
>>>>
>>>> Yes I looked at it but it didn't have any proper speed setting, so I
>>>> decided it wasn't actually worth doing.
>>> ..
>>>
>>> Yeah.  No docs whatsoever, but there's more than a few users
>>> of it out there.
>> ...
>>
>> Mmmm.. the NetBSD people seem to have detailed information on these 
>> chips!
>> There seems to be more than enough information in the NetBSD sources
>> to implement full timings support and full bus-master DMA support:
>>
>> http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/ic/ninjaata32var.h?rev=1.3&content-type=text/x-cvsweb-markup 
>>
>> http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/ic/ninjaata32reg.h?rev=1.3&content-type=text/x-cvsweb-markup 
>>
>> http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/ic/ninjaata32.c?rev=1.9&content-type=text/x-cvsweb-markup 
> 
> Plus the man page (which looks slightly out of date):
> 
> http://netbsd.gw.com/cgi-bin/man-cgi/man?njata+4+NetBSD-current
..

One more link, with many PCI IDs for these chips:

http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/cardbus/njata_cardbus.c?rev=1.5&content-type=text/x-cvsweb-markup
