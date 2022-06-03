Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E0C43334
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jun 2022 08:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbiFCISX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Jun 2022 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiFCISW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jun 2022 04:18:22 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A361A817
        for <linux-ide@vger.kernel.org>; Fri,  3 Jun 2022 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654244298; x=1685780298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rN3jYN+bhIF4rDip7wHs52ts/z31JHYPnDrXGjiKwDk=;
  b=h9BFw3aQ5MKJMnqoQHtrHtqZ05cxNIlkSxu9IBxzo0hjy21RBNTj4cwL
   fntmXffXALHQ39teshhhNRxUmhHVvb1nfo3KFev/twZJdmQUJ+b5IF26V
   Ttpb+7c95SVl1vp2zRwqJ3P7VxfqQj3Tbmov9XdyB6tSRGo/iCfSiNfXC
   /qKgZ5l8CdINFbihitzVkvW3euWdKpRZZbZJpF+FyaMU33M8tpnszEYJ7
   yOERSNloWlNVNQWZ6dGFcH1Cvgeyc7NG5Piy93jiln/u16YhIa20f6z9l
   gnEeSAkWea5zylB7RYLV7ZtHsSCickb1826/jjOfUaujC87dxdvl1B34C
   g==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647273600"; 
   d="scan'208";a="207039951"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 16:18:17 +0800
IronPort-SDR: GxR8AdgeBxOQXfZNkHgtIOyvPB9J6mM3F+43f5E4NZE0s43RKAS2+f8QpP4mZnUZ8NZ8QF6iWB
 +xyp/AKudTjmg8ZUlsCd5xEz2AeM1JJYHSDFCj56gVo5X67YZx7LCwDUI3haTM3qcr5hb6vKr9
 Ld5R+Rl/74reGpSoTFXKI2rgNzFi+e/uXtGu5BDzDuKjc7TT1V5poo4N5/Xs5vzMny4pwvm0pS
 8iI7RrFjYAk8lIaecSAXyny2we0Uq1thw1DXSkDaRJ7ABLxVXrZe/iERBvJa1uZOeYChPEz+XT
 qHWVy+kt2y7tgk8xzXX8W2wR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 00:37:23 -0700
IronPort-SDR: Shf7MEY1MXv4s4DEn3d05tEjg4T2L7eVkIUqFg6Y/xgxNnOnQE/wY/mkhLp2X4gbuVYMALopn7
 tdamV89i/dRprxaI1kE3YWahYfnZ2prujmrY1ftHCgP/tbz5V25ZKN6G9Usc3NQCPi/FtkQNZQ
 o7np0yMWYGHolKsnVqkolD4pULV4ZCcwowsg3GggHe9plCaKs6RtamkasfASSA4WM2QOkMlU8Y
 4WKPtifDSVHkwVEQ+eK6fX0SarJC+/ekjlB8UHxISXKQMSUor8figyxA8nLMc+b0qIFPTfIHYy
 x2E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 01:18:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDwkL1sVwz1SVnx
        for <linux-ide@vger.kernel.org>; Fri,  3 Jun 2022 01:18:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654244297; x=1656836298; bh=rN3jYN+bhIF4rDip7wHs52ts/z31JHYPnDr
        XGjiKwDk=; b=E+5xtv8vqoW4i2OHh+ZpJmgokqn1QAyaCnh4xzSrNtRdSr3SQwQ
        nGqk5fnb5b//Ksaf9AYPmwJBplX8fQcjbKR85seCagwjxRSviYKYy7qCG6r31/uu
        LPSNwPn90uhTOQZ85fnSpMMJMQE89nNTuh6b0+liCLLPBusGKLlwe+SUE/UsUBFu
        WyqK7B1Le67G//pZGKz3+3PD5LUOr91LnYwCnaUYDUxdhFTsB4WV4D16z6MvboQQ
        5iYHqEkwwpTdwcuhnawOaZ3x07OABQ7bJfgoveQqNJk3dwWyaUQs5J8sRuYIZkHP
        lipT2FmPAK4Nql4v/GFpuylOlZIhEebHkzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zBZm-_IOnslv for <linux-ide@vger.kernel.org>;
        Fri,  3 Jun 2022 01:18:17 -0700 (PDT)
Received: from [10.225.163.68] (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDwkJ1BP7z1Rvlc;
        Fri,  3 Jun 2022 01:18:15 -0700 (PDT)
Message-ID: <4d1900cc-0edb-7206-a534-fb8c8cbd25d8@opensource.wdc.com>
Date:   Fri, 3 Jun 2022 17:18:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] libata: fix reading concurrent positioning ranges
 log
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        muhammad.ahmad@seagate.com, stable@vger.kernel.org
References: <20220602225113.10218-1-tyler.erickson@seagate.com>
 <20220602225113.10218-2-tyler.erickson@seagate.com>
 <071542b5-2269-7c8a-a78c-0cd7299bca99@suse.de>
 <948fc607-af5a-8b80-4f87-297462bb58c4@opensource.wdc.com>
 <b1e5fa91-fd80-a485-efea-ac5339391258@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b1e5fa91-fd80-a485-efea-ac5339391258@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/3/22 16:42, Hannes Reinecke wrote:
> On 6/3/22 09:07, Damien Le Moal wrote:
>> On 6/3/22 15:17, Hannes Reinecke wrote:
>>> On 6/3/22 00:51, Tyler Erickson wrote:
>>>> The concurrent positioning ranges log is not a fixed size and may depend
>>>> on how many ranges are supported by the device. This patch uses the size
>>>> reported in the GPL directory to determine the number of pages supported
>>>> by the device before attempting to read this log page.
>>>>
>>>> This resolves this error from the dmesg output:
>>>>       ata6.00: Read log 0x47 page 0x00 failed, Emask 0x1
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
>>>> Signed-off-by: Tyler Erickson <tyler.erickson@seagate.com>
>>>> Reviewed-by: Muhammad Ahmad <muhammad.ahmad@seagate.com>
>>>> Tested-by: Michael English <michael.english@seagate.com>
>>>> ---
>>>>    drivers/ata/libata-core.c | 21 +++++++++++++--------
>>>>    1 file changed, 13 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>> index 40e816419f48..3ea10f72cb70 100644
>>>> --- a/drivers/ata/libata-core.c
>>>> +++ b/drivers/ata/libata-core.c
>>>> @@ -2010,16 +2010,16 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>>>>    	return err_mask;
>>>>    }
>>>>    
>>>> -static bool ata_log_supported(struct ata_device *dev, u8 log)
>>>> +static int ata_log_supported(struct ata_device *dev, u8 log)
>>>>    {
>>>>    	struct ata_port *ap = dev->link->ap;
>>>>    
>>>>    	if (dev->horkage & ATA_HORKAGE_NO_LOG_DIR)
>>>> -		return false;
>>>> +		return 0;
>>>>    
>>>>    	if (ata_read_log_page(dev, ATA_LOG_DIRECTORY, 0, ap->sector_buf, 1))
>>>> -		return false;
>>>> -	return get_unaligned_le16(&ap->sector_buf[log * 2]) ? true : false;
>>>> +		return 0;
>>>> +	return get_unaligned_le16(&ap->sector_buf[log * 2]);
>>>>    }
>>>>    
>>> Maybe we should change to name of the function here;
>>> 'ata_log_supported()' suggests a bool return.
>>>
>>> ata_check_log_page() ?
>>>
>>>>    static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
>>>> @@ -2455,15 +2455,20 @@ static void ata_dev_config_cpr(struct ata_device *dev)
>>>>    	struct ata_cpr_log *cpr_log = NULL;
>>>>    	u8 *desc, *buf = NULL;
>>>>    
>>>> -	if (ata_id_major_version(dev->id) < 11 ||
>>>> -	    !ata_log_supported(dev, ATA_LOG_CONCURRENT_POSITIONING_RANGES))
>>>> +	if (ata_id_major_version(dev->id) < 11)
>>>> +		goto out;
>>>> +
>>>> +	buf_len = ata_log_supported(dev, ATA_LOG_CONCURRENT_POSITIONING_RANGES);
>>>> +	if (buf_len == 0)
>>>>    		goto out;
>>>>    
>>>>    	/*
>>>>    	 * Read the concurrent positioning ranges log (0x47). We can have at
>>>> -	 * most 255 32B range descriptors plus a 64B header.
>>>> +	 * most 255 32B range descriptors plus a 64B header. This log varies in
>>>> +	 * size, so use the size reported in the GPL directory. Reading beyond
>>>> +	 * the supported length will result in an error.
>>>>    	 */
>>>> -	buf_len = (64 + 255 * 32 + 511) & ~511;
>>>> +	buf_len <<= 9;
>>>>    	buf = kzalloc(buf_len, GFP_KERNEL);
>>>>    	if (!buf)
>>>>    		goto out;
>>>
>>> I don't get it.
>>> You just returned the actual length of the log page from the previous
>>> function. Why do you need to calculate the length here?
>>
>> Calculate ? This is only converting from 512B sectors to bytes.
>> The calculation was mine, a gross error :) This is what this patch is fixing.
>>
> Sigh. Can't we have a 'bytes_to_sectors' helper? All this shifting by 9 
> is getting on my nerves ...

Haha ! Yes, we can do that. But not in this patch since that is a bug fix.


-- 
Damien Le Moal
Western Digital Research
