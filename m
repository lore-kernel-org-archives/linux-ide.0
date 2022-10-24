Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5316EC38A2D
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 11:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJXLP1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 07:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJXLPW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 07:15:22 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187BC4448F
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666610118; x=1698146118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OpPDF6eEqRY+WOAdo9eyFpzhwPggsS14f5ygbSpxqFg=;
  b=JgasnEX8QxmnDtt5Lvg++MJTvt/JEh1SUiiRA+LyUQEcPffl/12ROKym
   Oozd11cjQXi1MePz0AmAIiX7GNLont5wTuA7Nbb2WRe1jNaRF8BbdOGZi
   KFojEIHOc+4lSbmkJnFROZDG9A/e27YRRLuJa7HoiD7Z7VAbKIxl9Mop2
   m0bUc/lJTL25IOLsqDj0//lmay3nBRwsaHm8cM5dsMl8cVix6Dx090rlO
   JeZtZ3M18JGfhXKlTr9oX/2+s7JAs1MU+uSQrojWYyJzYX1LPDAyH8G4U
   DCpkIiXQ4/3GutB2xkU5JAXIGZ78y6Elkg2nIK+MCoPWBMS/7cDoO9Hcp
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,209,1661788800"; 
   d="scan'208";a="214961344"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 19:15:15 +0800
IronPort-SDR: mqZk+E8jEfGX9iq6zDJ32+ma4x175YdhlLyU6QWsd+Y4Zp2VHwUNMKxTuf9ZAwHfsttYs+otxy
 jDNerMe4F9UIu71981UXMjJ/yr2mpQic+3YQjV2ZZV0mirVHi/VifeZTZapoCsfyUdrK9bDtF3
 csocgPTREg4SgmiGyGP7Wi2AdffZ5/zwmzhjFBTHv4ctWdJwTDkyEHJ7x/iWHDmMo74rQBWFeh
 /aGEYDTID4Qq4IjM/XSip7k4e8pJw5qwAgJOhnXufhlvGEi7NvgpEuAmtNyhyrOa09WFOZe40F
 GfXV6z1dTO5x36kM0CfYNbcl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 03:28:58 -0700
IronPort-SDR: LiXsfXnVHH1TmUBifMlDfQvUsXCweKd2IJzt+IGaQIVW60xR0YhDnlhbZpw4OTap5ZI4izbXlu
 n5x0f++PZ1t0zUcYnpz94JiOfaj8lR0jNQCRlcsH+QbnsUNNcp5LUw626/h1edddxW9GtOEyPE
 Ozf3xk6Utjw+8X7sbq4BAGOp4M1nYpPZKuIBsgV24FL4KLGhbPCBZr4zmMBRGXoYIdloyBZm7X
 ymsVVwORI+nSu9KM2w5oDtYYO+r7ttxTNznK0FZrDbtcZRRx/DUMnxlMu7iNFlH/YabhDe2Hns
 xjI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 04:15:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MwstV5Lv2z1RvTp
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 04:15:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666610114; x=1669202115; bh=OpPDF6eEqRY+WOAdo9eyFpzhwPggsS14f5y
        gbSpxqFg=; b=P5lHGoJmSjhkV6kKps5A/SNUw1WCb1R5s7JqdC6Td0fPjSOToPF
        3LIt8oexNaPJVL35LdKxW6B+p2JquW4kCCIHs1NvhAEhfYtIhwvDnvJ0pluO/9vz
        vvkYCruI1/GgjDNaU50R6PPVGZlUzwRKPVzcB3C31LdlhOn8NF2LpW1zU0Cy1Oyh
        +mQhbJ0cEr3l4AL1HX2rRAWIF3x0XwM+SOQeiHnMC+APhOCr6+gPt+C2DXyxncyh
        k5bP8dOp2AKTP/rB1pNwJXAv8O4EJ3/9Gz8zJQnst4J3Ow20g01jYsRv0t9qghvo
        pBC2mwBtC7MU5sJpiw5cpCkyVpakxQFYTAg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I3dG83wKtJCx for <linux-ide@vger.kernel.org>;
        Mon, 24 Oct 2022 04:15:14 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MwstT4pc7z1RvLy;
        Mon, 24 Oct 2022 04:15:13 -0700 (PDT)
Message-ID: <ac8d103a-d5b9-8705-8f85-126c000f586f@opensource.wdc.com>
Date:   Mon, 24 Oct 2022 20:15:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 3/3] ata: libata: Enable fua support by default
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <20221024072609.346502-4-damien.lemoal@opensource.wdc.com>
 <52f3c988-3432-64d6-e38f-603b881c31ce@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <52f3c988-3432-64d6-e38f-603b881c31ce@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/24/22 19:16, Sergey Shtylyov wrote:
> Hello!
> 
> On 10/24/22 10:26 AM, Damien Le Moal wrote:
> 
>> Change the default value of the fua module parameter to 1 to enable fua
>> support by default for all devices supporting it. This parameter
>> description is also updated to indicate it is deprecated and that
>> libata.force=[no]fua should be used to control fua support.
> 
>    Mhm, where is that change? You only seem to change the default...

Oops. Forgot to update the commit message. I thought there was a way to
mark a module argument as deprecated, but there is not. Need to simplify
this commit message.

> 
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/ata/libata-core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 27aec8e63a8c..867e2c423627 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -127,9 +127,9 @@ int atapi_passthru16 = 1;
>>  module_param(atapi_passthru16, int, 0444);
>>  MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>>  
>> -int libata_fua = 0;
>> +int libata_fua = 1;
>>  module_param_named(fua, libata_fua, int, 0444);
>> -MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
>> +MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on [default])");
>>  
>>  static int ata_ignore_hpa;
>>  module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

