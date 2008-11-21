From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Fri, 21 Nov 2008 20:26:45 +0300
Message-ID: <4926EF55.7080004@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com> <20081121102137.634616c5@lxorguk.ukuu.org.uk> <4926EA6A.7040704@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4187 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751838AbYKUR0o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 12:26:44 -0500
In-Reply-To: <4926EA6A.7040704@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

David Daney wrote:

>>> +    use_iordy = 1;

>> This depends on the device as well and gets quite complicated. We have
>> ata_pio_need_iordy() to do the work for you.
>>
>>> +    t1 = (t1 * clocks_us) / 1000 / 2;
>>> +    if (t1)
>>> +        t1--;

>> Even if you wanted to do it this way you could just use arrays and lookup
>> tables as many other drivers do - ie

>>     pio = dev->pio_mode - XFER_PIO_0;
>>     t1 = data[pio];

> The timing calculations are based on the CPU clock rate, It is difficult 
> to encapsulate that in a table.

    Nobody suggests that. You surely can put the timings in ns in a 
structure/table.

> [...]

>>> +    /*
>>> +     * Odd lengths are not supported. We should always be a
>>> +     * multiple of 512.
>>> +     */
>>> +    BUG_ON(buflen & 1);

>> If you get a request for an odd length you should write an extra word
>> containing the last byte and one other. See how the standard methods
>> handle this.

> OK.

    I don't think you need to bother doing that with CF.

>>> +            while (words--) {
>>> +                *(uint16_t *)buffer = ioread16(data_addr);
>>> +                buffer += sizeof(uint16_t);

>> By definition tht is 2. Do you have an ioread16_rep ?

> It appears to be broken.  One would expect ioread16 and ioread16_rep to 
> do endian swapping in the same manner.  On MIPS they do not.

    And that's actually good.

> Perhaps it would be better to fix the problem at the source.

    I don't think there's a problem there. The string versions of the 
functions treat memory as a string of bytes.

>>> +static void octeon_cf_delayed_irq(unsigned long data)
>>> +{

>> What stops the following occuring

>>     ATA irq
>>         BUSY still set
>>         Queue tasklet

>>     Other irq on same line
>>     ATA busy clear
>>         Handle command

    Is CF interrupt indeed shared with anything?

>>     Tasklet runs but command was sorted out

>> (or a reset of the ata controller in the gap)

> Probably nothing.  I will try to sort it out.

    It's the need for the tasklet that seems doubtful to me...

> Thanks,
> David Daney

MBR, Sergei

