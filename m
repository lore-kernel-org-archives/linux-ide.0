Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148BBEB64D8
	for <linux-ide@archiver.kernel.org>; Thu, 15 Jun 2023 00:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjFOAtq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 14 Jun 2023 20:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFOAtp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jun 2023 20:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939A1BE3;
        Wed, 14 Jun 2023 17:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4534A6125A;
        Thu, 15 Jun 2023 00:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E07C433C0;
        Thu, 15 Jun 2023 00:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686790183;
        bh=jINt6zP8j0KPwm3QNGyIB+T36vd5weBGWcv1oySUb8g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fFpIjYpUsicc3z46XQMXfbVOP0rxoZ3ciubuvOafCo/l5bUinIOJA9RqQgN5V7nvo
         T0eCcD+/NJNUNBGMBCGaZ6mKmlLKLkKgSfGXC97BrRoPDzC7TvsxPacpAs7AJRwrh7
         e4n4DYjgSNNNF6vPg6ly9QEr1srJ5XLyomtHebBfrbrkoFYr440llKSUrnLFgFXSKz
         M8lLZYyMgEN01ii/jJo3LsonGsqfadA+Rl6U6S8EXA8Df/PxhnIStnPAluZdxSskA7
         jC2KbdNyvYDsO+K2qv4uW04b7Qcwf87tzy9zKmkEq6SXltvrQtC72xpXXZyxJXsBpd
         kR2CxZaNXzbOA==
Message-ID: <7276875c-d330-cbd4-ccfc-e7e16bedcaaa@kernel.org>
Date:   Thu, 15 Jun 2023 09:49:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 25/43] dt-bindings: ata: Add Cirrus EP93xx
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-7-nikita.shubin@maquefel.me>
 <fe8bfbfc-0ce5-d4ea-a2a8-8608fe4e2f97@kernel.org>
 <20230614190030.GA2547354-robh@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230614190030.GA2547354-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/15/23 04:00, Rob Herring wrote:
> On Fri, Jun 02, 2023 at 08:57:37AM +0900, Damien Le Moal wrote:
>> On 6/1/23 14:45, Nikita Shubin wrote:
>>> Add YAML bindings for ep93xx SoC PATA.
>>>
>>> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>>> ---
>>>
>>> Notes:
>>>     v0 -> v1:
>>>     
>>>     - renamed file to ep9312-pata
>>
>> Looks OK to me but given that this is both for the cirrus,ep9315-pata and
>> cirrus,ep9312-pata, wouldn't it be better to name the file
>> cirrus,ep931x-pata.yaml ?
> 
> cirrus,ep9312-pata makes sense given that is the common fallback.
> 
> Wildcards are okay in filenames (only) when there's not a common 
> fallback.

Got it.

> 
>>>     - changed email to dlemoal@kernel.org
>>>     - dropped label
>>>     - fixed ident
>>>
>>>  .../bindings/ata/cirrus,ep9312-pata.yaml      | 44 +++++++++++++++++++
>>>  1 file changed, 44 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
>>> new file mode 100644
>>> index 000000000000..3489be55a6fe
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
>>> @@ -0,0 +1,44 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/ata/cirrus,ep9312-pata.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Cirrus Logic EP9312 PATA controller
>>> +
>>> +maintainers:
>>> +  - Damien Le Moal <dlemoal@kernel.org>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: cirrus,ep9312-pata
>>
>> I am not a DT specialist, but isn't this line superfluous since it is listed in
>> the items ?
> 
> No, this entry is for ep9312. The next entry is for ep9315 which is 
> compatible with ep9312 version. The cirrus,ep9315-pata is there in case 
> a distinction (e.g. quirk/errata) needs to be made by the driver 
> without having to change the DT.

Thanks for all the clarification.

Looks good then.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

I can take this patch through the ata tree, but it may be better to have it with
the entire series (arm tree ?)

-- 
Damien Le Moal
Western Digital Research

