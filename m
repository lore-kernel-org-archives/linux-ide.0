From: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/9] Serial ATA support for NVIDIA Tegra124
Date: Fri, 6 Jun 2014 09:27:07 +0300
Message-ID: <53915F3B.6050806@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <5390A8F9.2090408@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5390A8F9.2090408-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

The only compile-time dependencies here should be that:
- patch 8 of 9 which contains the actual driver depends on patch 6 of 9 
(though only when building as a module) and the efuse series
- patch 2 of 9 refers to the DT node called "padctl", so it requires the 
xusb series. (in the submitted xusb series, the node isn't actually 
named, though. I will fix this in v2)

- Mikko

On 05/06/14 20:29, Stephen Warren wrote:
> On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
>> Hi,
>>
>> This series adds support for the onboard AHCI-compliant Serial ATA
>> controller found on Tegra124 systems-on-chip. The controller is
>> enabled on Jetson TK1. The series depends on Peter's efuse series
>> and Thierry's yet to be submitted XUSB pinctrl driver.
>
> This series includes patches to a lot of different subsystems. That will
> complicate applying it.
>
> Can you write a summary of the *compile time* dependencies, since that
> will influence how the patches get merged.
>
> You mentioned that this series depends on efuse and XUSB padctl. Can you
> point out which specific parts of this series depend on which of those
> two other series, and whether this is a compile-time or run-time dependency.
>
> I hope that the drivers/ata patches, drivers/clk patches, DT, and
> defconfig patches can each be applied to their normal tree and don't
> depend on each-other at compile-time at all.
>
> At run-time, obviously all the patches are needed to make the code work,
> but since this is a new feature, it's fine if this all only works once
> everything is merged together in linux-next or Linus's tree.
>
> Thanks.
>
