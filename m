Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D813AC433EF
	for <linux-ide@archiver.kernel.org>; Sat,  5 Feb 2022 10:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiBEKgH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 05:36:07 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:48658 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiBEKgG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 05:36:06 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 1936120D8A13
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3] pata_artop: use *switch* in artop_init_one()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <dbb4010a-e466-d7f5-e926-72577a96a22d@omp.ru>
 <03fec07b-4a87-7ec2-ae7b-575e4d91d012@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <95f1a80c-1cee-ba78-b086-2359f36fb078@omp.ru>
Date:   Sat, 5 Feb 2022 13:36:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <03fec07b-4a87-7ec2-ae7b-575e4d91d012@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/5/22 2:39 AM, Damien Le Moal wrote:

>> This driver uses a string of the *if* statements where a *switch* statement
>> fits better...
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>> repo.
>>
>> Changes in version 3:
>> - fixed up the patch subject.
>>
>> Changes in version 2:
>> - updated #define DRV_VERSION.
>>
>>  drivers/ata/pata_artop.c |   24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> Index: libata/drivers/ata/pata_artop.c
>> ===================================================================
>> --- libata.orig/drivers/ata/pata_artop.c
>> +++ libata/drivers/ata/pata_artop.c
>> @@ -28,7 +28,7 @@
>>  #include <linux/ata.h>
>>  
>>  #define DRV_NAME	"pata_artop"
>> -#define DRV_VERSION	"0.4.6"
>> +#define DRV_VERSION	"0.4.7"
>>  
>>  /*
>>   *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
>> @@ -394,16 +394,22 @@ static int artop_init_one (struct pci_de
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
>> -	else if (id->driver_data == 2)	{ /* 6280 or 6280 + fast */
>> -		unsigned long io = pci_resource_start(pdev, 4);
>> -
>> -		ppi[0] = &info_628x;
>> -		if (inb(io) & 0x10)
>> -			ppi[0] = &info_628x_fast;
>> +		break;
>> +	case 2:		/* 6280 or 6280 + fast */
>> +		{
>> +			unsigned long io = pci_resource_start(pdev, 4);
>> +
>> +			ppi[0] = &info_628x;
>> +			if (inb(io) & 0x10)
>> +				ppi[0] = &info_628x_fast;
>> +		}
> 
> 
> Do you really need the local variable ?
> I would make this:
> 
> 		if (pci_resource_start(pdev, 4) & 0x10)
> 			ppi[0] = &info_628x_fast;
> 		else
> 			ppi[0] = &info_628x;
> 
> simpler :)

   Yeah! :-)
   But a matter of another patch, I think...

[...]

MBR, Sergey
