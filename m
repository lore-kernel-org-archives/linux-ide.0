Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8EDC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 17 Feb 2022 09:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiBQJ3z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:29:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBQJ3z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2022 04:29:55 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0BE2860CD
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2022 01:29:40 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8E64E20C2B4D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: libata-sff: use *switch* statement in
 ata_sff_dev_classify()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <b4b1d7c1-b786-358f-154a-ba755a0814fb@omp.ru>
 <16173ee5-00a8-4bd2-484a-d4c5953b98a9@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d607d22d-fcd3-15e9-d58a-459e0393f805@omp.ru>
Date:   Thu, 17 Feb 2022 12:29:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <16173ee5-00a8-4bd2-484a-d4c5953b98a9@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 2/17/22 3:22 AM, Damien Le Moal wrote:
[...]
>> In ata_sff_dev_classify(), replace a string of the *if* statements checking
>> the device's class with the *switch* statement that fits better here...
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>> repo.
>>
>>  drivers/ata/libata-sff.c |   14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> Index: libata/drivers/ata/libata-sff.c
>> ===================================================================
>> --- libata.orig/drivers/ata/libata-sff.c
>> +++ libata/drivers/ata/libata-sff.c
>> @@ -1841,8 +1841,8 @@ unsigned int ata_sff_dev_classify(struct
>>  
> 
> The err check before the hunk below could use a switch too.

   I have initially converted that one too but finally decided to keep
the order of the comparisons intact -- it makes more sense to 1st check
dev->devno in the last *if*...

> 
>>  	/* determine if device is ATA or ATAPI */
> 
> This comment is a bit weird since ATA_DEV_ATAPI is not used. Maybe

   Why? A call ata_port_classify() should detect the ATAPI devices,
we just don't "post-process" that result...

> change that to something like:
> 
> 	/* Check the device class */

   No, I don't agree here. :-)

> 
> Or just drop it... The code is clear enough I think.
> 
>>  	class = ata_port_classify(ap, &tf);
>> -
>> -	if (class == ATA_DEV_UNKNOWN) {
>> +	switch (class) {
>> +	case ATA_DEV_UNKNOWN:
>>  		/* If the device failed diagnostic, it's likely to
> 
> While at it, please correct the comment style here (start with a "/*"
> line). There are a ton of these style problems all over, so when
> touching code around them, let's fix them :)

   OK. :-)

[...]

MBR, Sergey
