Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E84C4708E
	for <linux-ide@archiver.kernel.org>; Wed,  7 Dec 2022 13:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiLGN04 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Dec 2022 08:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLGN0n (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2022 08:26:43 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7957B5C;
        Wed,  7 Dec 2022 05:26:41 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 14E6160027FC1;
        Wed,  7 Dec 2022 14:26:39 +0100 (CET)
Message-ID: <5ba31f2c-89b0-c059-dda0-674db08e7466@molgen.mpg.de>
Date:   Wed, 7 Dec 2022 14:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] libata: Sort Pioneer model in blacklist names
 lexicographically
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207102656.12486-1-pmenzel@molgen.mpg.de>
 <4d105e81-7f99-a17a-2a84-5eb70c74cc91@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4d105e81-7f99-a17a-2a84-5eb70c74cc91@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Damien,


Am 07.12.22 um 14:22 schrieb Damien Le Moal:
> On 12/7/22 19:26, Paul Menzel wrote:
>> Fixes: commit ea08aec7e77b ("libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and BDR-205")
>> Cc: Niklas Cassel <niklas.cassel@wdc.com>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   drivers/ata/libata-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index d3ce5c383f3a..c08c534b7fc7 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -3990,8 +3990,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>   	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
>>   
>>   	/* These specific Pioneer models have LPM issues */
>> -	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
>>   	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
>> +	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
> 
> Nah... Not worse the trouble. If anything, I would rather have the entire
> ata_device_blacklist array entries sorted alphabetically by vendor and models.

What trouble?

>>   	/* Crucial BX100 SSD 500GB has broken LPM support */
>>   	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },


Kind regards,

Paul
