Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75892C7113B
	for <linux-ide@archiver.kernel.org>; Wed, 23 Aug 2023 23:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjHWXDm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbjHWXDN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 19:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB84E6A;
        Wed, 23 Aug 2023 16:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82498630CA;
        Wed, 23 Aug 2023 23:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6046FC433C7;
        Wed, 23 Aug 2023 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692831789;
        bh=3lhGl7dYZSn3kRA3t2GKh2E940LP8kb8mOLoucCwWPQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vIZu4CTt5nrezgCKEQ+pRV2POGuEUzzVqVUBimkgsO22gS44xhngpdcGSLJVkjssF
         X3efN0XPNe1n02BE/5vwvI9jxXNtAW5f0PwwxvEKndJZB0B4LsfhGUhq0BiKWMmDoK
         ftVPWc1R7hLVysLrDBtrkfqW3qHEbGtt2LORX8xsM43GM0Rf2iOecc5HW+FWxmdwc1
         mRnE8a1XdZs71A5AgFZWESFkyNgtfQ08pYgoXkWibRvIfhlRYYRgawqqbISundf4qa
         gbS1cqNCVGdawUC6DqjNxM+uA2QsEPrO4FDzWXAaKmQc0RD8r13hoPYOwUzwtqO2T/
         DLhOX8m+yl1yw==
Message-ID: <35b28bcb-13ba-fafc-a30b-d84eb3b6bbea@kernel.org>
Date:   Thu, 24 Aug 2023 08:03:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/2] ata: pata_falcon: add data_swab option to
 byte-swap disk data
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
 <20230822221359.31024-3-schmitzmic@gmail.com>
 <56654dc7-37e7-1fd7-0d3f-647563f4cc5a@omp.ru>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <56654dc7-37e7-1fd7-0d3f-647563f4cc5a@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/24/23 01:35, Sergey Shtylyov wrote:
> On 8/23/23 1:13 AM, Michael Schmitz wrote:
> 
>> Some users of pata_falcon on Q40 have IDE disks in default
>> IDE little endian byte order, whereas legacy disks use
>> host-native big-endian byte order as on the Atari Falcon.
>>
>> Add module parameter 'data_swab' to allow connecting drives
>> with non-native data byte order. Drives selected by the
>> data_swap bit mask will have their user data byte-swapped to
>> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
>> all user data on drive B, leaving data on drive A in native
>> byte order. On Q40, drives on a second IDE interface may be
>> added to the bit mask as bits 2 and 3.
>>
>> Default setting is no byte swapping, i.e. compatibility with
>> the native Falcon or Q40 operating system disk format.
>>
>> Cc: William R Sowerbutts <will@sowerbutts.com>
>> Cc: Finn Thain <fthain@linux-m68k.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Tested-by: William R Sowerbutts <will@sowerbutts.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>> index 3841ea200bcb..7cf15bd9764a 100644
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
> [...]
>> @@ -194,6 +199,9 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>  	ata_port_desc(ap, "cmd %px ctl %px data %pa",
>>  		      base, ctl_base, &ap->ioaddr.data_addr);
>>  
>> +	ap->private_data = (void *)(uintptr_t)(pdev->id > 0 ?
>> +		pata_falcon_swap_mask >> 2 : pata_falcon_swap_mask);
> 
>    How about:
> 
> 	ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >>
> 			   (pdev->id > 0 ? 2 : 0));

This is so hard to decode... Let's please spell this out.
Something like:

	int shift;

	if (pdev->id)
		shift = 2;
	else
		shift = 0;
	ap->private_data = (uintptr_t)(pata_falcon_swap_mask >> shift);

This is initialization, so no need to try to optimize and rather privilege clear
code.

> 
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

