Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584E6C43334
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jun 2022 19:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352164AbiFUTOW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFUTOV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jun 2022 15:14:21 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3E13E09
        for <linux-ide@vger.kernel.org>; Tue, 21 Jun 2022 12:14:17 -0700 (PDT)
Received: from [192.168.1.103] (178.176.77.12) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 21 Jun
 2022 22:14:06 +0300
Subject: Re: [PATCH] ata: libata-scsi: fix sloppy result type of ata_ioc32()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <4a695619-2de7-671e-7b67-2afddf22423f@omp.ru>
 <d653908c-1270-9c2f-eceb-2572e9c9d339@opensource.wdc.com>
 <e8dcebdc-7618-533e-0050-dd03ef1f4bb8@omp.ru>
 <9c231ffe-df3c-9c36-4b8b-dc518009c3d2@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b37cfe23-a19b-970d-d5b1-3d67659595ee@omp.ru>
Date:   Tue, 21 Jun 2022 22:14:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9c231ffe-df3c-9c36-4b8b-dc518009c3d2@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.77.12]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/21/2022 18:56:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171268 [Jun 21 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 491 491 a718ef6dc942138335b0bcd7ab07f27b5c06005e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.77.12 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.77.12 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;178.176.77.12:7.7.3,7.7.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.77.12
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/21/2022 19:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/21/2022 4:24:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/21/22 1:44 AM, Damien Le Moal wrote:
[...]
>>>> While ata_ioc32() returns *int*, its result gets assigned to and compared
>>>> with the *unsigned long* variable 'val' in ata_sas_scsi_ioctl(), its only
>>>> caller, which implies a problematic implicit cast -- fix that by returning
>>>> *unsigned long* instead.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>>> analysis tool.
>>>>
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>>
>>>> ---
>>>> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
>>>>
>>>>  drivers/ata/libata-scsi.c |    2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> Index: libata/drivers/ata/libata-scsi.c
>>>> ===================================================================
>>>> --- libata.orig/drivers/ata/libata-scsi.c
>>>> +++ libata/drivers/ata/libata-scsi.c
>>>> @@ -539,7 +539,7 @@ int ata_task_ioctl(struct scsi_device *s
>>>>  	return rc;
>>>>  }
>>>>  
>>>> -static int ata_ioc32(struct ata_port *ap)
>>>> +static unsigned long ata_ioc32(struct ata_port *ap)
>>>>  {
>>>>  	if (ap->flags & ATA_FLAG_PIO_DMA)
>>>>  		return 1;
>>
>>> Actually, this should be a bool I think and the ioctl code cleaned to use
>>
>>    By the ioctl code you mean ata_sas_scsi_ioctl()?
> 
> yes.
> 
>>> that type since the val argument of the ioctl is also used as a bool.
>>
>>    As for HDIO_SET_32BIT, that's prolly OK but what to do with HDIO_GET_32BIT
>> (it calls put_user() on *unsigned long*)?
> 
> Something like this should work fine:
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 86dbb1cdfabd..ec7f79cbb135 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[...]
> @@ -571,16 +572,16 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct
> scsi_device *scsidev,
>                 return put_user(val, (unsigned long __user *)arg);
> 
>         case HDIO_SET_32BIT:

   Hmm, I told you this *case* is prolly OK -- it was HDIO_GET_32BIT *case* that
I was concerned about... So you mean that HDIO_GET_32BIT handling should remain
intact?

> -               val = (unsigned long) arg;
> +               pio32 = !!((unsigned long) arg);
>                 rc = 0;
>                 spin_lock_irqsave(ap->lock, flags);
>                 if (ap->pflags & ATA_PFLAG_PIO32CHANGE) {
> -                       if (val)
> +                       if (pio32)
>                                 ap->pflags |= ATA_PFLAG_PIO32;
>                         else
>                                 ap->pflags &= ~ATA_PFLAG_PIO32;
>                 } else {
> -                       if (val != ata_ioc32(ap))
> +                       if (pio32 != ata_ioc32(ap))
>                                 rc = -EINVAL;
>                 }
>                 spin_unlock_irqrestore(ap->lock, flags);

   Not really sure this is worth it... *unsigned long* result type for
ata_ioc32() seems simpler.

MBR, Sergey
