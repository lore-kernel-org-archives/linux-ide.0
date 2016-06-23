From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v3 2/7] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Thu, 23 Jun 2016 08:40:39 +0200
Message-ID: <576B8467.3060407@samsung.com>
References: <20160608223000.433-1-linz@li-pro.net>
 <20160608223000.433-2-linz@li-pro.net> <20160621150532.GG3302@leverpostej>
 <576A447F.2020002@samsung.com> <576AB746.70509@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <576AB746.70509@li-pro.net>
Sender: linux-leds-owner@vger.kernel.org
To: linz@li-pro.net
Cc: Mark Rutland <mark.rutland@arm.com>, linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Joseph Jezak <josejx@gentoo.org>, Nico Macrionitis <acrux@cruxppc.org>, =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@alea.gnuu.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 06/22/2016 06:05 PM, Stephan Linz wrote:
> Hi Jacek,
>
> Am 22.06.2016 um 09:55 schrieb Jacek Anaszewski:
>> On 06/21/2016 05:05 PM, Mark Rutland wrote:
>>> On Thu, Jun 09, 2016 at 12:29:37AM +0200, Stephan Linz wrote:
>>>> Cc: Joseph Jezak <josejx@gentoo.org>
>>>> Cc: Nico Macrionitis <acrux@cruxppc.org>
>>>> Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
>>>> Signed-off-by: Stephan Linz <linz@li-pro.net>
>>>> ---
>>>>    Documentation/devicetree/bindings/leds/common.txt    | 2 +-
>>>>    Documentation/devicetree/bindings/leds/leds-gpio.txt | 2 +-
>>>>    Documentation/laptops/asus-laptop.txt                | 2 +-
>>>>    Documentation/leds/leds-class.txt                    | 2 +-
>>>>    4 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/common.txt
>>>> b/Documentation/devicetree/bindings/leds/common.txt
>>>> index af10678..1e97169 100644
>>>> --- a/Documentation/devicetree/bindings/leds/common.txt
>>>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>>>> @@ -26,7 +26,7 @@ Optional properties for child nodes:
>>>>         "default-on" - LED will turn on (but for leds-gpio see
>>>> "default-state"
>>>>                property in
>>>> Documentation/devicetree/bindings/gpio/led.txt)
>>>>         "heartbeat" - LED "double" flashes at a load average based=
 rate
>>>> -     "ide-disk" - LED indicates disk activity
>>>> +     "disk-activity" - LED indicates disk activity
>>>>         "timer" - LED flashes at a fixed, configurable rate
>>>
>>> We should not break the binding.
>>>
>>> Code must continue to support "ide-disk", though we can mark it
>>> deprecated in the binding documentation, and update the in-kernel d=
ts
>>> files to use "disk-activity".
>>
>> The code in the version 4 of the patchset supports also "ide-disk".
>>
>> Stephan, could you send a new version of this patch, with preserved
>> "ide-disk" property, marked as deprecated?
>
> Yes, I can. I'll submit a new v5 patch set. You can pick out then the
> right patch for the LED for-next branch, okay?

You don't need to submit whole patch set, only the affected patch.

--=20
Best regards,
Jacek Anaszewski
