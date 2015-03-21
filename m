From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom STB
 SoCs
Date: Sat, 21 Mar 2015 10:09:52 +0100
Message-ID: <550D3560.8070802@redhat.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com> <1426728222-8197-4-git-send-email-computersforpeace@gmail.com> <550CA6F8.7080504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <550CA6F8.7080504@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 21-03-15 00:02, Florian Fainelli wrote:
> On 18/03/15 18:23, Brian Norris wrote:
>> Supports up to two ports which can each be powered on/off and configured
>> independently.
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>> ---
>
> [snip]
>
>> +
>> +static const struct of_device_id brcmstb_sata_phy_of_match[] = {
>> +	{ .compatible	= "brcm,bcm7445-sata-phy" },
>
> The binding document specifies "brcm,phy-sata3" as a fallback compatible
> string, so we want to match it here.

Erm no we do not, what if another sata3 brcm phy comes along which
is not compatible, both would use "brcm,phy-sata3" as fallback / for
informational purposes, but we do not want this driver to be binding
to that other phy, which it would do with your suggestion.

Regards,

Hans
