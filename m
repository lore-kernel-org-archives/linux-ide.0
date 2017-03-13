From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] dt-bindings: ata: add DT bindings for ahci-dm816 SATA
 controller
Date: Mon, 13 Mar 2017 20:27:34 +0300
Message-ID: <61ee23f2-734b-f793-0054-364ce553ae5e@cogentembedded.com>
References: <1489422982-3461-1-git-send-email-bgolaszewski@baylibre.com>
 <1489422982-3461-2-git-send-email-bgolaszewski@baylibre.com>
 <2d0ede95-86d6-4d52-6cf5-91de35a29145@cogentembedded.com>
 <CAMpxmJUO65yZDSKhL2k1V1fYRFn3psfCtwokbsZAm61UzcdjSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36784 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbdCMR1j (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2017 13:27:39 -0400
Received: by mail-lf0-f41.google.com with SMTP id y193so66563178lfd.3
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2017 10:27:38 -0700 (PDT)
In-Reply-To: <CAMpxmJUO65yZDSKhL2k1V1fYRFn3psfCtwokbsZAm61UzcdjSg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, linux-ide@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 03/13/2017 08:08 PM, Bartosz Golaszewski wrote:

>>> Add DT bindings for the onboard SATA controller present on the DM816x
>>> SoCs.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  Documentation/devicetree/bindings/ata/ahci-dm816.txt | 20
>>> ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/ata/ahci-dm816.txt
>>> b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
>>> new file mode 100644
>>> index 0000000..b87ed5a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
>>> @@ -0,0 +1,20 @@
>>> +Device tree binding for the TI DM816 AHCI SATA Controller
>>> +---------------------------------------------------------
>>> +
>>> +Required properties:
>>> +  - compatible: must be "ti,dm816-ahci"
>>> +  - reg: physical base address and size of the register region used by
>>> +         the controller (as defined by the AHCI 1.1 standard)
>>> +  - interrupts: interrupt specifier (refer to the interrupt binding)
>>> +  - clocks: clock specifiers (refer to the clock binding); two clocks
>>
>>
>>    There should be a phandle preceding the clock specifier, all new such
>> props are different to the old "interrupts" (which had phandle in a separate
>> "interrupt-parent" prop).

> I'm afraid I don't understand - could you point me to an example?

    Have you read Documentation/devicetree/bindings/clock/clock-bindings.txt, 
on clock consumers?
    In fact, your own example below doesn't have clock specifiers, only phandles.

>>> +            must be specified: the functional clock and an external
>>> +            reference clock
>>> +
>>> +Example:
>>> +
>>> +       sata: sata@4a140000 {
>>> +               compatible = "ti,dm816-ahci";
>>> +               reg = <0x4a140000 0xffff>;
[...]
>>> +               interrupts = <16>;
>>> +               clocks = <&sysclk5_ck>, <&sata_refclk>;
>>> +       };
>>>

> Thanks,
> Bartosz Golaszewski

MBR, Sergei

