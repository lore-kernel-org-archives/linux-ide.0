Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA75EC43334
	for <linux-ide@archiver.kernel.org>; Thu,  2 Jun 2022 06:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiFBGfl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Jun 2022 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFBGfl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2022 02:35:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C5821D4B8
        for <linux-ide@vger.kernel.org>; Wed,  1 Jun 2022 23:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654151739; x=1685687739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SiFU+2iJ2gtie8aZtqTo4IKSdW9Nnsan1PoD+KTQWI8=;
  b=m+Qab6GkUx7AGU1rRC7UrNhmnld2HImPkSXF4kJWrAyAhj8Je6WyxaiA
   jNKrGzKfQmMopMa2pMjno2v8Ay3nTcRkN7knlMtWCUmkvHJ2lDZEj+d8n
   BlTt9Kd+HISlR2+QifNNgyHZI3DGsjCkdE4r/IejDyUfuPqnkpVcZwoBv
   2Tf7x3SU8AlJ8jRcmm3CGARaq/Do1VhleEMS+G7VZ1cFfMF2l3qkMzM9A
   nH6w08JbvUZYqwHT2gss/KkCHzPG5vEsZIAy7DcUJL4daNLB5BUpPp8zo
   tQIzg1Q4f5ZjKQ/Ct84x5WwaesX++THYV890iyHQO/sMeA84thpB8285K
   g==;
X-IronPort-AV: E=Sophos;i="5.91,270,1647273600"; 
   d="scan'208";a="306324734"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 14:35:39 +0800
IronPort-SDR: D5e80qsq/zlbYwzUX9zNDuFCs8KRkthKqj0PCdvarnwxYjM9K+Qgxgp2GQ5c1mya3RJym64pxX
 E27BKsJ+P6860zyCr8GFDFnPWL9hT0gc03bTU5fYPBlU6xGYsb2jRQTdJYEYWiqbuxnnC1Jng6
 QMsNFEd1kcNb2bmJXhxvpuG0p8NXYohk4Nu3/8ZVhJeTkR+RfsWsKniWynx7Xct+tIRylLQw0a
 JvwCPzG3pB2xLLpnOBuazoYQaolMtDxxwgMKBi6t64C9PhHXEHx2q/xIdGt5J72/Zl21oAAOxQ
 46d0Q7kDC236di7/HZtf7Jia
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 22:59:15 -0700
IronPort-SDR: R4zyrK1s62Qc1WBQbDyyFq6RfSHXRSGak5Ix5Dow2KVH9fKLdACtUnilZJ+GzSgJ2amtySsCZZ
 snKGTcoj+8M0+Yi7wiFFvFRNiOn0j7Ovb/JN1BE0LUG/JpM6sFy0xShsq2bgHDrIAV4RsinHQw
 es1LMLBPdhIsmBfX2KPtp7tcIowlzO/abKjVfe1bqqp2+61HV1caG1LYzdrd6yybAn9KByYQHL
 DJPTVX1d1aq+6j7v4k56fzaUW/rFKaVk6/cjyrrIWxj5JRGnCNO1LFNQI4up5qAmOPUgs/jqZ3
 pYw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 23:35:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDGVK5bv9z1SVp0
        for <linux-ide@vger.kernel.org>; Wed,  1 Jun 2022 23:35:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654151737; x=1656743738; bh=SiFU+2iJ2gtie8aZtqTo4IKSdW9Nnsan1Po
        D+KTQWI8=; b=PrU4ejmlPsoI9B7ex7ogeSecIr2yBTfOwHZigMzCje0+ptnZX1m
        pluJasmUWdrl6peDz+AC0FioMtBVfz+bsoyU85WC8VT+qvnQejorm4sVsHjYrx07
        5f3v4cUwTXKWY7Rvt35rSOdDpjvZqL1F1lIZFALJzSbaJgg3za4J8K88ZuiuwBpO
        BNlZXnOOMjvOLcPbgJl5SXZsnTYD8iKERDa/T6Rl0KLbzgADA4Y9AWp9Kr+xASdR
        IQM+kmukW0YfnJfP6xAqCk0ildtKZVVUyRz7lZ3Ky6TGlevrRSzHqqqhzTLzOeBg
        36UfiyfnWEtamMIGZUtUf/cgUVuI3vGKnvw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R54oi8xFdsKT for <linux-ide@vger.kernel.org>;
        Wed,  1 Jun 2022 23:35:37 -0700 (PDT)
Received: from [10.89.84.115] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.115])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDGVH4xq5z1Rvlc;
        Wed,  1 Jun 2022 23:35:35 -0700 (PDT)
Message-ID: <a60d9b99-79db-86fa-37ab-798726b646c9@opensource.wdc.com>
Date:   Thu, 2 Jun 2022 15:35:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] [PATCH v1 1/2] libata: fix reading concurrent
 positioning ranges log
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        muhammad.ahmad@seagate.com,
        Tyler Erickson <tyler.j.erickson@seagate.com>,
        Michael English <michael.english@seagate.com>
References: <20220531175009.850-1-tyler.erickson@seagate.com>
 <20220531175009.850-2-tyler.erickson@seagate.com>
 <1051b626-63a5-5a97-e3c5-4d89e1f7a229@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1051b626-63a5-5a97-e3c5-4d89e1f7a229@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/06/01 19:29, Sergey Shtylyov wrote:
> Hello!
> 
> On 5/31/22 8:50 PM, Tyler Erickson wrote:
> 
>> From: Tyler Erickson <tyler.j.erickson@seagate.com>
>>
>> The concurrent positioning ranges log is not a fixed size and may depend
>> on how many ranges are supported by the device. This patch uses the size
>> reported in the GPL directory to determine the number of pages supported
>> by the device before attempting to read this log page.
>>
>> Also fixing the page length in the SCSI translation for the concurrent
>> positioning ranges VPD page.
>>
>> This resolves this error from the dmesg output:
>>     ata6.00: Read log 0x47 page 0x00 failed, Emask 0x1
>>
>> Signed-off-by: Tyler Erickson <tyler.j.erickson@seagate.com>
>> Reviewed-by: Muhammad Ahmad <muhammad.ahmad@seagate.com>
>> Tested-by: Michael English <michael.english@seagate.com>
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index ca64837641be..3d57fa84e2be 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -2003,16 +2003,16 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>>  	return err_mask;
>>  }
>>  
>> -static bool ata_log_supported(struct ata_device *dev, u8 log)
>> +static int ata_log_supported(struct ata_device *dev, u8 log)
> 
>    Maybe *unsigned int*? The 'buf_len' variable below is 'size_t' which is *unsigned* type...

int is fine I think. The value is 16-bits so no overflow possible. And having a
signed value, we can change the code to return an error code if ever needed.

> 
>>  {
>>  	struct ata_port *ap = dev->link->ap;
>>  
>>  	if (dev->horkage & ATA_HORKAGE_NO_LOG_DIR)
>> -		return false;
>> +		return 0;
>>  
>>  	if (ata_read_log_page(dev, ATA_LOG_DIRECTORY, 0, ap->sector_buf, 1))
>> -		return false;
>> -	return get_unaligned_le16(&ap->sector_buf[log * 2]) ? true : false;
>> +		return 0;
>> +	return get_unaligned_le16(&ap->sector_buf[log * 2]);
>>  }
>>  
>>  static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
>> @@ -2448,15 +2448,20 @@ static void ata_dev_config_cpr(struct ata_device *dev)
>>  	struct ata_cpr_log *cpr_log = NULL;
>>  	u8 *desc, *buf = NULL;
>>  
>> -	if (ata_id_major_version(dev->id) < 11 ||
>> -	    !ata_log_supported(dev, ATA_LOG_CONCURRENT_POSITIONING_RANGES))
>> +	if (ata_id_major_version(dev->id) < 11)
>> +		goto out;
>> +
>> +	buf_len = ata_log_supported(dev, ATA_LOG_CONCURRENT_POSITIONING_RANGES);
>> +	if (buf_len == 0)
>>  		goto out;
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
