From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata-core: Don't have screaming fits over DF/ERR combinations
Date: Tue, 16 Oct 2007 00:05:53 +0400
Message-ID: <4713C821.6090303@ru.mvista.com>
References: <20071015192313.5892ed42@the-village.bc.nu> <4713C549.6010704@ru.mvista.com> <4713C74F.3020205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:11652 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933398AbXJOUFk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 16:05:40 -0400
In-Reply-To: <4713C74F.3020205@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, akpm@osdl.org

Jeff Garzik wrote:

>>> Some hardware seems to get this wrong in a non-harmful way, and there 
>>> are
>>> some devices that seem to do it deliberately for various reasons.

>>> Just take it as a device error not a catastrophic state machine
>>> explosion. 

>>> Signed-off-by: Alan Cox <alan@redhat.com>

>>> diff -u --exclude-from /usr/src/exclude --new-file --recursive 
>>> linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c 
>>> linux-2.6.23-mm1/drivers/ata/libata-core.c
>>> --- linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c    2007-10-15 
>>> 15:03:26.000000000 +0100
>>> +++ linux-2.6.23-mm1/drivers/ata/libata-core.c    2007-10-15 
>>> 15:13:49.000000000 +0100
>>> @@ -5258,7 +5319,15 @@
>>>          if (unlikely(status & (ATA_ERR | ATA_DF))) {
>>>              ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
>>>                      "error, dev_stat 0x%X\n", status);
>>> -            qc->err_mask |= AC_ERR_HSM;
>>> +            /* Some devices muck this up. Some follow an ATA
>>> +               non-standard that permits the damaged sector to
>>> +               be retrieved at this point. The ATA spec says
>>> +               we should jump up and down on DRQ + ERR, reality

>>    I've always thought that setting both DRQ and ERR is perfectly 
>> valid (well, maybe it's become invalid since ATAPI-4 where all these 
>> state transition flow charts have made its first appearance, to be 
>> quickly replaced by the state diagrams :-) -- I'm too lazy to check 
>> now... :-)

> DRQ+ERR is valid, and SRST (or hard reset) is defined as the method of 
> kicking the device out of that state.

    Well, in the times of old, reading a sector (or group of them for multiple 
mode) was valid for that purpose, wasn't it?

>     Jeff

MBR, Sergei
