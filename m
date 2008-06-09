From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix on MacBook4,1: CD/DVD drive often fails to work
Date: Mon, 09 Jun 2008 22:46:32 +0900
Message-ID: <484D3438.5030306@gmail.com>
References: <k6d4mqvoxf.wl%shaolin@rhythmaning.org> <k6d4mqwy5z.wl%shaolin@rhythmaning.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:1051 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbYFINqj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jun 2008 09:46:39 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1321940ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2008 06:46:38 -0700 (PDT)
In-Reply-To: <k6d4mqwy5z.wl%shaolin@rhythmaning.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "MATSUBAYASHI, 'Shaolin' Kohji" <shaolin@rhythmaning.org>
Cc: linux-ide@vger.kernel.org

Hello,

MATSUBAYASHI, 'Shaolin' Kohji wrote:
> Sorry all, it was just my fault - this patch did not improve the
> stability. It just happened that annoying "status error" message
> did not appeared for a while. Now the message appears again every
> two seconds until I have to remove ide-cd_mod kernel module.
> 
> --
> Kohji
> 
> At Mon, 09 Jun 2008 20:16:28 +0900,
> MATSUBAYASHI, 'Shaolin' Kohji wrote:
>> Then the following patch fixed the problem anyhow at least on my machine
>> (I suspect changing from ich_pata_100 to ich_pata_66, especially
>> removing the flag PIIX_FLAG_CHECKINTR, did something good in this case).
>>
>> I am not certain whether this patch is the right/correct solution
>> for that, but anyway here's it. Let me know if there's something
>> I can do for debugging further.
>>
>> --
>> Kohji
>>
>> [2 ata_piix-pata-apple.patch <text/plain; US-ASCII (7bit)>]
>> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
>> index 81b7ae3..93b5741 100644
>> --- a/drivers/ata/ata_piix.c
>> +++ b/drivers/ata/ata_piix.c
>> @@ -214,6 +214,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
>>  	/* ICH7/7-R (i945, i975) UDMA 100*/
>>  	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
>>  	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
>> +	/* ICH8 Mobile PATA Controller, Apple */
>> +	{ 0x8086, 0x2850, 0x106b, 0x00a1, 0, 0, ich_pata_66 },
>>  	/* ICH8 Mobile PATA Controller */
>>  	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },

You're using IDE piix driver so modifying ata_piix won't help you much.
 Can you please give a shot at ata_piix?

-- 
tejun
