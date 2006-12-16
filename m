From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ata kmap_atomic abuse
Date: Sat, 16 Dec 2006 11:40:29 -0500
Message-ID: <4584217D.7090500@garzik.org>
References: <20061211001314.9ecb17a2.akpm@osdl.org>	<457D822A.9010600@garzik.org> <20061211100025.c9abb9bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34834 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161177AbWLPQkc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 11:40:32 -0500
In-Reply-To: <20061211100025.c9abb9bb.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Andrew Morton wrote:
> On Mon, 11 Dec 2006 11:07:06 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Andrew Morton wrote:
>>> [  231.948000] SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
>>> [  232.232000] ata1.00: configured for UDMA/33
>>> [  232.404000] WARNING (1) at arch/i386/mm/highmem.c:47 kmap_atomic()
>>> It's using KM_USER0 from softirq.
>> I thought that was OK if it was kmap_atomic().  Live and learn.
> 
> Each kmap_atomic slot is basically a per-cpu global variable.  If a CPU is
> inside process-level kmap_atomic(KM_USER0) and then runs that softirq,
> it'll return from the softirq with its kmap slot pointing at the wrong
> page.
> 
>> Checked in the attached.
> 
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 664e137..a4790be 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -1539,7 +1539,7 @@ static unsigned int ata_scsi_rbuf_get(st
>>  		struct scatterlist *sg;
>>  
>>  		sg = (struct scatterlist *) cmd->request_buffer;
>> -		buf = kmap_atomic(sg->page, KM_USER0) + sg->offset;
>> +		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
>>  		buflen = sg->length;
>>  	} else {
>>  		buf = cmd->request_buffer;
>> @@ -1567,7 +1567,7 @@ static inline void ata_scsi_rbuf_put(str
>>  		struct scatterlist *sg;
>>  
>>  		sg = (struct scatterlist *) cmd->request_buffer;
>> -		kunmap_atomic(buf - sg->offset, KM_USER0);
>> +		kunmap_atomic(buf - sg->offset, KM_IRQ0);
>>  	}
>>  }
>>  
> 
> KM_IRQ0 can only be used with local interrupts disabled, for the same
> reason.

Are you making a comment, or pointing out a flaw in the patch?

AFAICS, the code in question is always under spin_lock_irqsave()

	Jeff



