Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0374EC07E9D
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 23:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiIZXMn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 19:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIZXMl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 19:12:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4080DAD9B3
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664233960; x=1695769960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iK58kBNd3bRngNiZIR2NVeiphbGoK7gL3G+AiVBwpFs=;
  b=eDhtYeYOn8JFwabdJYxtYXHLNvEKWZze71P7Xev8vcQq7tYyK0Eh3NNF
   cHv/kq9NArlRaEHdyob7o0VouhLgRjpx9BmtUsyx06dYUoyk+gpGflzHh
   RmLtpQpk+eP9inqsLiMyQYTfQmPGCDImPIPHrHoyUK+Gsuk6g5Yj0lsTr
   Ia3i2R+q3E+0G3IWlabqItvNHz1lifTvLSKtSNEPzfp7zEQ/R5cDvIaEM
   WWkSQqUkJiEna3N4F6VSNk8E9tNR8ZBoBk34G873STximUCjRDXOofie4
   PGkUvs6z3NXBckgd3erE0C7NgMrfhTwLYesz4Vp6LxJLE6ssIPdYOugt8
   w==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="210692955"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 07:12:39 +0800
IronPort-SDR: +hM/MOETQcKGqsJ/H6eGtlax/gPe4NfsSR+qw8JLg0tJW+9L1VhH7ZqqfSczUJBMQJG1yq3teN
 cbnsqUBl5/yXPsdTNkWgMmHcfq85g50JZzNT3YKgBJdxQCqq0LV8Sasm1E/3VH6SCbWf0+upVB
 iyoa4+XVBO5OVJFwL19GCAdrCHIx7vLIAEengUcDNMHRgQ60Ijy9Cc6apt27CKlS37EjTt4JA4
 bv0SJl24ij4fVMazo5lcLbRNLUsoYoJHMaAPFsXFJBwe9boWBeDDf2jgjrMAOxzI2JPYuTjr8B
 x+bnftn/NqjlRJJgNraBnnYB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 15:27:05 -0700
IronPort-SDR: YeACv3E6+m5pEq8v26L3O6oHjzlZEdcQR4UM+QKrk9BNTOThxiS0+nUBbHyZEMYHBGTdB24T8x
 7PGxFemrFlFi+MePZxbDolND8fS37di43J0Y4Hzp0Z96CFyB6Rj59XcyDlUUmDlbIGlq8aiGhx
 kChqLhHpBS5NVEOodKUopXqHIyqCh5o7iGRxN8tUnw8AqO+decfVgY1uo9TTj70NLGffld6Zqy
 HSdHJEBPjdAkj9MDPBM9JP+zmb+aKi6CpfcOXiz5s26XAuT6kgTcr/a6Wca9KwvJ84nqh2epFf
 frc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 16:12:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mbz7C0Y2Tz1RwqL
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 16:12:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664233958; x=1666825959; bh=iK58kBNd3bRngNiZIR2NVeiphbGoK7gL3G+
        AiVBwpFs=; b=I8WqOxMStk/qWSS+SMA2Ay7SH6FwD30UmCxklKjV9HCWnISWcW+
        zHhPtk10jjjRsSiCiSNBzuHekz1rEoHoK3tsiT2XeUQzfmSCKmkUyzqkROCpwjLj
        33BIMEe/D/fNLJYlh7OfD2zbSte5jA0DfN48RuHTlIP+EnoDYTMM2ssuuYYyJFP8
        TIQm75mC+lG6XgDpS6YaLpU1D4CrMqoa9qjfX5OBhRGuCmF6vOh5yvBwlOjnvgfl
        wv1/Zy/85ffur1lAAWzUwRbPhmo18q3ycIRg/xMFaBW4rWeiI24TkyNKVEeV5CAZ
        EBw9gYMOJhfDt0sR6a+KykMWFIUOMb0WyIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4upUMiq1uxEK for <linux-ide@vger.kernel.org>;
        Mon, 26 Sep 2022 16:12:38 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mbz794xRCz1RvLy;
        Mon, 26 Sep 2022 16:12:37 -0700 (PDT)
Message-ID: <ab2c6a7a-132f-380d-f14d-4d165915dd95@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 08:12:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and
 BDR-205
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jaap Berkhout <j.j.berkhout@staalenberk.nl>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20220926183718.480950-1-Niklas.Cassel@wdc.com>
 <MN0PR12MB61013BB7AAD6ED1FBA63C269E2529@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <MN0PR12MB61013BB7AAD6ED1FBA63C269E2529@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/27/22 03:56, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Niklas Cassel <Niklas.Cassel@wdc.com>
>> Sent: Monday, September 26, 2022 13:38
>> To: Damien Le Moal <damien.lemoal@opensource.wdc.com>; Limonciello,
>> Mario <Mario.Limonciello@amd.com>
>> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>; stable@vger.kernel.org; Jaap
>> Berkhout <j.j.berkhout@staalenberk.nl>; linux-ide@vger.kernel.org
>> Subject: [PATCH] libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M
>> and BDR-205
>>
>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> Commit 1527f69204fe ("ata: ahci: Add Green Sardine vendor ID as
>> board_ahci_mobile") added an explicit entry for AMD Green Sardine
>> AHCI controller using the board_ahci_mobile configuration (this
>> configuration has later been renamed to board_ahci_low_power).
>>
>> The board_ahci_low_power configuration enables support for low power
>> modes.
>>
>> This explicit entry takes precedence over the generic AHCI controller
>> entry, which does not enable support for low power modes.
>>
>> Therefore, when commit 1527f69204fe ("ata: ahci: Add Green Sardine
>> vendor ID as board_ahci_mobile") was backported to stable kernels,
>> it make some Pioneer optical drives, which was working perfectly fine
>> before the commit was backported, stop working.
>>
>> The real problem is that the Pioneer optical drives do not handle low
>> power modes correctly. If these optical drives would have been tested
>> on another AHCI controller using the board_ahci_low_power configuration,
>> this issue would have been detected earlier.
>>
>> Unfortunately, the board_ahci_low_power configuration is only used in
>> less than 15% of the total AHCI controller entries, so many devices
>> have never been tested with an AHCI controller with low power modes.
>>
>> Fixes: 1527f69204fe ("ata: ahci: Add Green Sardine vendor ID as
>> board_ahci_mobile")
>> Cc: stable@vger.kernel.org
>> Reported-by: Jaap Berkhout <j.j.berkhout@staalenberk.nl>
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Thanks!
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Since Damien was still intending to modify the default policy so that LPM
> applies everywhere I feel like more of this is going to show up.  Should we
> consider to maybe keep all CD/DVD/BD devices excluded from LPM?

I am moving carefully on that one for fear of (old) devices breaking
randomly... So not needed yet. But yeah, I definitely want to cleanup the
lpm code.

> 
>> ---
>>  drivers/ata/libata-core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 826d41f341e4..c9a9aa607b62 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -3988,6 +3988,10 @@ static const struct ata_blacklist_entry
>> ata_device_blacklist [] = {
>>  	{ "PIONEER DVD-RW  DVR-212D",	NULL,
>> 	ATA_HORKAGE_NOSETXFER },
>>  	{ "PIONEER DVD-RW  DVR-216D",	NULL,
>> 	ATA_HORKAGE_NOSETXFER },
>>
>> +	/* These specific Pioneer models have LPM issues */
>> +	{ "PIONEER BD-RW   BDR-207M",	NULL,
>> 	ATA_HORKAGE_NOLPM },
>> +	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
>> +
>>  	/* Crucial BX100 SSD 500GB has broken LPM support */
>>  	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
>>
>> --
>> 2.37.3

-- 
Damien Le Moal
Western Digital Research

