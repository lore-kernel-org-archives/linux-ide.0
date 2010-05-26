From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Wed, 26 May 2010 18:05:02 +0400
Message-ID: <4BFD2A8E.7080907@ru.mvista.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com>	 <4BE6910D.9070504@ru.mvista.com> <4BE69C81.2070703@gmail.com>	 <4BE6BA74.10200@mvista.com> <4BE74EEE.5060307@gmail.com>	 <4BE7D714.9010006@ru.mvista.com> <4BE8A3FE.4070402@gmail.com>	 <4BEB166B.5030007@ru.mvista.com> <4BEB7960.40007@gmail.com>	 <4BEC68E6.1020305@mvista.com> <AANLkTikruHKM8W7m9sMHtyApxwLdi6R-I62S54vDsXcO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55129 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab0EZOF5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 May 2010 10:05:57 -0400
Received: by wyb29 with SMTP id 29so3244752wyb.19
        for <linux-ide@vger.kernel.org>; Wed, 26 May 2010 07:05:55 -0700 (PDT)
In-Reply-To: <AANLkTikruHKM8W7m9sMHtyApxwLdi6R-I62S54vDsXcO@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Graeme Russ <graeme.russ@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Hello.

Graeme Russ wrote:

    Sorry for the belated reply, I've been somewhat busy.

>>  If it ends up using it. I tend to think about it as a truly new hardware
>> needing a separate driver, so IDE support would really be out of question.

>>> Correct - it is a direct attachment of a CF card onto an 8-bit data bus

>>  And we have several *separate* drivers for the alike CF cases.

> Can you elaborate - I thought the PATA Platform driver was designed to
> unify the very discontguous approaches that have previously been taken
> in the embedded designs. As such, the need for these various drivers
> should diminished.

    Look at pata_ixp4xx_cf as an example. Part of what it does is 
override the sff_data_xfer() method to temporarily switch the bus from 
8-bit to 16-bit mode (i.e. *almost* the same thing as you're going to do 
in your override). Other CF drivers (like pata_octeon_cf) have DMA 
support though...

> [snip]

>>>>  Besides, Graeme, for what arch is your hardware? If it's PowerPC, you
>>>> should be using pata_of_platform -- but as I said you can't really do it.

>>> This is for an embedded x86 solutions (AMD SC520). Note: By embedded I
>>> really do mean embedded, not mini-PC or the like (i.e. no BIOS)

>>  Ah, I saw your initial request on u-boot maling list which mentioned OF
>> platfrom driver and assumed you might be on a PowerPC machine...

> Pardon my ignorance but when I asked that question I did not realise that
> 'OF' was 'Open Firmware' and, ergo, PPC

    Oh, there are ongoing efforts to port the most used concept of OF, 
i.e. device tree to ARM and MIPS... Hence, pata_of_platform would be 
able to run on these archs as well...

> [snip]

>>> if a driver has override hooks for over 50% of its functions and you are
>>> using all of those hooks then perhaps a dedicated driver is the way to go,
>>> but adding a 8-bit versus 16-bit access hook is probably the most trivial
>>> and fundamental hook you could add to a device driver (even more
>>> fundamental than the existing byte stuffing hook IMHO)

>>  What byte stuffing do you mean?

> Sorry, I meant the 'Port Shifting' (I/O port shift, for platforms with ports
> that are constantly spaced and need larger than the 1-byte spacing used by
> ata_std_ports())

> So yes, in theory, your original idea of adding an '8-bit flag' would be
> more in keeping with Port Shift (i.e. tell the driver to use a specifically
> non-standard function which *is* implemented in the driver core). But this
> goes back to my prior arguments - why pollute the driver core with non-
> standard functions

    8-bit I/O is pretty standard, just rarely used method of transfer in 
the ATA world. The PCMCIA ATA driver, pata_pcmcia implements it, for 
example.

> when a simple hook which is ignored if NULL will do.
> Now if we then find that many different developers are using a particular
> hook to do the same thing, that 'thing' becomes 'common' and gets merged
> into the driver core later.

>>> CF card. It is not a really high speed CPU (486 DX4100 equivalent) so
>>> supporting high speed data transfers without DMA is a bit pointless. The

>>  People wrote a lot of VLB drivers in order to get high PIO speeds on i486.
>> And PIO4 gives *significant* speed increase over PIO0. Although I suspect
>> libata's PIO speeds are still painfully low compared to IDE core -- need to

    I still really need to measure this another time...

>> re-check this with the recent kernel. So, chosing libata over IDE might not
>> be so obvious advantage as it seems...

> You will have tp pardon my ignorance - Until a few weeks ago I knew nothing
> about CF / IDE / ATA / PIO etc. I do not fully understand how the various
> PIO modes are implemented.

    The most important thing is that the higher is the PIO mode is, the 
lower is the transfer cycle time, and hence the transfer speed.

>>> only timing switch I care for is 'Accessing CF / Not Accessing CF' which
>>> has a timing difference of 5 or so bus cycles.

>>  There could be *negative* difference with high PIO modes -- PIO4-to-PIO0
>> cycle ratio is 5 (600:120).

> Sorry, I do not understand.

    PIO mode 0 (PIO0), the most compatible mode that should be 
implemented by default, has 600 ns transfer cycle; the highest standard 
PIO mode 4 (PIO4) has 120 ns cycle, so is (theoretically) 5 times faster 
than PIO0.

> Regards,

> Graeme

MBR, Sergei
