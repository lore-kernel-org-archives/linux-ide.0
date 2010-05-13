From: Graeme Russ <graeme.russ@gmail.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Thu, 13 May 2010 14:00:32 +1000
Message-ID: <4BEB7960.40007@gmail.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com> <4BE6910D.9070504@ru.mvista.com> <4BE69C81.2070703@gmail.com> <4BE6BA74.10200@mvista.com> <4BE74EEE.5060307@gmail.com> <4BE7D714.9010006@ru.mvista.com> <4BE8A3FE.4070402@gmail.com> <4BEB166B.5030007@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60052 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab0EMEAi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 May 2010 00:00:38 -0400
Received: by pvg12 with SMTP id 12so138835pvg.19
        for <linux-ide@vger.kernel.org>; Wed, 12 May 2010 21:00:38 -0700 (PDT)
In-Reply-To: <4BEB166B.5030007@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On 13/05/10 06:58, Sergei Shtylyov wrote:
> Hello.
> 
> Robert Hancock wrote:
>> On 05/10/2010 03:51 AM, Sergei Shtylyov wrote:
>>> Hello.
>>>
>>> Graeme Russ wrote:
>>>
>>>> Sergei Shtylyov wrote:
>>>>> Hello.
>>>>>
>>>>> Graeme Russ wrote:
>>>>>
>>>>>> [Added linux-ide back onto distribution list]
>>>>> Right, I didn't intend to exclude it -- probably didn't press all the
>>>>> keys at once for the reply-to-all function.
>>>>>
>>>>> [...]
>>>>>>> You should have also taught the symmetric ide-platfrom driver the
>>>>>>> same
>>>>>>> trick. However, IDE core's data transfer methods has a different
>>>>>>> prototype.
>>
>> The IDE subsystem is deprecated and in maintenance mode,
> 
>   I know, I know. :-)
> 
>> it shouldn't be growing support for new hardware, which I assume this is.
> 
>   This is not a new hardware as it's going to use an existing driver.

Correct - it is a direct attachment of a CF card onto an 8-bit data bus

> Also, despite maintenance mode, there was a patch accepted recently
> restoring feature parity between ide-platfrom and pata_platfrom.
> 

>>>>>> I did think about the other drivers (OF Platform etc) but I have
>>>>>> no way of testing them.
>>>>> pata_of_platform is not easily extensible in this way. It gets all the
>>>>> information about the device from the device tree -- and you can't
>>>>> encode all your complications there, unless you invent a new OF
>>>>> device.
> 
>   Besides, Graeme, for what arch is your hardware? If it's PowerPC, you
> should be using pata_of_platform -- but as I said you can't really do it.
> 

This is for an embedded x86 solutions (AMD SC520). Note: By embedded I
really do mean embedded, not mini-PC or the like (i.e. no BIOS)

[snip]

>> I think there's a case to be made for doing some refactoring to allow
>> splitting the code related to this hardware into a different file or
>> something. However, creating an entirely different driver when the
>> only thing different from pata_platform is that function seems excessive.
> 

I agree - It is a pretty poor driver architecture that requires an entirely
new driver for the sake of <10% change in functionality. I would agree that
if a driver has override hooks for over 50% of its functions and you are
using all of those hooks then perhaps a dedicated driver is the way to go,
but adding a 8-bit versus 16-bit access hook is probably the most trivial
and fundamental hook you could add to a device driver (even more
fundamental than the existing byte stuffing hook IMHO)

>    You propose something like pata_of_platform (riding on top of
> pata_platform)? Anyway, I suspect that we have fully programmable bus
> hardware here, which should allow for PIO mode setting, and hence woud
> really need a whole new driver...

Yes, the bus timing is fully programmable - It allows the insertion of an
integer number of 33MHz bus cycles into various stages of the bus access.

I don't really care for changing bus timings wrt PIO mode supported by the
CF card. It is not a really high speed CPU (486 DX4100 equivalent) so
supporting high speed data transfers without DMA is a bit pointless. The
only timing switch I care for is 'Accessing CF / Not Accessing CF' which
has a timing difference of 5 or so bus cycles.

And truthfully, I don't even think I need to mutex the bus - The other
devices can use the bus using the slower timings anyway so it does not
really matter if a context switch occurs during the CF read/write in order
to access another device

Regards,

Graeme
