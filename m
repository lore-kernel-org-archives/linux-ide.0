From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 05/14] ARM: davinci: da850: add con_id for the SATA clock
Date: Fri, 27 Jan 2017 10:55:07 +0100
Message-ID: <CAMpxmJXq-XZBhO3j=bHpfU2QjJ+6kiYcozS7-pVu3W4juNTVBw@mail.gmail.com>
References: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
 <1485190856-4711-6-git-send-email-bgolaszewski@baylibre.com>
 <93a3bbb3-2d9f-bc38-c7b4-5eb3325d985d@ti.com> <645778dd-6727-abd0-3dd9-a7e0d5aa4983@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <645778dd-6727-abd0-3dd9-a7e0d5aa4983-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arm-soc <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

2017-01-26 18:40 GMT+01:00 Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>:
> On Thursday 26 January 2017 10:26 PM, Grygorii Strashko wrote:
>>
>>
>> On 01/23/2017 11:00 AM, Bartosz Golaszewski wrote:
>>> The ahci-da850 SATA driver is now capable of retrieving clocks by
>>> con_id. Add the connection id for the sysclk2-derived SATA clock.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>> ---
>>>  arch/arm/mach-davinci/da850.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>>> index 1d873d1..dbf1daa 100644
>>> --- a/arch/arm/mach-davinci/da850.c
>>> +++ b/arch/arm/mach-davinci/da850.c
>>> @@ -571,7 +571,7 @@ static struct clk_lookup da850_clks[] = {
>>>      CLK("spi_davinci.0",    NULL,           &spi0_clk),
>>>      CLK("spi_davinci.1",    NULL,           &spi1_clk),
>>>      CLK("vpif",             NULL,           &vpif_clk),
>>> -    CLK("ahci_da850",               NULL,           &sata_clk),
>>> +    CLK("ahci_da850",       "sata",         &sata_clk),
>>
>> I'm worry a bit - wouldn't this cause future problems with PM runtime
>>  (if it will be the case)?
>>
>> If this is functional clock - shouldn't it be "fck" to
>> follow PM domain con_id list for davinci?  (arch/arm/mach-davinci/pm_domain.c)
>
> I agree with Grygorii. Calling this clock "fck" will make it easy to
> convert the DA850 AHCI driver to use pm_runtime at a future date (no
> mach-davinci changes should be needed).
>
> Sorry about not spotting this earlier.
>

Hi Sekhar,

I'll wait with sending v7 until we get an ack from Rob for the
ahci-da850 bindings, so that we don't fall to the bottom of the review
queue again.

Thanks,
Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
