Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289BAC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 03:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiAEDj5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 22:39:57 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:17872 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236083AbiAEDj5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 22:39:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTFbx251Hz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 19:39:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641353996; x=1643945997; bh=HNMqzlKDysglKbghSSUfYEFb7X72J6u0iQb
        tJ/7ANGk=; b=Eekhw9x2DyFxQrFYmogD/SmcvdiH3hUVDyouJENQesMkdgndIFi
        krYduwqEMcPdBFCC3uQCwUCFayH/gbLvOs6hQaKY32FUXSv2carbdBErs1rTW1mn
        kmLQdsgbGez00L+PAEhWcUjlVQ01mUtWPf3Q/2+CuqQ68MTtyGMNxJBeNLMKdM2S
        gwJ6tP9aVfKJw1uAUMItppqd8ACLkFE+l++43Axlvl22/FGgasNO42yW+k0eyreD
        cfo4MBgXHWSLfgbGJC4OTWO+mtD7LIYRCJUXMJCzhRHw/tXmJFTd4mH+2GlrfKTt
        KDN3kl+a2ZO94h+BXrC8PfPkFRdh8KA/ZIg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 31nq-DOCwvqP for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 19:39:56 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTFbw2ZMgz1VSkV;
        Tue,  4 Jan 2022 19:39:56 -0800 (PST)
Message-ID: <eb611ccc-546f-97a3-d80e-866bd0d277f1@opensource.wdc.com>
Date:   Wed, 5 Jan 2022 12:39:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 20/22] ata: sata_fsl: fix cmdhdr_tbl_entry and prde
 struct definitions
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
 <20220104105843.1730172-21-damien.lemoal@opensource.wdc.com>
 <345fa64f-a5a8-d6ff-8bf3-e3cd38c53445@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <345fa64f-a5a8-d6ff-8bf3-e3cd38c53445@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/4/22 20:45, Hannes Reinecke wrote:
> On 1/4/22 11:58 AM, Damien Le Moal wrote:
>> The fields of the cmdhdr_tbl_entry structure all store __le32 values,
>> and so are the dba and ddc_and_ext fields of the prde structure. Define
>> these fields using the __le32 type to avoid sparse warnings about
>> incorrect type in assignment.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/ata/sata_fsl.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>> index 101d4dd79f62..13d532193405 100644
>> --- a/drivers/ata/sata_fsl.c
>> +++ b/drivers/ata/sata_fsl.c
>> @@ -221,10 +221,10 @@ enum {
>>   * 4 Dwords per command slot, command header size ==  64 Dwords.
>>   */
>>  struct cmdhdr_tbl_entry {
>> -	u32 cda;
>> -	u32 prde_fis_len;
>> -	u32 ttl;
>> -	u32 desc_info;
>> +	__le32 cda;
>> +	__le32 prde_fis_len;
>> +	__le32 ttl;
>> +	__le32 desc_info;
>>  };
>>  
>>  /*
>> @@ -259,9 +259,9 @@ struct command_desc {
>>   */
>>  
>>  struct prde {
>> -	u32 dba;
>> +	__le32 dba;
>>  	u8 fill[2 * 4];
>> -	u32 ddc_and_ext;
>> +	__le32 ddc_and_ext;
>>  };
>>  
>>  /*
>>
> ... which means that _technically_ we should modify the log message in
> sata_fsl_setup_cmd_hdr_entry() to use le32_to_cpu(), too, to avoid
> garbled numbers on big endian. Or maybe not, if we argue that we want
> to print out the values as sent to the HW.

It makes more sense to me to print the real value, so I added that fix.

> 
> Anyway.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
