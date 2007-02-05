From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: IORDY handling, quiet handling
Date: Mon, 05 Feb 2007 22:31:25 +0300
Message-ID: <45C7860D.6010304@ru.mvista.com>
References: <20070205162544.5e55cff0@localhost.localdomain> <45C77CF7.60201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:16849 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933419AbXBETbd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 14:31:33 -0500
In-Reply-To: <45C77CF7.60201@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Hello, I wrote:

>> @@ -3466,8 +3529,18 @@
>>      tf.command = ATA_CMD_SET_FEATURES;
>>      tf.feature = SETFEATURES_XFER;
>>      tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>> +
>> +    /* Older CFA may not support this command */
>> +    if (ata_id_is_cfa(dev->id))
>> +            tf.flags |= ATA_TFLAG_QUIET;
>> +
>>      tf.protocol = ATA_PROT_NODATA;
>> -    tf.nsect = dev->xfer_mode;
>> +
>> +    /* Ancient devices may need us to avoid IORDY */
>> +    if (ata_pio_need_iordy(dev))
>> +        tf.nsect = dev->xfer_mode;
>> +    else
>> +        tf.nsect = 0x01;

>    Note that ATA-1 did *not* yet define this subcode (only 0 for "block 
> transfer"). I think that we should not change the PIO modes at all on 
> non-IORDY drives, otherwise it's becoming pointless and messy -- you're

    After thinking a bit more: we should not do it on non-EIDE drives 
(however, this is probably the same thing).
    If our host by some mischance has no IORDY support and an EIDE drive has 
it and supports disabling (otherwise there's little we can do), we must issue 
subcode 0x01 and tune our host controller to the default PIO mode.

> not setting what you're told here and force the drive's default mode 
> instead... why then change it at all?

    Anyway, all this logic should be one layer higher than this function...

MBR, Sergei
