From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v5 00/14] ARM: da850-lcdk: add SATA support
Date: Fri, 20 Jan 2017 19:52:35 +0530
Message-ID: <f9055043-507f-74de-b2b8-9eb0eae5dad6@ti.com>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
 <20170120132843.GA31487@mtj.duckdns.org>
 <86bcbb3c-87e4-3508-f4a6-26529f39d374@ti.com>
 <CAMpxmJUPh9MZKwG6k6p_mo6niXNNT02JCDgXi4DPRH2Fk3yxng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:38256 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdATOZt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 09:25:49 -0500
In-Reply-To: <CAMpxmJUPh9MZKwG6k6p_mo6niXNNT02JCDgXi4DPRH2Fk3yxng@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Tejun Heo <tj@kernel.org>, Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>, linux-ide@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>

On Friday 20 January 2017 07:32 PM, Bartosz Golaszewski wrote:
> 2017-01-20 14:56 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>> Hi Tejun,
>>
>> On Friday 20 January 2017 06:58 PM, Tejun Heo wrote:
>>> On Fri, Jan 20, 2017 at 12:21:51PM +0100, Bartosz Golaszewski wrote:
>>>> This series contains all the changes necessary to make SATA work on
>>>> the da850-lcdk board.
>>>>
>>>> The first patch adds DT bindings for the ahci-da850 driver.
>>>>
>>>> The second enables relevant modules in davinci_all_defconfig.
>>>>
>>>> Patches 03/14-06/14 modify the way the clocks are handled regarding
>>>> SATA on the da850 platform. We modify the ahci driver to retrieve
>>>> the clock via con_id and model the external SATA oscillator as
>>>> a real clock.
>>>>
>>>> Patches 07/14-11/14 extend the ahci-da850 driver. Add DT support,
>>>> implement workarounds necessary to make SATA work on the da850-lcdk
>>>> board and un-hardcode the external clock multiplier.
>>>
>>> Please feel free to add
>>>
>>>  Acked-by: Tejun Heo <tj@kernel.org>
>>>
>>> to the all libata patches.  Please let me know how the patches should
>>> be routed once other parts are settled.
>>
>> I believe you can queue the libata patches independently (patches 1, 4,
>> 7, 8, 9, 10, 11). It looks like they have been written such that driver
>> continues to work with existing platform code (Bartosz, please disagree
>> if I am wrong). 1/14 still needs the ack from DT maintainers.
>>
> 
> Patch 11/14 depends on 06/14. Other than that I think it should work
> independently.

Ah, right. You recently changed 11/14 to error out in case refclkpn is
not found instead of using a default value (do agree that current
version is better).

If there are no build time dependencies still, it might be okay to queue
these patches through their respective maintainer trees.

Tejun, I am open to queuing the driver changes through ARM-SoC. I guess
with that there is little chance that SATA will be broken on linux-next
for a longish period of time.

I have Cced the ARM-SoC maintainers too.

Thanks,
Sekhar
