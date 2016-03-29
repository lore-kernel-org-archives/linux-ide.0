From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 2/3] ata: ahci-platform: Add ports-implemented dt
 bindings.
Date: Tue, 29 Mar 2016 18:10:03 +0100
Message-ID: <56FAB6EB.6040802@linaro.org>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-3-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_JsqLhSz1qWj01mAAg4X89hb4LnYB-CjJ2d1JW=jJw66Oq=g@mail.gmail.com>
 <56FA947A.5080806@linaro.org>
 <CAL_JsqLR2GFuveVJj9u9RPAyHvgrF=TUPQXFVBH_BO3BXNx_vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34560 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcC2RKH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Mar 2016 13:10:07 -0400
Received: by mail-wm0-f49.google.com with SMTP id p65so149040517wmp.1
        for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2016 10:10:06 -0700 (PDT)
In-Reply-To: <CAL_JsqLR2GFuveVJj9u9RPAyHvgrF=TUPQXFVBH_BO3BXNx_vw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, jmaggard10@gmail.com



On 29/03/16 18:07, Rob Herring wrote:
> On Tue, Mar 29, 2016 at 9:43 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>> On 29/03/16 15:11, Rob Herring wrote:
>>>
>>> On Tue, Mar 29, 2016 at 8:11 AM, Srinivas Kandagatla
>>> <srinivas.kandagatla@linaro.org> wrote:
>>>>
>>>> On some SOCs PORTS_IMPL register value is never programmed by the BIOS
>>>
>>>
>>> s/BIOS/firmware/
>>
>> BIOS is the word used in the AHCI SPECS so want to stick to this.
>
> The spec being Intel's also says it is a PCI device... BIOS is a type
> of firmware.
Ofcourse.
>
> [...]
>
>>>> +       sata0: sata@29000000 { /* Qualcomm APQ8064 */
>>>
>>>
>>> Do you really need another example just for this?
>>>
>>>> +               compatible = "generic-ahci";
>>>
>>>
>>> Where's your chip specific compatible string? You would not require a
>>> DT update to fix this if you had that.
>>
>>
>> Possibly, But we really are not doing anything specific in the ahci driver
>> which is not generic, that might be the reason why we skipped this in the
>> first place.
>>
>> I agree we could solve this issue in more than one way, The only advantage
>> of this new bindings would be to other platforms benefiting from this
>> workaround would not have to keep adding a new compatible string into the
>> ahci-platform driver.
>>
>> Like Annapurna Alpine platform seems to have the same issue.
>>
>> Am ok to do it either way.
>
> I'm saying do both. Adding ports-implemented is fine, but add an SoC
> compatible string (in the dts, not the driver).
That sounds Good, I will add compatible string in DT and implement 
ports-implemented.

--srini
>
> Rob
>
