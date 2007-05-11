From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Fri, 11 May 2007 19:06:10 +0200
Message-ID: <4644A282.4030008@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com> <46441CA9.4030109@tw.ibm.com> <46447FB5.3040306@gmail.com> <46449067.70107@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:24852 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762346AbXEKRH2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 13:07:28 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1114089wra
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 10:07:26 -0700 (PDT)
In-Reply-To: <46449067.70107@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Albert Lee wrote:
> Tejun Heo wrote:
>> Albert Lee wrote:
>>
>>> -static void ata_pio_sector(struct ata_queued_cmd *qc, int last)
>>> +static void ata_pio_sector(struct ata_queued_cmd *qc, int last, int lock)
>>
>> I think the naming of @lock is a bit confusing here.  @clr_hsm_wq or
>> @last_sector, maybe?
>>
> 
> How about "irq_handover"? When set to "true", it means the workqueue is going to
> handover the control of the port to the irq handler.
> 
>>> +		if (lock) {
>>> +			tail = 8;
>>> +			head = ATA_SECT_SIZE - tail; /* multiple of 8 bytes */
>>> +			ap->ops->data_xfer(qc->dev, buf + offset, head, do_write);
>>> +			spin_lock_irqsave(ap->lock, irq_flags);
>>> +		}
>>> +
>>> +		ap->ops->data_xfer(qc->dev, buf + offset + head, tail, do_write);
>>
>> Aieee, we have to transfer the whole last sector while holding the spin
>> lock and IRQ disabled.  That's sad but pushing locking into ->data_xfer
>> doesn't sound attractive either.  Any better ideas?
>>
> 
> Why need to transfer the last sector as a whole?
> Spliting it into 504 (unlocked) + 8 (holding ap->lock) works on my machine...

That would be the cleanest way to do it but I'm not sure whether all
controllers can live with that.  If I understand correctly, Some
controllers just have to have the whole transfer done atomically.  I
think Alan knows much better about this.  Alan?

-- 
tejun
