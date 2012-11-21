From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_highbank: use ATA_BUSY
Date: Wed, 21 Nov 2012 14:43:57 -0500
Message-ID: <50AD2EFD.8040205@pobox.com>
References: <201211012059.29109.sshtylyov@ru.mvista.com> <50AD2CF5.6080907@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54438 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab2KUToB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Nov 2012 14:44:01 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so3932001vcm.19
        for <linux-ide@vger.kernel.org>; Wed, 21 Nov 2012 11:44:00 -0800 (PST)
In-Reply-To: <50AD2CF5.6080907@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On 11/21/2012 02:35 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 11/01/2012 08:59 PM, Sergei Shtylyov wrote:
>
>> ahci_highbank_hardreset() uses bare number for the BSY bit of the ATA status
>> register, despite it is #define'd in <linux/ata.h>
>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>> ---
>> The patch is atop of the 'upstream' branch of libata-dev.git...
>
>>   drivers/ata/sata_highbank.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>> Index: libata-dev/drivers/ata/sata_highbank.c
>> ===================================================================
>> --- libata-dev.orig/drivers/ata/sata_highbank.c
>> +++ libata-dev/drivers/ata/sata_highbank.c
>> @@ -213,7 +213,7 @@ static int ahci_highbank_hardreset(struc
>>
>>   	/* clear D2H reception area to properly wait for D2H FIS */
>>   	ata_tf_init(link->device, &tf);
>> -	tf.command = 0x80;
>> +	tf.command = ATA_BUSY;
>>   	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
>>
>>   	do {
>
>     Jeff, are you going to queue this one and earlier patches from me?

Yep, should be queued in next 24-48 hours with a bunch of other stuff.

Wanted to get #upstream-fixes upstream and settled first.

	Jeff




