From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 03/10] devicetree: bindings: add bindings for ahci-da850
Date: Mon, 16 Jan 2017 15:30:35 +0100
Message-ID: <CAMpxmJW9ns-aG=4zYHcV5-2b_TdmJ7q+Ap1jdyoxstZjWYRL2A@mail.gmail.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-4-git-send-email-bgolaszewski@baylibre.com>
 <35ff358d-9b17-b2be-38d8-6a51cdddc1a1@lechnology.com> <CAMpxmJUau9BgAOhacPvcA=NwyE6-yEfDgPdcCZ_JCuNH-amJSA@mail.gmail.com>
 <d8406f53-b97d-ca9a-f7d1-94ce5b7064f7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d8406f53-b97d-ca9a-f7d1-94ce5b7064f7-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arm-soc <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

2017-01-16 13:45 GMT+01:00 Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>:
> On Monday 16 January 2017 03:43 PM, Bartosz Golaszewski wrote:
>> 2017-01-13 20:25 GMT+01:00 David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>:
>>>
>>> A clock multiplier property seems redundant if you are specifying a clock.
>>> It should be possible to get the rate from the clock to determine which
>>> multiplier is needed.
>>>
>>
>> I probably should have named it differently. This is not a multiplier
>> of a clock derived from PLL0 or PLL1. Instead it's a value set by
>> writing to the Port PHY Control Register (MPY bits) of the SATA
>> controller that configures the multiplier for the external low-jitter
>> clock. On the lcdk the signals (REFCLKP, REFCLKN) are provided by
>> CDCM61001 (SATA OSCILLATOR component on the schematics).
>>
>> I'll find a better name and comment the property accordingly.
>>
>> FYI: the da850 platform does not use the common clock framework, so I
>> don't specify the clock property on the sata node in the device tree.
>> Instead I add the clock lookup entry in patch [01/10]. This is
>> transparent for AHCI which can get the clock as usual by calling
>> clk_get() in ahci_platform_get_resources().
>
> I think David's point is that the SATA_REFCLK needs to be modeled as a
> actual clock input to the IP. You should be able to get the rate using
> clk_get_rate() and make the MPY bits calculation depending on the
> incoming rate.
>
> You should be able to model the clock even when not using common clock
> framework.
>
> DA850 AHCI does not use a con_id at the moment (it assumes a single
> clock), and that needs to change.
>

It's true that once davinci gets ported (is this planned?) to using
the common clock framework, we could just create a fixed-clock node in
da850-lcdk for the SATA oscillator, so the new property is redundant.

What I don't get is how should I model a clock that is not
configurable and is board-specific? Is hard-coding the relevant rate
in da850.c with a huge FIXME the right way?

Thanks,
Bartosz Golaszewski
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
