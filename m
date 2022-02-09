Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773AAC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Feb 2022 23:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiBIXfD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 18:35:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiBIXfC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 18:35:02 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E0E05ADD8
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 15:35:01 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 518C420AA82F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v5 2/2] ata: pata_artop: use *switch* in atp8xx_fixup()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220209202535.7679-1-s.shtylyov@omp.ru>
 <20220209202535.7679-3-s.shtylyov@omp.ru>
 <a7d2fd87-9210-a960-b69e-dd0ea94e86d4@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <612e6d09-1167-2ab7-d54d-4a5e198f5074@omp.ru>
Date:   Thu, 10 Feb 2022 02:34:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a7d2fd87-9210-a960-b69e-dd0ea94e86d4@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/22 2:29 AM, Damien Le Moal wrote:

>> This driver uses a string of the *if* statements in atp8xx_fixup() where
>> a *switch* statement would fit better...
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> ---
>>
>> Changes in version 5:
>> - fixed up #define DRV_VERSION;
>> - added "ata: " prefix to the patch subject.
>>
>> Changes in version 4:
>> - new patch.
>>
>>  drivers/ata/pata_artop.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
>> index 08e88403d0ab..20a8f31a3f57 100644
>> --- a/drivers/ata/pata_artop.c
>> +++ b/drivers/ata/pata_artop.c
>> @@ -28,7 +28,7 @@
>>  #include <linux/ata.h>
>>  
>>  #define DRV_NAME	"pata_artop"
>> -#define DRV_VERSION	"0.4.7"
>> +#define DRV_VERSION	"0.4.8"
>>  
>>  /*
>>   *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
>> @@ -315,12 +315,15 @@ static struct ata_port_operations artop6260_ops = {
>>  
>>  static void atp8xx_fixup(struct pci_dev *pdev)
>>  {
>> -	if (pdev->device == 0x0005)
>> +	u8 reg;
>> +
>> +	switch (pdev->device) {
>> +	case 0x0005:
>>  		/* BIOS may have left us in UDMA, clear it before libata probe */
>>  		pci_write_config_byte(pdev, 0x54, 0);
>> -	else if (pdev->device == 0x0008 || pdev->device == 0x0009) {
>> -		u8 reg;
>> -
>> +		break;
>> +	case 0x0008:
>> +	case 0x0009:
>>  		/* Mac systems come up with some registers not set as we
>>  		   will need them */
>>  
>> @@ -338,6 +341,7 @@ static void atp8xx_fixup(struct pci_dev *pdev)
>>  		/* Enable IRQ output and burst mode */
>>  		pci_read_config_byte(pdev, 0x4a, &reg);
>>  		pci_write_config_byte(pdev, 0x4a, (reg & ~0x01) | 0x80);
>> +		break;
>>  	}
> 
> without a default case, isn't there a warning with make W=1

   No. I thought *default* makes sense only for *enum*s...

> or make C=1
> (sparse) ?

   Still no. :-P

[...]

MNR.Sergey
