From: Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Mon, 11 Jan 2016 09:33:21 -0600
Message-ID: <5693CB41.70408@redhat.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <4983521.tEaWggKCCv@wuerfel> <568F14E0.4060107@amd.com>
 <10869853.plxna0HzWE@wuerfel> <5690367E.8060609@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5690367E.8060609-5C7GfCeVMHo@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brijesh Singh <brijesh.singh-5C7GfCeVMHo@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 01/08/2016 04:21 PM, Brijesh Singh wrote:
> Hi,

>> We generally don't refer to register locations with properties other than
>> 'reg', so that approach would be worse. What I'd suggest you do is to
>> have the sgpio registers in a separate device node, and use the LED
>> binding to access it, see
>>
>> Documentation/devicetree/bindings/leds/common.txt
>>
>> It seems that none of the drivers/ata/ drivers use the leds interface
>> today, but that can be added to libata-*.c whenever the appropriate
>> properties are there.
>>
>
> libata-*.c implements the "Enclosure management" style led messages but also has hooks
> to register a custom led control callback. Since Seattle platform does not support
> the "Enclosure management" registers hence ata_port_info we are setting a ATA_FLAG_EM | ATA_FLAG_SW_ACIVITY
> to indicate that we can still handle the led messages by our registered callback. I see
> that sata_highbank driver is doing something similar.

The sata_highbank driver is doing it wrong and shouldn't have been
accepted in its current condition. Enclosure management really should
be a separate device. Please don't use it as an example.

--Mark Langsdorf

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
