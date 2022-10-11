Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6774C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 11 Oct 2022 00:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJKAcs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJKAcr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Oct 2022 20:32:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958F34726
        for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2022 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665448365; x=1696984365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wbBoM/ypBEzFY964AkUzk+moOrdT7ns8qck6FyAwZO4=;
  b=QftD3jrte1STp1R7tJTZo/rlsnbS7XfqWTWw0IRBNVpt3zM+zHTvzspX
   QzGfWrD1HMs6DdSoJxOD9jwkFR3/+aWMuRy9ky/V7C4JWFelJVDXfPehk
   vm5B9eH4IGqggRQGNzpwvLeuyDUCHnhcarKjND6zKG7jnH64K/fW4bXzl
   5vz0/SkDh5oxaLUv2gpb5t/rApX2L7W1/s3ooGldIkbrQjP9vJ5dYlCod
   5aYCCvX/G/GiVGqCNmCzpBX3dONErHc7br1NuKyEzrqqOot5J8m4Yar2g
   qpvXVhsKeZeyRdOPy6gk/QkapqSCAQHbxx/u7I+XalFqJRX7JCb7Btr35
   A==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661788800"; 
   d="scan'208";a="213841939"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2022 08:32:39 +0800
IronPort-SDR: PUZTTrl3Dei9aWaFoifb5JoAN6DVdJNua2VaLcwLMMxsqLr2x0zjp8NTrMSkVAykq/Rm5JgGpz
 TX36/jEBEgTu8WE2nuj7bVQ0eDj2/ZvybIaRzAHPrp1PkiH1Ydgte1cx8rcwOjfWxf98vJ9O8f
 vhRB7Hdmzvo5t6zCEtETg78q4JC7owYr+7Nrpg8wvrZy0f3Da1/5ZdN+x+5ufPkR7LhLJJLW44
 iLqxc2qgPIeXsBXW3nUNbwU/4ZgVJkMIo6rhERlOtyhLFzproqK5F/ce517oBEqioLE9AWDNHR
 863992IubuMfQwPqDtRsGRvX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2022 16:52:19 -0700
IronPort-SDR: 2lGvLpF9mjUffP62mvj+7r8v82b/A7c/Xl3+IHu21jKJ/jmcEoW2vKyIE8ce5etgzEHwPw0Z0k
 y1B8XGbOPy5bTIQrJI1nDCxK7RINOiBFAeP1umxZdf3n4sCdZsMQgfHwGrqc56GywogM7qml/R
 kSIUOZJuUU25Zcz1HuxCgJfKw2Lk4XyN1FIjH+uOH8V7aj+lShJtDhzSECl/ShndNkDV+01j0I
 Pr9nYKXsue2Y/zYDPwaNnvaSk5c8tnvDjdcTXa4dC9nndN9kfagxuAfTlKYAoDlJrG/HSAOoyh
 oDc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2022 17:32:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MmcF3139Lz1RwqL
        for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2022 17:32:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665448358; x=1668040359; bh=wbBoM/ypBEzFY964AkUzk+moOrdT7ns8qck
        6FyAwZO4=; b=F29rzSWDSboIjisF2ooNDBT1YD6NoFEoZQWb6UrtPU4ADW9wBaG
        pwv0eFr9pkwFI1KBKVeRIDceIGbyOBVrmedQN9FcQ4FYP5gHmcQawQkcudG93oSO
        5AhTaEvRWNo7D80I680M4CoNuWFNXVMTyoOdYf0XxeR4YO7GzWLqL8OpBZa4zUfl
        JPixh4U3+Uhc89A8WbvorOGVfLk2snboisxjyysYEUEuaQkDqSkRRKZLgTKSfbws
        52wEgMqIBqwU7YHAXGB7nCLoQavfv7/jOUWeKSztEy/+fwS9NtF/qDjoI1exNq2n
        bsH7kRoflmAy42z5eKPa6QoKoNYkrIUC1lA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZWQEQpWpywhZ for <linux-ide@vger.kernel.org>;
        Mon, 10 Oct 2022 17:32:38 -0700 (PDT)
Received: from [10.89.80.30] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MmcF15sP1z1RvLy;
        Mon, 10 Oct 2022 17:32:37 -0700 (PDT)
Message-ID: <24e3c137-46fa-b70e-4012-f233781835ae@opensource.wdc.com>
Date:   Tue, 11 Oct 2022 09:32:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH 1/4] ata: add ata_port_is_frozen() helper
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-2-niklas.cassel@wdc.com>
 <2d3253f5-c14a-67b2-0ce3-68ba1e332664@huawei.com>
 <Y0PxS6OGiipR3OqO@x1-carbon>
 <071c9e57-1ec3-30cd-87fe-d694249f8b83@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <071c9e57-1ec3-30cd-87fe-d694249f8b83@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/10/10 20:22, John Garry wrote:
> On 10/10/2022 11:17, Niklas Cassel wrote:
> 
> Hi Niklas,
> 
>> Well, right now there is no consistency:)
>>
>> $ git grep "static inline" include/linux/libata.h | grep "(const struct"
>> include/linux/libata.h:static inline bool ata_port_is_frozen(const struct ata_port *ap)
>> include/linux/libata.h:static inline int ata_acpi_stm(const struct ata_port *ap,
>> include/linux/libata.h:static inline int ata_acpi_gtm(const struct ata_port *ap,
>> include/linux/libata.h:static inline bool ata_is_host_link(const struct ata_link *link)
>> include/linux/libata.h:static inline bool ata_is_host_link(const struct ata_link *link)
>> include/linux/libata.h:static inline unsigned int ata_dev_enabled(const struct ata_device *dev)
>> include/linux/libata.h:static inline unsigned int ata_dev_disabled(const struct ata_device *dev)
>> include/linux/libata.h:static inline unsigned int ata_dev_absent(const struct ata_device *dev)
>> include/linux/libata.h:static inline int ata_link_max_devices(const struct ata_link *link)
>> include/linux/libata.h:static inline int ata_try_flush_cache(const struct ata_device *dev)
>>
>> There are 10 uses (9 without my addition) that uses a const struct pointer.
> 
> I was just checking *ata_port, and based my judgement on that one.
> 
>>
>> So since both are used in libata, I chose the one that seemed most correct.
>>
>>> Indeed, this is not const data which you're pointing at, so maybe it's
>>> better to be honest with the compiler. And since this is inlined, could the
>>> compiler optimise out multiple reads on ap->flags in a caller function since
>>> we tell it it's const?
>> "This is not const data which you're pointing at"
>>
>> Well, according to 6.7.6.1 Pointer declarators in
>> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
>>
>> A "const struct *ptr" means that the contents of any object pointed to
>> cannot be modified through that pointer.
>>
> 
> sure
> 
>>
>> "And since this is inlined, could the compiler optimise out multiple reads
>> on ap->flags in a caller function since we tell it it's const?"
>>
>> I'm far from a compiler expert, but because an optimising compiler is free
>> to inline whatever function it wants, not just functions marked inline,
>> I would assume that the compiler would "do the right thing" regardless if
>> a function is marked as inline or not.
>>
>> Doing a:
>> git grep "static inline" include/ | grep "(const struct" | wc -l
>> 2055
>>
>> Makes me quite confident that this should be fine.
>> Sure, the data it points to might never change.
>>
>> But seeing e.g.:
>> $ git grep "static inline" include/ | grep "empty(const struct"
>>
>> Especially used in tcp and qdisc makes me even more confident that this
>> will work fine.
> 
> yeah, I think it should be fine, as the compiler should treat 
> ata_port_is_frozen() as self-contained and thus make no judgement 
> optimizing out such reads when inlining.
> 
>>
>> Looking at e.g. __dev_xmit_skb():
>> https://elixir.bootlin.com/linux/v6.0/source/net/core/dev.c#L3803
>> we can see that it uses nolock_qdisc_is_empty() multiple times within
>> the same function. So now I'm very confident that this will be fine:)
> 
> I'm still not inclined to add const specifier, but I'll leave that to 
> Damien and you.

Given that this helper is clearly intends to only read the port flags, I am fine
with the const argument, even though I think this will not buy us anything from
the compiler given the simplicity of the function :)

-- 
Damien Le Moal
Western Digital Research

