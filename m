Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA4C61DD8
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 03:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FEB22241
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 03:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GZRQqzdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKMDyj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Nov 2020 22:54:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15624 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKMDyi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Nov 2020 22:54:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fae03780000>; Thu, 12 Nov 2020 19:54:32 -0800
Received: from [10.2.50.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 03:54:33 +0000
Subject: Re: [PATCH v1 1/4] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jonathanh@nvidia.com>
References: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
 <1604628968-1501-2-git-send-email-skomatineni@nvidia.com>
 <20201106161122.GB3289870@bogus>
 <f8ba33f1-90fa-a9f0-5834-9de23fc8ad31@nvidia.com>
 <d0a42b1c-8ddc-fc97-c675-70a5b7601580@nvidia.com>
Message-ID: <f7ccb10e-e375-d6a9-78b3-21a9f85a0148@nvidia.com>
Date:   Thu, 12 Nov 2020 19:54:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0a42b1c-8ddc-fc97-c675-70a5b7601580@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605239672; bh=y9M0Fcn36/SC16+7wkHJ4+Z0grI9AV23OMNrrku0Fw8=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=GZRQqzdO5zNyf7+zJteLqdzDboMjcnAztm+r9Mgi8ttmSj3i4UzwepmYd6H78e9cD
         FoRAV+V+Tx1SxrgeMOv1/1HohNwdTXR8BZuBnhgFjzl8YO4jcQVIArEUAVeOkNjPjr
         TklNtxKZa+ASn2JJdXaBTmDE0V2+alQVUqFqDHPh8DUHa0ivvBJ9vql7M2grwnzDWb
         3Kt9wS5Kz9VpCZoM4cN8uq3yAGxOkbzmsnhL07RmLOOljOGxRwCGAsLjoDHolLM5vE
         00xG3VPN1AFKGnl0eCsrOpPNZECxoFXlFOBSlkOLunSqKtd0Px1MiUE7bTV1j7M7Xe
         1DiJrpK4JFUdg==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Rob,

Updated yamllint and dt-schema as well.

When I do make dt_binding_check, I see it failed as=20
processed-schema-examples.json is not generated.
Any idea of what I may be missing?

Also it did not go thru bindings/ata path. Tried with DT_SCHEMA_FILES to=20
tegra-ahci.yaml as well and I see same.
make dt_binding_check=20
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/ata/nvidia,tegra-ahci.y=
aml

LINT=C2=A0=C2=A0=C2=A0 Documentation/devicetree/bindings
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:20:9: [warning]=20
wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:30:9: [warning]=20
wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:33:9: [warning]=20
wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml:3=
7:2:=20
[error] syntax error: expected <block end>, but found '<scalar>' (syntax)
./Documentation/devicetree/bindings/soc/aspeed/xdma.yaml:10:2: [warning]=20
wrong indentation: expected 2 but found 1 (indentation)
./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:=
10:4:=20
[warning] wrong indentation: expected 2 but found 3 (indentation)
./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:=
18:7:=20
[warning] wrong indentation: expected 4 but found 6 (indentation)
./Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml:10:4:=20
[warning] wrong indentation: expected 2 but found 3 (indentation)
./Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml:15:7:=20
[warning] wrong indentation: expected 4 but found 6 (indentation)
./Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml:25:=
10:=20
[warning] wrong indentation: expected 10 but found 9 (indentation)
./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:52=
:9:=20
[warning] wrong indentation: expected 6 but found 8 (indentation)
./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml:32:13:=20
[warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml:35:9:=20
[warning] wrong indentation: expected 10 but found 8 (indentation)
Documentation/devicetree/bindings/Makefile:59: recipe for target=20
'Documentation/devicetree/bindings/processed-schema-examples.json' failed
make[1]: ***=20
[Documentation/devicetree/bindings/processed-schema-examples.json] Error 12=
3
Makefile:1362: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


When I do dtbs_check, I see=20
Documentation/devicetree/bindings/processed-schema.json generated and=20
also it passes for tegra-ahci.yaml

make ARCH=3Darm64 dtbs_check=20
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/ata/nvidia,tegra-ahci.y=
aml

Regards,

Sowjanya


On 11/6/20 9:18 AM, Sowjanya Komatineni wrote:
>
> On 11/6/20 8:41 AM, Sowjanya Komatineni wrote:
>>
>> On 11/6/20 8:11 AM, Rob Herring wrote:
>>> On Thu, 05 Nov 2020 18:16:05 -0800, Sowjanya Komatineni wrote:
>>>> This patch converts text based dt-binding document to YAML based
>>>> dt-binding document.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>> =C2=A0 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 152=20
>>>> +++++++++++++++++++++
>>>> =C2=A0 .../bindings/ata/nvidia,tegra124-ahci.txt=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 44 ------
>>>> =C2=A0 2 files changed, 152 insertions(+), 44 deletions(-)
>>>> =C2=A0 create mode 100644=20
>>>> Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>>>> =C2=A0 delete mode 100644=20
>>>> Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>>>>
>>>
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> Error:=20
>>> Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dts:27.=
31-32=20
>>> syntax error
>>> FATAL ERROR: Unable to parse input tree
>>> make[1]: *** [scripts/Makefile.lib:342:=20
>>> Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dt.yaml=
]=20
>>> Error 1
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [Makefile:1364: dt_binding_check] Error 2
>>>
>>>
>>> See https://patchwork.ozlabs.org/patch/1395390
>>>
>>> The base for the patch is generally the last rc1. Any dependencies
>>> should be noted.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit.
>> Thanks Rob. Will re-try after installing up-to-date.
>
> Somehow running 'make dt_binding_check' gives below error.
>
> I have yamllint newest version (1.2.1-1). Any specific version of=20
> yamllint is needed?
>
> =C2=A0LINT=C2=A0=C2=A0=C2=A0 Documentation/devicetree/bindings
> invalid config: unknown option "max-spaces-inside-empty" for rule=20
> "braces"
> xargs: /usr/bin/yamllint: exited with status 255; aborting
> Documentation/devicetree/bindings/Makefile:59: recipe for target=20
> 'Documentation/devicetree/bindings/processed-schema-examples.json' failed
> make[1]: ***=20
> [Documentation/devicetree/bindings/processed-schema-examples.json]=20
> Error 124
> Makefile:1362: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
