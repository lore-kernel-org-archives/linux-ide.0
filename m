From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
Date: Tue, 17 Jun 2014 11:37:49 -0600
Message-ID: <53A07CED.7010503@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1470404.13mIFv0Hnj@amdc1032> <53A0686F.4000303@wwwdotorg.org> <6652229.bPNq3Yp8If@amdc1032> <53A07CA4.7080206@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A07CA4.7080206-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 06/17/2014 11:36 AM, Mikko Perttunen wrote:
> On 06/17/2014 08:04 PM, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi,
>>
>> On Tuesday, June 17, 2014 10:10:23 AM Stephen Warren wrote:
>>> On 06/17/2014 06:14 AM, Bartlomiej Zolnierkiewicz wrote:
>>
>> [...]
>>
>>>>> +static struct platform_driver tegra_ahci_driver = {
>>>>> +    .probe = tegra_ahci_probe,
>>>>> +    .remove = ata_platform_remove_one,
>>>>> +    .driver = {
>>>>> +        .name = "tegra-ahci",
>>>>> +        .owner = THIS_MODULE,
>>>>> +        .of_match_table = tegra_ahci_of_match,
>>>>> +    },
>>>>
>>>> This driver lacks PM suspend/resume support.  I assume that
>>>> the Tegra124 platform also doesn't support suspend/resume yet
>>>> (if so a comment in the driver code about this would be useful),
>>>> otherwise the driver should be fixed.
>>>
>>> We do have basic system suspend/resume support. However, I don't think
>>> missing suspend/resume in an individual driver should stop it from being
>>> merged. It can certainly be added later.
>>
>> There should be at least FIXME in the driver explaining the situation and
>> I would really prefer to have PM support added when the driver is still
>> "hot" (meaning there are people actively working on it) instead of
>> possibly
>> having to chase people months/years later when they have already moved on
>> and are working on something else.  Please also note that adding PM
>> support
>> should be quite simple if the driver is designed correctly.
>
> AFAIK, the deepest level of suspend currently supported on upstream is
> LP1, for which the driver doesn't need to do anything. Only when we go
> to LP0 the driver will need to save/reload registers and stuff.

Yes, it's generally true that no SoC register state is lost during
suspend, only CPU state.
