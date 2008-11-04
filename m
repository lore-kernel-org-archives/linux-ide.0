From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/6] ide: rework handling of serialized ports
Date: Tue, 04 Nov 2008 21:34:44 +0300
Message-ID: <491095C4.3000503@ru.mvista.com>
References: <20081103200244.5098.29817.sendpatchset@localhost.localdomain> <20081103200326.5098.2058.sendpatchset@localhost.localdomain> <491094B2.4090107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:48023 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752237AbYKDSeu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 13:34:50 -0500
In-Reply-To: <491094B2.4090107@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

>> Index: b/drivers/ide/ide-probe.c
>> ===================================================================
>> --- a/drivers/ide/ide-probe.c
>> +++ b/drivers/ide/ide-probe.c

> [...]

>> @@ -1436,10 +1398,8 @@ static void ide_init_port(ide_hwif_t *hw
>>      }
>>  
>>      if ((d->host_flags & IDE_HFLAG_SERIALIZE) ||
>> -        ((d->host_flags & IDE_HFLAG_SERIALIZE_DMA) && hwif->dma_base)) {
>> -        if (hwif->mate)
>> -            hwif->mate->serialized = hwif->serialized = 1;
>> -    }
>> +        ((d->host_flags & IDE_HFLAG_SERIALIZE_DMA) && hwif->dma_base))
>> +        hwif->host_flags |= IDE_HFLAG_SERIALIZE;

>    I don't see what use is forcing this flag at all here -- it doesn't 
> seem to be checked only in init_irq() now, so this *if* could just be 
> moved there...

    Oops, rephrasing hurts sometimes: I meant "it seems", of course. :-)

MBR, Sergei
