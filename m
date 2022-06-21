Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA691C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jun 2022 22:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiFUWPZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiFUWPW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jun 2022 18:15:22 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686402FFC6
        for <linux-ide@vger.kernel.org>; Tue, 21 Jun 2022 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655849719; x=1687385719;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=jbXLTS+pRiuW4mBg0PDidfkmbUAuxPkDj/Ut8yVk2SY=;
  b=foLzMz7jC/OueXB9a7axsGwq/72J+XwUzvlyeyQ8u7ekMlX23D27l3BT
   YQ+uAiYl4PvfigSiiitQ+OOuLma4OE6ywnONlxlT5OwOIrM+OqaGw1nyg
   A1vuPlskRudR2eq2XcjFJbxnz5hlZb3S7sbxiflWb3NN7TkT2I3C5cenm
   pXVmI9tDDwfTb+SrJbk1RWDYH/ZjgzUwJE1eLGteTaEKFkjDAFvqeLJ3A
   cEa3LqWHKYeKIFRU6r7PuAA5QHJjUxGqBYl3h1ZPvrAm3soVAM2Fbt1gC
   VTtP5qqscPQDDNWGMZQWJE6yTRusBwRMX6xyw9O8v1Hdz5t3pMGC0GPl7
   g==;
X-IronPort-AV: E=Sophos;i="5.92,210,1650902400"; 
   d="scan'208";a="203760306"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2022 06:15:19 +0800
IronPort-SDR: Y1nkNcYJBjiGhuVLgApxHXhNKChsentma1WCllU/Ey6EdgkdGofeAxwxyYACuWTR91HDZSEwOu
 Mr+DHFVX36kQMM3ks3IhkKw9AAUDfXcGhkLTJaiOg5OkA1wBPV5KtgmckchjqsUMh4pgNJlvhq
 NZQYE/jBHStm9UQTlBjFf2PC+OUO8O/42hjlz+IYPgN9DVcnIUUK1kLE98hHnAVK7qACz/UAH4
 rj3/dbPv7PcDofauLCygTzaJNdLq9jS1k7y0kKyt2F47Y2TOS5AK3PurPIe6yOlOa1+Mq7sSoP
 bDR5gPwNd/vQ88BSNLVavhka
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 14:33:28 -0700
IronPort-SDR: r/StFm35OHO6wDABtCYoO82PFTNpZeo+DjHvhKTXFSbUVNVb4meK1t/qeKjKB4eHhg+EiZ2f2B
 soKECYlEmYxNKiuSxCWRVKHG9biHpu4Ij3nTnXnUXChLoQOw+WQYhncFMad8inFH45rQgGQOG1
 rxfhccoY8qy8XfvcdTz5IMP6+zFMN+fnvfObGWuhj9fGzilsuyiSih+WCsDmL639IJbGuwRG/6
 JmGT3jCXvBUhTlOlo5iYZ/xfLQ1cwwYWTPWbzLJc8I8zZAxTQZ8HDjfW+3blpuAl26mD0YcNBY
 R/I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 15:15:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LSLRr5JpGz1Rwnl
        for <linux-ide@vger.kernel.org>; Tue, 21 Jun 2022 15:15:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655849720; x=1658441721; bh=jbXLTS+pRiuW4mBg0PDidfkmbUAuxPkDj/U
        t8yVk2SY=; b=KdqNo6FHgjr4H5OOfouyHgksLrvVAPtzFiXiXj8LNXj7kuwYGQ7
        EJQzxMUz5tJSGTxLIN/zKGG/umXXLt8+XMDoKHCqWqj8WUFA72Rhm60IvAqyDq4C
        qbVjlJ2yu2owm9OUzitJkzQ9W46Oh3IZjQFXM+/Nm463hYtE/9/XH6O0KztpYMFg
        W45y9rxDp/MiyRgjaHA43Dnpaj8nQwY9rwdhBPAvRjV4bGk6/nNOtaIjIMUD71TI
        2xpmo9gwLFGx9P1HgWiU9NsIXg/KqBohd/8InuasLTZAdCioueCSHA4mP/WD1chE
        kS6wiQjfzP6+Rt89mo+zHsJnffXAsQCVmAw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UbYGbSHPvdDO for <linux-ide@vger.kernel.org>;
        Tue, 21 Jun 2022 15:15:20 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LSLRq71stz1RtVk;
        Tue, 21 Jun 2022 15:15:19 -0700 (PDT)
Message-ID: <db552ffc-4a70-61cf-5402-7f1abb551240@opensource.wdc.com>
Date:   Wed, 22 Jun 2022 07:15:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-scsi: fix sloppy result type of ata_ioc32()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <4a695619-2de7-671e-7b67-2afddf22423f@omp.ru>
 <d653908c-1270-9c2f-eceb-2572e9c9d339@opensource.wdc.com>
 <e8dcebdc-7618-533e-0050-dd03ef1f4bb8@omp.ru>
 <9c231ffe-df3c-9c36-4b8b-dc518009c3d2@opensource.wdc.com>
 <b37cfe23-a19b-970d-d5b1-3d67659595ee@omp.ru>
 <a57fdc21-1f06-495a-deda-d29c74cd75ab@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a57fdc21-1f06-495a-deda-d29c74cd75ab@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/22/22 05:37, Sergey Shtylyov wrote:
> On 6/21/22 10:14 PM, Sergey Shtylyov wrote:
> [...]
>>>>>> While ata_ioc32() returns *int*, its result gets assigned to and compared
>>>>>> with the *unsigned long* variable 'val' in ata_sas_scsi_ioctl(), its only
>>>>>> caller, which implies a problematic implicit cast -- fix that by returning
>>>>>> *unsigned long* instead.
>>>>>>
>>>>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>>>>> analysis tool.
>>>>>>
>>>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>>>>
>>>>>> ---
>>>>>> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
>>>>>>
>>>>>>  drivers/ata/libata-scsi.c |    2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> Index: libata/drivers/ata/libata-scsi.c
>>>>>> ===================================================================
>>>>>> --- libata.orig/drivers/ata/libata-scsi.c
>>>>>> +++ libata/drivers/ata/libata-scsi.c
>>>>>> @@ -539,7 +539,7 @@ int ata_task_ioctl(struct scsi_device *s
>>>>>>  	return rc;
>>>>>>  }
>>>>>>  
>>>>>> -static int ata_ioc32(struct ata_port *ap)
>>>>>> +static unsigned long ata_ioc32(struct ata_port *ap)
>>>>>>  {
>>>>>>  	if (ap->flags & ATA_FLAG_PIO_DMA)
>>>>>>  		return 1;
>>>>
>>>>> Actually, this should be a bool I think and the ioctl code cleaned to use
>>>>
>>>>    By the ioctl code you mean ata_sas_scsi_ioctl()?
>>>
>>> yes.
>>>
>>>>> that type since the val argument of the ioctl is also used as a bool.
>>>>
>>>>    As for HDIO_SET_32BIT, that's prolly OK but what to do with HDIO_GET_32BIT
>>>> (it calls put_user() on *unsigned long*)?
>>>
>>> Something like this should work fine:
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 86dbb1cdfabd..ec7f79cbb135 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>> [...]
>>> @@ -571,16 +572,16 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct
>>> scsi_device *scsidev,
>>>                 return put_user(val, (unsigned long __user *)arg);
>>>
>>>         case HDIO_SET_32BIT:
>>
>>    Hmm, I told you this *case* is prolly OK -- it was HDIO_GET_32BIT *case* that
>> I was concerned about... So you mean that HDIO_GET_32BIT handling should remain
>> intact?
>>
>>> -               val = (unsigned long) arg;
>>> +               pio32 = !!((unsigned long) arg);
> 
>    No, this one won't do -- it changes the behavior in case ATA_PFLAG_PIO32CHANGE
> isn't set... :-/
> 
>>>                 rc = 0;
>>>                 spin_lock_irqsave(ap->lock, flags);
>>>                 if (ap->pflags & ATA_PFLAG_PIO32CHANGE) {
>>> -                       if (val)
>>> +                       if (pio32)
>>>                                 ap->pflags |= ATA_PFLAG_PIO32;
>>>                         else
>>>                                 ap->pflags &= ~ATA_PFLAG_PIO32;
>>>                 } else {
>>> -                       if (val != ata_ioc32(ap))
>>> +                       if (pio32 != ata_ioc32(ap))
>>>                                 rc = -EINVAL;
>>>                 }
>>>                 spin_unlock_irqrestore(ap->lock, flags);
>>
>>    Not really sure this is worth it... *unsigned long* result type for
>> ata_ioc32() seems simpler.
> 
>    Actually, even just modifying ata_ioc32() to return 'bool' produces
> a seemingly correct code. Note that ata_ioc32() is inlined in any case...

If there are no issues with the bool type conversion, I would really
prefer that rather than the unsigned long route. The latter is really
about silencing a static analyzer rather than ideal code. Given the name
of the function, returning an unsigned long is really strange.

> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
