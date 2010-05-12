From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Thu, 13 May 2010 00:58:19 +0400
Message-ID: <4BEB166B.5030007@ru.mvista.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com> <4BE6910D.9070504@ru.mvista.com> <4BE69C81.2070703@gmail.com> <4BE6BA74.10200@mvista.com> <4BE74EEE.5060307@gmail.com> <4BE7D714.9010006@ru.mvista.com> <4BE8A3FE.4070402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:56262 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab0ELU7G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 May 2010 16:59:06 -0400
Received: by wwi18 with SMTP id 18so380258wwi.19
        for <linux-ide@vger.kernel.org>; Wed, 12 May 2010 13:59:04 -0700 (PDT)
In-Reply-To: <4BE8A3FE.4070402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Graeme Russ <graeme.russ@gmail.com>, linux-ide@vger.kernel.org

Hello.

Robert Hancock wrote:
> On 05/10/2010 03:51 AM, Sergei Shtylyov wrote:
>> Hello.
>>
>> Graeme Russ wrote:
>>
>>> Sergei Shtylyov wrote:
>>>> Hello.
>>>>
>>>> Graeme Russ wrote:
>>>>
>>>>> [Added linux-ide back onto distribution list]
>>>> Right, I didn't intend to exclude it -- probably didn't press all the
>>>> keys at once for the reply-to-all function.
>>>>
>>>> [...]
>>>>>> You should have also taught the symmetric ide-platfrom driver the 
>>>>>> same
>>>>>> trick. However, IDE core's data transfer methods has a different
>>>>>> prototype.
>
> The IDE subsystem is deprecated and in maintenance mode,

   I know, I know. :-)

> it shouldn't be growing support for new hardware, which I assume this is.

   This is not a new hardware as it's going to use an existing driver. 
Also, despite maintenance mode, there was a patch accepted recently 
restoring feature parity between ide-platfrom and pata_platfrom.

>>>>> I did think about the other drivers (OF Platform etc) but I have 
>>>>> no way of testing them.
>>>> pata_of_platform is not easily extensible in this way. It gets all the
>>>> information about the device from the device tree -- and you can't
>>>> encode all your complications there, unless you invent a new OF device.

   Besides, Graeme, for what arch is your hardware? If it's PowerPC, you 
should be using pata_of_platform -- but as I said you can't really do it.

>>>>>> I suggest to rather add a new flag, indicating 8-bit data I/O, and
>>>>>> have
>>>>>> the alternate sff_data_xfer() method defined inside the driver.
>>>
>>> The vast majority of implementations are 16-bit (no one has complained
>>> about the lack of 8-bit support to date). I don't think the majority of
>>> users should be carrying around the extra code for a tiny minority.
>>> Yes, it
>>> could be wrapped around an #ifdef but then things start to get ugly 
>>> (why
>>> not just ditch the flag and #ifdef the 8-bit transfers entirely, hack
>>> Kconfig etc) eeewwwww....
>>
>> I didn't propose any of this. Anyway, this is not an option anymore now
>> that we know enough about your hardware.
>>
>>>>> other devices on the bus). By overriding the data transfer function
>>>>> I can
>>>>> arbitrate access to the bus and switch the bus timings based on the
>>>>> peripheral being accessed. This cannot be done be a generic data
>>>>> transfer
>>>>> function.
>>>> I disagree with your approach of overriding the libata methods at the
>>>> board level, so I suggest to write a new driver. This is too 
>>>> complicated
>>>> stuff for poor old pata_platform. :-)
>>>
>>> My custom function to date looks like:
>>>
>>> unsigned int ata_enet_data_xfer(struct ata_device *dev, unsigned char
>>> *buf,
>>> unsigned int buflen, int rw)
>>> {
>>> struct ata_port *ap = dev->link->ap;
>>> void __iomem *data_addr = ap->ioaddr.data_addr;
>>>
>>> set_gp_bus_slow();
>>> /* Transfer bytes */
>>> if (rw == READ)
>>> ioread8_rep(data_addr, buf, buflen);
>>> else
>>> iowrite8_rep(data_addr, buf, buflen);
>>>
>>> set_gp_bus_fast();
>>> return buflen;
>>> }
>>>
>>> set_gp_bus_slow() and set_gp_bus_fast() (at the moment) simply set a 
>>> few
>>> config registers to set the GP bus timing (no arbitration yet, but 
>>> these
>>> functions will also handle that using a mutex). I don't see the 
>>> point in
>>> re-writing the entire PATA Platform driver when the existing driver
>>> appears
>>> to be perfectly capable with a very minor extension hook.
>>
>> As I said, we *can't* implement the driver methods at the board level.
>> Especially if they involve messing with timings -- that's the point
>> where the ATA driver stops being generic, like pata_platform, and there
>> arises a need for the dedicated driver. Also, your patch would bring in
>> disparity with the ide-platfrom driver (which should be interchangeable
>> with pata_platfrom). For me, the need of a separate driver is clear now,
>> so I'll remain opposed to your patch. Of course, the maintainer (Jeff
>> Garzik) will decide but if I could veto this patch I would.
>
> I think there's a case to be made for doing some refactoring to allow 
> splitting the code related to this hardware into a different file or 
> something. However, creating an entirely different driver when the 
> only thing different from pata_platform is that function seems excessive.

    You propose something like pata_of_platform (riding on top of 
pata_platform)? Anyway, I suspect that we have fully programmable bus 
hardware here, which should allow for PIO mode setting, and hence woud 
really need a whole new driver...

WBR, Sergei

