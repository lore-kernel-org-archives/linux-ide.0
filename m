From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] ata: ahci: add support for DaVinci DM816 SATA controller
Date: Tue, 14 Mar 2017 10:03:35 -0700
Message-ID: <m2wpbraizc.fsf@baylibre.com>
References: <1489422982-3461-1-git-send-email-bgolaszewski@baylibre.com>
        <1489422982-3461-3-git-send-email-bgolaszewski@baylibre.com>
        <db5d21c2-b0e2-c9ec-1f15-460973fd23e3@cogentembedded.com>
        <7ab4b440-f9d0-22fa-f463-f4c5542e21e7@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ab4b440-f9d0-22fa-f463-f4c5542e21e7@baylibre.com> (Neil
        Armstrong's message of "Tue, 14 Mar 2017 10:00:07 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 03/14/2017 09:57 AM, Sergei Shtylyov wrote:
>> Hello!
>> 
>> On 3/13/2017 7:36 PM, Bartosz Golaszewski wrote:
>> 
>>> This SATA controller is quite similar to the one present on the DA850
>>> SoC, but the PHY configuration is different and it supports two HBA
>>> ports.
>>>
>>> The IP suffers from the same PMP issue the DA850 does - if we enable
>>> PMP but don't use it - softreset fails. Appropriate workaround was
>>> implemented in this driver as well.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  drivers/ata/Kconfig      |   9 +++
>>>  drivers/ata/Makefile     |   1 +
>>>  drivers/ata/ahci_dm816.c | 200 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 210 insertions(+)
>>>  create mode 100644 drivers/ata/ahci_dm816.c
>>>
>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>> index 70b57d2..7f59a7a 100644
>>> --- a/drivers/ata/Kconfig
>>> +++ b/drivers/ata/Kconfig
>>> @@ -118,6 +118,15 @@ config AHCI_DA850
>>>
>>>        If unsure, say N.
>>>
>>> +config AHCI_DM816
>>> +    tristate "DaVinci DM816 AHCI SATA support"
>> 
>>    Is it really DaVinci?
>> 
>>> +    depends on ARCH_OMAP2PLUS
>> 
>>    Especially if it depends on OMAP...
>
> Hi Sergei,
>
> Yes it's a DaVinci family SoC, but shares a lot of IPs with the OMAP family.
>

Actually, this is more of an OMAP family, which shares some IP from
DaVinci family

I think in other parts of the kernel, we refer to this as TI 816x
instead of using either DaVinci or OMAP.

Kevin
