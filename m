From: Gentoopower <gentoopower@yahoo.de>
Subject: Re: NCQ general question
Date: Wed, 01 Mar 2006 17:48:00 +0100
Message-ID: <4405D040.8000700@yahoo.de>
References: <5d96567b0602282304o558fb564jd72784bafdd289f5@mail.gmail.com> <440561CB.30201@yahoo.de> <4405A656.1030602@rtr.ca> <4405C41F.5060504@yahoo.de> <20060301160554.GD4816@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp110.plus.mail.mud.yahoo.com ([68.142.206.243]:41094 "HELO
	smtp110.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751622AbWCAQsG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Mar 2006 11:48:06 -0500
In-Reply-To: <20060301160554.GD4816@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jens Axboe wrote:
> On Wed, Mar 01 2006, Gentoopower wrote:
>   
>> I have two seagates in my box a 160GB 7200.7 and 160GB 7200.9(SATAII
>> NCQ), using NFORCE4.
>> I can defintely feel the speed difference between the two drives.
>>     
>
> Well that can't be because of NCQ, since it isn't active :-)
>   

Got ya:-)

Who said this box is running only linux?

I have dual boot on this box, Windows 2003 Server and Gentoo, originally
I had windows
on the 7200.2 then bought the 7200.9, cloned the drive to the new,
therefore I know the difference:-)

And yeah it is active, at least nvidias info tool in hardware manager
says it is:-)

>   
>> P.S. Just waiting to see NCQ support for my nforce system in libata:-)
>>     
>
> Don't hold your breath, it's unlikely to get supported as nvidia wont
> open the specs. ahci is a really really nice controller, if you want ncq
> I suggest going with that. sil is probably the next in line for ncq
> support.
>
>   



	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

