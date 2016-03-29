From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH 2/3] ata: ahci-platform: Add ports-implemented dt bindings.
Date: Tue, 29 Mar 2016 12:07:30 -0500
Message-ID: <CAL_JsqLR2GFuveVJj9u9RPAyHvgrF=TUPQXFVBH_BO3BXNx_vw@mail.gmail.com>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-3-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_JsqLhSz1qWj01mAAg4X89hb4LnYB-CjJ2d1JW=jJw66Oq=g@mail.gmail.com> <56FA947A.5080806@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43098 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbcC2RHy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Mar 2016 13:07:54 -0400
In-Reply-To: <56FA947A.5080806@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, jmaggard10@gmail.com

On Tue, Mar 29, 2016 at 9:43 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 29/03/16 15:11, Rob Herring wrote:
>>
>> On Tue, Mar 29, 2016 at 8:11 AM, Srinivas Kandagatla
>> <srinivas.kandagatla@linaro.org> wrote:
>>>
>>> On some SOCs PORTS_IMPL register value is never programmed by the BIOS
>>
>>
>> s/BIOS/firmware/
>
> BIOS is the word used in the AHCI SPECS so want to stick to this.

The spec being Intel's also says it is a PCI device... BIOS is a type
of firmware.

[...]

>>> +       sata0: sata@29000000 { /* Qualcomm APQ8064 */
>>
>>
>> Do you really need another example just for this?
>>
>>> +               compatible = "generic-ahci";
>>
>>
>> Where's your chip specific compatible string? You would not require a
>> DT update to fix this if you had that.
>
>
> Possibly, But we really are not doing anything specific in the ahci driver
> which is not generic, that might be the reason why we skipped this in the
> first place.
>
> I agree we could solve this issue in more than one way, The only advantage
> of this new bindings would be to other platforms benefiting from this
> workaround would not have to keep adding a new compatible string into the
> ahci-platform driver.
>
> Like Annapurna Alpine platform seems to have the same issue.
>
> Am ok to do it either way.

I'm saying do both. Adding ports-implemented is fine, but add an SoC
compatible string (in the dts, not the driver).

Rob
