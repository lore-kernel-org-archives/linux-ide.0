Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8960C5519F
	for <linux-ide@archiver.kernel.org>; Tue, 17 Nov 2020 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826A1246A5
	for <linux-ide@archiver.kernel.org>; Tue, 17 Nov 2020 16:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cdn4ijPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgKQQPf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:15:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7429 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgKQQPe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2020 11:15:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb3f72a0000>; Tue, 17 Nov 2020 08:15:38 -0800
Received: from [10.2.53.74] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 16:15:32 +0000
Subject: Re: [PATCH v2 3/6] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <thierry.reding@gmail.com>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
 <1605296218-2510-4-git-send-email-skomatineni@nvidia.com>
 <20201116150022.GA1642318@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <4b1d90b7-63e7-8b32-16f8-a1020827f207@nvidia.com>
Date:   Tue, 17 Nov 2020 08:15:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116150022.GA1642318@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605629738; bh=18wsPT8+1d4fVxmKRiuoV3ixoFKxrPxACtJejsOp+Cs=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=cdn4ijPz1qfOZvWGWdxjHT625Z1ufEtVZ9AB32TR8/QeyhoszmT/8P6Iyf9hfSBE4
         aLJFxnC2TKZio3rNBSN49G00embWxfZl6+3nAu0hm2gAiA894An0BYRx+BiivWJOQR
         hNqtCcB2DDnuezHzLKw2QDVb+2zRVctAqVI9nQ4cWhU1SX/0Ko+8+Fh/EFHrim1wDw
         Q2nOr1nu5eBhMRFWs4F3RnfmG+UKOFAm/cMktiRPKX/Z81+DMt5VhH9SeAsu2OFkpf
         eRSKvo521m8Zjdkwii6o3LdQmajp8f5HDs2ag6HIXn7mgga96697oM9BsFd1NM10JV
         B0djcb3m7Vx+w==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 11/16/20 7:00 AM, Rob Herring wrote:
> On Fri, 13 Nov 2020 11:36:55 -0800, Sowjanya Komatineni wrote:
>> This patch converts text based dt-binding document to YAML based
>> dt-binding document.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 137 +++++++++++++++++++++
>>   .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 -------
>>   2 files changed, 137 insertions(+), 44 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dts:27.31-32 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1364: dt_binding_check] Error 2
>
>
> See https://patchwork.ozlabs.org/patch/1400065
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.

Hi Rob,

make dt_binding_check shows other yaml warmings and didn't go thru 
tegra-ahci.yaml even with specifying DT_SHHEMA_FILES

But, When I do dtbs_check, I see
Documentation/devicetree/bindings/processed-schema.json generated and
also it passes for tegra-ahci.yaml


In v1 feedback discussion, you mentioned it should be good if dtbs_check 
passes.

Regards,

Sowjanya

>
