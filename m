Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B63C2D0E4
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6FE20717
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RX4SCxVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKWUC5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:02:57 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19239 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgKWUC5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 15:02:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc15760000>; Mon, 23 Nov 2020 12:03:02 -0800
Received: from [10.2.49.186] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:02:55 +0000
Subject: Re: [PATCH v2 3/6] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
 <1605296218-2510-4-git-send-email-skomatineni@nvidia.com>
 <CAL_JsqKkGmRwsv48xdX7xMSEaTSqdEnWuy0E19eohBxJKMywJg@mail.gmail.com>
 <0a6e99c8-9149-8756-3511-d4cb1814d3c6@nvidia.com>
Message-ID: <d6748afc-d4eb-8781-6bde-cacc55f9ea99@nvidia.com>
Date:   Mon, 23 Nov 2020 12:03:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0a6e99c8-9149-8756-3511-d4cb1814d3c6@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606161782; bh=E4fzJxpB2Vipoh16Kg5iiF7fnDXr87x6puFn0ONDXec=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=RX4SCxVEUryV2ywBef7sH1h0DFpBZc6GHUX0VfhgrRyIbRy1dn9iSJUX/Laa0bdCf
         VCJyfibiPdcfzdvwwPqGx/suKotZfRavS4cylnVk2HD6KFpnb1G+3oGGc2ujFIsUvG
         bQSK+cBh+o/S98HxdBh124PdQ8UKZmFh7ADSibtNzVJMYg/MAw+GE+YHnm/s2yxVIe
         swjIEA2MYhOJNcchHGqN3CfT+DseOZGUIWG6mdVQ82IfgmsnvHVUjyy2HluGY6+pbr
         wEGiBcnSbX470o08bXoMBHuTwfZ+f2uhmB0dzURLuFA/3zy7kwuFQoHRpMw+qhqiAu
         NP4X3fQ207KJg==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 11/23/20 11:01 AM, Sowjanya Komatineni wrote:
>
> On 11/20/20 12:17 PM, Rob Herring wrote:
>> On Fri, Nov 13, 2020 at 1:36 PM Sowjanya Komatineni
>> <skomatineni@nvidia.com> wrote:
>>> This patch converts text based dt-binding document to YAML based
>>> dt-binding document.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>> =C2=A0 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 137=20
>>> +++++++++++++++++++++
>>> =C2=A0 .../bindings/ata/nvidia,tegra124-ahci.txt=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 44 -------
>>> =C2=A0 2 files changed, 137 insertions(+), 44 deletions(-)
>>> =C2=A0 create mode 100644=20
>>> Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>>> =C2=A0 delete mode 100644=20
>>> Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>>>
>>> diff --git=20
>>> a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml=20
>>> b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>>> new file mode 100644
>>> index 0000000..dbbe460
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>>> @@ -0,0 +1,137 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/ata/nvidia,tegra-ahci.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Tegra AHCI SATA Controller
>>> +
>>> +maintainers:
>>> +=C2=A0 - Thierry Reding <thierry.reding@gmail.com>
>>> +=C2=A0 - Jonathan Hunter <jonathanh@nvidia.com>
>>> +
>>> +properties:
>>> +=C2=A0 compatible:
>>> +=C2=A0=C2=A0=C2=A0 enum:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nvidia,tegra124-ahci
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nvidia,tegra132-ahci
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nvidia,tegra210-ahci
>>> +
>>> +=C2=A0 reg:
>>> +=C2=A0=C2=A0=C2=A0 minItems: 2
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 3
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: AHCI registers
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: SATA configuration and I=
PFS registers
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: SATA AUX registers
>>> +
>>> +=C2=A0 interrupts:
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
>>> +
>>> +=C2=A0 clock-names:
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sata
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sata-oob
>>> +
>>> +=C2=A0 clocks:
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 2
>>> +
>>> +=C2=A0 reset-names:
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sata
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sata-cold
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sata-oob
>>> +
>>> +=C2=A0 resets:
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 3
>>> +
>>> +=C2=A0 phy-names:
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sata-0
>>> +
>>> +=C2=A0 phys:
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
>>> +
>>> +=C2=A0 hvdd-supply:
>>> +=C2=A0=C2=A0=C2=A0 description: SATA HVDD regulator supply.
>>> +
>>> +=C2=A0 vddio-supply:
>>> +=C2=A0=C2=A0=C2=A0 description: SATA VDDIO regulator supply.
>>> +
>>> +=C2=A0 avdd-supply:
>>> +=C2=A0=C2=A0=C2=A0 description: SATA AVDD regulator supply.
>>> +
>>> +=C2=A0 target-5v-supply:
>>> +=C2=A0=C2=A0=C2=A0 description: SATA 5V power regulator supply.
>>> +
>>> +=C2=A0 target-12v-supply:
>>> +=C2=A0=C2=A0=C2=A0 description: SATA 12V power regulator supply.
>>> +
>>> +required:
>>> +=C2=A0 - compatible
>>> +=C2=A0 - reg
>>> +=C2=A0 - interrupts
>>> +=C2=A0 - clock-names
>>> +=C2=A0 - clocks
>>> +=C2=A0 - reset-names
>>> +=C2=A0 - resets
>>> +
>>> +allOf:
>>> +=C2=A0 - if:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enu=
m:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - nvidia,tegra124-ahci
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - nvidia,tegra132-ahci
>>> +=C2=A0=C2=A0=C2=A0 then:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 2
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - phys
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - phy-names
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - hvdd-supply
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - vddio-supply
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - avdd-supply
>>> +
>>> +=C2=A0 - if:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enu=
m:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - nvidia,tegra210-ahci
>>> +=C2=A0=C2=A0=C2=A0 then:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
>>> +
>>> +additionalProperties: true
>>> +
>>> +examples:
>>> +=C2=A0 - |
>>> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/clock/tegra210-car.h>
>>> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/reset/tegra210-car.h>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sata@70020000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "nvidia,tegra210-ahci";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <0x0 0x70027000 0x0 0x00002000>, /* AHCI */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0 0x70020000 0x0 0x00007000>, /* SATA =
*/
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0 0x70001100 0x0 0x00010000>; /* SATA =
AUX */
>> The default sizes are 1 cell for address and size, so this will give
>> you warnings. You either need to adjust the entries here or add a
>> parent node setting the sizes to 2 cells.
>
> Thanks Rob.
>
> tegra210.dtsi already has address and size set to 2 cells in parent=20
> node of sata.
>
> Do you mean to add parent node and address and size cells set to 2 in=20
> this yaml example as well?

>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=
errupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>> The error is because you need the include files for these defines.
> Will add header file for interrupts in yaml example.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clo=
cks =3D <&tegra_car TEGRA210_CLK_SATA>,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&tegra_car TEGRA210_CL=
K_SATA_OOB>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clo=
ck-names =3D "sata", "sata-oob";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
ets =3D <&tegra_car 124>,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&tegra_car 129>,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&tegra_car 123>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
et-names =3D "sata", "sata-cold", "sata-oob";
>>> +=C2=A0=C2=A0=C2=A0 };

updated reg value with single address and single size along with=20
interrupt header file.

dt_binding_check pass without errors. Will send v3.

