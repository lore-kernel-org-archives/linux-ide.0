Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FA1EB64D7
	for <linux-ide@archiver.kernel.org>; Thu, 22 Jun 2023 00:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFVA6B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Jun 2023 20:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFVA6A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2023 20:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B125C197;
        Wed, 21 Jun 2023 17:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF5A6170C;
        Thu, 22 Jun 2023 00:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92CEC433C0;
        Thu, 22 Jun 2023 00:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687395478;
        bh=rl7aE5zjrpdFh/FV8FWti9DyzqLM7tTEITuOKV9aifg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JWS+rMI4kBeMiu3VTbU6MlapmgGem3F6yFMgEl1wMaFybeTtEvK4BB18+XHTtVFtc
         t0j2Rx/ZWzA5pVsMZnqYCWrpQYISPJx33i8br7Fz9ENWx5qRjwmbeeoUu9Cqc5P/Rb
         Qonvmg1y9GH6eG02x9mAofIT/JsWvhIV/X+pzk66+dsXZYRCKTrGykZx8tgqQcOMrY
         /H3L8WcIJD0BMzH3u/SBUDB/i+KsEG6JRuLd5Fxr56T4iTac2LO2dBS4jvE5WXu74L
         bOqveQjk3hOKs/6OIkeai31UPJDgJQRIUp7X2t6qUzZ7zGDt8ptOyoSu+Y5stOx/Oo
         8fqgIE607LxHg==
Message-ID: <feef6589-d0d6-8e64-fefd-914c234dcfba@kernel.org>
Date:   Thu, 22 Jun 2023 09:57:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614173633.2430653-1-robh@kernel.org>
 <20230614173633.2430653-2-robh@kernel.org>
 <23325977-ba37-4360-afb5-4ab38a66107e@roeck-us.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <23325977-ba37-4360-afb5-4ab38a66107e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/22/23 01:51, Guenter Roeck wrote:
> On Wed, Jun 14, 2023 at 11:36:33AM -0600, Rob Herring wrote:
>> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
>> allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
>> so other arches can't be enabled.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Tested on allmodconfig build. Not sure if there's other MIPS configs 
>> where this doesn't work. We'll see what 0-day says.
> 
> Odd, in next-20230621 I get:
> 
> Building mips:allmodconfig ... failed

Indeed odd. Given that this is an allmodconfig, I would assume that
CONFIG_CAVIUM_OCTEON_SOC is set ?

> --------------
> Error log:
> ERROR: modpost: "__udivdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
> ERROR: modpost: "octeon_get_io_clock_rate" [drivers/ata/pata_octeon_cf.ko] undefined!
> ERROR: modpost: "__tracepoint_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
> ERROR: modpost: "__traceiter_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
> ERROR: modpost: "__divdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
> make[2]: [scripts/Makefile.modpost:144: Module.symvers] Error 1 (ignored)
> make[2]: *** No rule to make target 'kernel/locking/locktorture.ko', needed by '__modfinal'.  Stop.
> make[1]: [Makefile:1933: modules] Error 2 (ignored)
> 
> Guenter

-- 
Damien Le Moal
Western Digital Research

