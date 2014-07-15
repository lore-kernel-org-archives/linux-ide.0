From: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 6/7] ata: Add support for the Tegra124 SATA controller
Date: Tue, 15 Jul 2014 12:03:40 +0300
Message-ID: <53C4EE6C.4010603@nvidia.com>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com> <1403101406-15439-7-git-send-email-mperttunen@nvidia.com> <20140708132216.GA4979@htj.dyndns.org> <53C3DCF0.3030001@redhat.com> <53C4D472.9010507@nvidia.com> <53C4EC81.1040304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53C4EC81.1040304-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On 15/07/14 11:55, Hans de Goede wrote:
> Hi,
>
> On 07/15/2014 09:12 AM, Mikko Perttunen wrote:
>> Heh, what you are describing is the v1 of this series :)
>>
>> However,
>>
>> 17/06/14 Thierry Reding wrote:
>>> I would've preferred tegra_powergate_sequence_power_up() to be used
>>> consistently in all drivers. I'm still not convinced that using the
>>> platform AHCI driver this way is really the best option, since we're
>>> bending over backwards to fit into what this driver dictates. There
>>> shouldn't be a need for that.
>>
>> As you probably noticed, the issue is that on Tegra we want to use tegra_powergate_sequence_power_up to enable the SATA power rail. That function assumes that it gets a disabled clock and returns with the clock enabled. If we use ahci_platform's resource management functions,
>> this is not doable, since it wants to handle clocks by itself.
>
> Right, note I was not suggesting that you use ahci_platform_enable_resources /
> ahci_platform_disable_resources, that clearly won't work for your case.
>
> As I said "I can see there are good reasons for that though."
>
>> To be honest, I too would prefer handling the resources in the driver. The driver needs other resources than what ahci_platform currently manages (at least reset_controls and multiple regulators, later we might get more) and managing them in the driver allows the driver to do proper error handling and manage all resources consistently and in one place. Also, I don't think it is sensible to add support for loading every possible kind of DT resource to ahci_platform, since most drivers won't need them.
>
> Actually I have considered asking you to add support for reset controllers
> to libahci_platform too, since I see a pattern where more and more
> SOCs are starting to use those. I've refrained from asking that for now,
> but once a second ahci implementation needing those pops up we will likely
> go that route. So you might as well do it now :)
>
>> Other subsystems I've been in don't have this kind of helper library, so diverging here seems weird.
>
> Well the usb uhci-platform and ehci-platform drivers are doing the same,
> what we're trying to do here is avoid needless code duplication and
> if possible (for ehci and uhci it currently is) make it so that adding
> support for a new soc only requires adding dt stuff + a phy driver,
> without touching the ?hci code at all. Again I can see that this
> is not possible for the Tegra124.
>
>> That said, if you feel strongly about this, I can do what you described.
>
> I think you can safe a nice bit of code duplication (and if we ever find
> we have bugs there bug duplication) by switching to
> ahci_platform_get_resources, as described in my original mail.
>
> I can understand if you don't want to use any of the other ahci_platform_*
> functions, that makes total sense.
>
> I would not say this is something you must do, but I have a strong
> preference for you taking a shot at doing this. So can you please give
> this a try, and if it turns out to become ugly, just say so (with
> some explanation), and then you can keep things as is.
> Does that work for you?
>
> Regards,
>
> Hans
>

Sure, I'll have a go at it. I already sent one bugfix for 
libahci_platform anyway :)

Mikko
