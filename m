From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2] ata: pata_at91.c bugfix for high master clock
Date: Mon, 13 Dec 2010 14:02:36 +0300
Message-ID: <4D05FD4C.9040200@ru.mvista.com>
References: <1292099846-24528-1-git-send-email-plyatov@gmail.com>	 <4D04D2E2.20100@ru.mvista.com> <1292180579.8737.12.camel@homepc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292180579.8737.12.camel@homepc>
Sender: linux-kernel-owner@vger.kernel.org
To: plyatov@gmail.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com, nicolas.ferre@atmel.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, christian.glindkamp@taskit.de, ryan@bluewatersys.com, pgsellmann@portner-elektronik.at
List-Id: linux-ide@vger.kernel.org

Hello.

On 12-12-2010 22:02, Igor Plyatov wrote:

>>> The AT91SAM9 microcontrollers with master clock higher then 105 MHz
>>> and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
>>> lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and driver
>>> does not detect ATA device.
>>
>>> Signed-off-by: Igor Plyatov<plyatov@gmail.com>
>> [...]

> Please use more descriptive comments, because it is not clear what you
> mean here. Maybe here you just cut a text...

    Exactly, this is how I mark the cut out text.

> It is so strange to cut such small amount of text and I does not have
> any idea why here is "[...]" exists.

    Well, it's still better than leaving large patches quoted and uncommented, 
having only one comment at the top, as some people do. :-)

>>> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
>>> index 0da0dcc..a462405 100644
>>> --- a/drivers/ata/pata_at91.c
>>> +++ b/drivers/ata/pata_at91.c
>> [...]

> The same as above. Nobody are able to read you mind on the distance :-)

    It's the first time anybody tried to iterpret my [...] marks as comments. :-)

>>> @@ -50,7 +52,7 @@ struct at91_ide_info {
>>>    };
>>>
>>>    static const struct ata_timing initial_timing =
>>> -	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
>>> +	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 0, 600, 0};

>>      BTW, you haven't described this in the changelog...

> Here is just a typo fixed for the ata_timing structure. This typo does
> not have influence on the driver operation, but I do not like to leave
> such a negligible problem as it is.

   You at least should have noted that in the changelog. And as the change is 
unrelated to the other changes you're doing, it's a good practice to put it 
into a separate patch.

>> WBR, Sergei

> Best regards!
> --
> Igor Plyatov

WBR, Sergei
