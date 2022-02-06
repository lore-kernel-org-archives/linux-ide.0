Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B809C433F5
	for <linux-ide@archiver.kernel.org>; Sun,  6 Feb 2022 10:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiBFKaB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Feb 2022 05:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKaB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2022 05:30:01 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B8C06173B
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 02:29:59 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 6A2E220ECE82
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v4 2/3] pata_artop: use *switch* in artop_init_one()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220205203434.15339-1-s.shtylyov@omp.ru>
 <20220205203434.15339-3-s.shtylyov@omp.ru>
 <d1432a8d-ac25-d37e-8de3-d60be1670d3b@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <3f7a8f86-5a66-99ef-e165-60c41e33429e@omp.ru>
Date:   Sun, 6 Feb 2022 13:24:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d1432a8d-ac25-d37e-8de3-d60be1670d3b@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/6/22 4:55 AM, Damien Le Moal wrote:

>> This driver uses a string of the *if* statements in artop_init_one() where
>> the *switch* statement would fit better...
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> ---
>> Changes in version 4:
>> - fixed up #define DRV_VERSION;
>> - expanded the patch description.
>>
>> Changes in version 3:
>> - fixed up the patch subject.
>>
>> Changes in version 2:
>> - updated #define DRV_VERSION.
>>
>>  drivers/ata/pata_artop.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
>> index b734cafb8783..d8c388da0c70 100644
>> --- a/drivers/ata/pata_artop.c
>> +++ b/drivers/ata/pata_artop.c
[...]
>> @@ -394,14 +394,18 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (rc)
>>  		return rc;
>>  
>> -	if (id->driver_data == 0)	/* 6210 variant */
>> +	switch (id->driver_data) {
>> +	case 0:		/* 6210 variant */
>>  		ppi[0] = &info_6210;
>> -	else if (id->driver_data == 1)	/* 6260 */
>> +		break;
>> +	case 1:		/* 6260 */
>>  		ppi[0] = &info_626x;
>> -	else if (id->driver_data == 2) { /* 6280 or 6280 + fast */
>> +		break;
>> +	case 2:		/* 6280 or 6280 + fast */
>>  		ppi[0] = &info_628x;
>>  		if (inb(pci_resource_start(pdev, 4)) & 0x10)
>>  			ppi[0] = &info_628x_fast;
> 
> Why not use "if () else" here ?

    Because I'm following the basic rule: one thing per patch. :-)

> And I do not see the point of patch 1.

   Again, one thing per patch. It was a preparatory patch.

> Since this patch is rewriting this hunk anyway, let's squash patch 1
> into this one.

   I'd really prefer not doing thos...

[...]

MBR, Sergey
