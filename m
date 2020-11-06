Return-Path: <SRS0=A6T3=EM=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C8C2D0A3
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D812151B
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kz+Vx78y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKFQlt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:41:49 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7990 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQlt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2020 11:41:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa57ccb0000>; Fri, 06 Nov 2020 08:41:47 -0800
Received: from [10.2.59.206] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 16:41:48 +0000
Subject: Re: [PATCH v1 1/4] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jonathanh@nvidia.com>
References: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
 <1604628968-1501-2-git-send-email-skomatineni@nvidia.com>
 <20201106161122.GB3289870@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <f8ba33f1-90fa-a9f0-5834-9de23fc8ad31@nvidia.com>
Date:   Fri, 6 Nov 2020 08:41:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106161122.GB3289870@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604680907; bh=S+ZyGe0n3Ifbv9qmefFgqXitVzM6x/t8Npq9Zf+fzd8=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=kz+Vx78yDBHTVI8MI/vZDnK3y345gMOQCgHKWQX9u3KtbTyf8Q71O1eTw7WbJXSL3
         rXWaEqM0HS1JwsaZ1HvIPZjxJLgwUFjofv7O/IP807Z/ISSUgjJo98VbpCtnq3/1v0
         fXqe7GmvLfSDXJNTYIBMshaQk5/RJSPPkZq8hJprjpjud2iTzLtkOzIAcJzdYCg5Co
         8ZJToesE4Z4ptOnmFoskUVuZyFOzxkFLWDjCxKG/O5L+NZJGQyooKo2GOZJxMe44v3
         mOtsXGB0HZH3LpzXHoCCgnATvySChhkAvG8aP1Ah0nggY6fml9XtwyJ4l+WVOe6dFB
         OvOrjaIn+p4vQ==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 11/6/20 8:11 AM, Rob Herring wrote:
> On Thu, 05 Nov 2020 18:16:05 -0800, Sowjanya Komatineni wrote:
>> This patch converts text based dt-binding document to YAML based
>> dt-binding document.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 152 +++++++++++++++++++++
>>   .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
>>   2 files changed, 152 insertions(+), 44 deletions(-)
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
> See https://patchwork.ozlabs.org/patch/1395390
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
Thanks Rob. Will re-try after installing up-to-date.
