Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D1AC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 01:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiDYBSw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 21:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbiDYBSw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 21:18:52 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE139686
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650849350; x=1682385350;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Buv3PNrbtF1fgAoIed9IrFQUE8TvUlPkYPR/lQiWGuk=;
  b=BP7KMxvx21LiKbx9+EcDn2gOxcZ39xMghknfa8+QP5v/TQk7PsTILqbT
   QgY0bqf5iY9gxQM+mJLrpqmgJSWXxJbMrI1W52VMEmLOrLp6HwqFe2UA/
   fJ4TDk1NPwFiexWYzy7UO/cwovlPrkjL8I2Ip2M/oD1wIG3pPPGKW4nqu
   99wplchOKIpIY1lVJM9Ds902+y/eKxob+3p/HFtFSMMsDQ80jDjwUr35l
   QIvCCWO7a1OKMjpEVXvn6ixniS6REp8O88bhyvGigNlHg+6JKKw0AqQYP
   o4KIyQ/J1WPLa265vr5CaWZRae7SR1GzjbC+GSzjD1UcRdnZ6vfBgBbsk
   g==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="199603642"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 09:15:49 +0800
IronPort-SDR: j9EXdgaJoLZpxtOlUhKaHtK9yHsOIaI7i16nvL8PnjYdYa81Fz/6AwBMz84/QZUP0vGqVwOtnY
 bKvMfnBtpDoC8N4aYA7zw19GOOOII+OXTfgiEnxCizf0Z1zJz/eFHG3DmI/Xmtqg29QTJYVeTF
 R8qH34aZcHXPgSKfD7ELfRHNjh0jLSBR5veOHbFq8BQK+/jBDOQYhO7371dLrUZ2WmAO3976HD
 6KV7dB33JIAYv5OWiYwXLSiXyZnuZOcuEMLro2+fbCE7ZTRwo82P0joBUIVXf2JWeJjRlASR3E
 I8yCxoBtjFHZKgzyCBxBkHG3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:46:02 -0700
IronPort-SDR: T79Ybk07M7ARVvkOewMfu3YHvdYuGQoQS+vLn8T0849/LbIelXKe6c3GV/I08xhAnWxjPXntV4
 m6M6e/TXy/9x01CftBjnf/EK4s0tAteUyBpQgiUYW8e5CQ7D4Stpc8/Xr+arC7zlSFIraRYhTF
 831RNgy1KOe/87JEI0A4ybqn66/L/Xa4HJqydJecNJNeWDD4BYvEqigmUYNnyb9R4KRkMKnJXP
 GLio4PT3BsMXXByYkOpw0s7dKiwxvYL9vm7VJhCaA7N+l2Q/8oey29A7WyIc3wfhAdLTYnFH9U
 onQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:15:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmnBr5Vl3z1SVny
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:15:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650849348; x=1653441349; bh=Buv3PNrbtF1fgAoIed9IrFQUE8TvUlPkYPR
        /lQiWGuk=; b=gOppKcUumvDb9wHitYS014PHyb+WOmgj+Ol09RXrRizrr1VA4Do
        1sk1f214YNb9RgY1UBJgbCXUdaPaoV1VcX0PrluECc0CV6pI+Rxa2tlFlvWmuLQa
        zp8DmFcqnNBWT7LJh8HSR6c2aBcI4MIc6IBCTms5cQ8beAHYZa4w4DuIpVXgAkJj
        pXj25RL6u3ybx+wwv2q6dMpAw7KrdxixxRI2LlTUR0z0Jk6wS8Dj08dotJcbu2ja
        /tG8sOKhhhWZDWds3Sc/h5AkrrYzth8mDET40t8YRjZPkt2Jmh+XUVtHRjoE6Wx5
        bDiMIjrAt/7PxaEes2krkiwCmKcdlTeP+jA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3yJz41UxDihL for <linux-ide@vger.kernel.org>;
        Sun, 24 Apr 2022 18:15:48 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmnBq4NGpz1Rvlx;
        Sun, 24 Apr 2022 18:15:47 -0700 (PDT)
Message-ID: <ce2f858e-c211-2a1d-fc91-4451a9a64112@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 10:15:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/5] ata: libata-core: Allow forcing most horkage flags
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
 <20220407123748.1170212-5-damien.lemoal@opensource.wdc.com>
 <b74cbd2a-c9a2-2f3a-3421-3a79098ca3fd@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b74cbd2a-c9a2-2f3a-3421-3a79098ca3fd@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/25/22 03:17, Sergey Shtylyov wrote:
> On 4/7/22 3:37 PM, Damien Le Moal wrote:
> 
>> To facilitate debugging of drive issues in the field without kernel
>> changes (e.g. temporary test patches), add an entry for most horkage
>> flags in the force_tbl array to allow controlling these horkage
>> settings with the libata.force kernel boot parameter.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/ata/libata-core.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 75856f4210d7..121cb55a219a 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -6230,9 +6230,27 @@ static const struct ata_force_param force_tbl[] __initconst = {
>>  	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
>>  	force_horkage_onoff(ncqati,	ATA_HORKAGE_NO_NCQ_ON_ATI),
>>  
>> -	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
>> +	force_horkage_onoff(trim,	ATA_HORKAGE_NOTRIM),
>> +	force_horkage_onoff(trim_zero,	ATA_HORKAGE_ZERO_AFTER_TRIM),
>> +	force_horkage_on(max_trim_128m, ATA_HORKAGE_MAX_TRIM_128M),
>> +
>> +	force_horkage_onoff(dma,	ATA_HORKAGE_NODMA),
>>  	force_horkage_on(atapi_dmadir,	ATA_HORKAGE_ATAPI_DMADIR),
>> -	force_horkage_on(disable,	ATA_HORKAGE_DISABLE)
>> +	force_horkage_on(atapi_mod16_dma, ATA_HORKAGE_ATAPI_MOD16_DMA),
>> +
>> +	force_horkage_onoff(dma_log,	ATA_HORKAGE_NO_DMA_LOG),
>> +	force_horkage_onoff(id_dev_log,	ATA_HORKAGE_NO_ID_DEV_LOG),
>> +	force_horkage_onoff(log_dir,	ATA_HORKAGE_NO_LOG_DIR),
> 
>    Underscores in the names with "no" (without underscore) would look inconsistent,
> wouldn't they? Maybe drop the underscores here?

Yep. Done.

> 
> [...]
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
