From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/12] libata: use IRQ expecting
Date: Fri, 25 Jun 2010 05:48:04 -0400
Message-ID: <4C247B54.2050900@garzik.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C245E50.7090701@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org
List-Id: linux-ide@vger.kernel.org

On 06/25/2010 03:44 AM, Tejun Heo wrote:
> Hello, Jeff.
>
> On 06/25/2010 02:22 AM, Jeff Garzik wrote:
>>> @@ -4972,6 +4972,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>>>    {
>>>        struct ata_port *ap = qc->ap;
>>>
>>> +    unexpect_irq(ap->irq_expect, false);
>>> +
>>>        /* XXX: New EH and old EH use different mechanisms to
>>>         * synchronize EH with regular execution path.
>>>         *
>>
>> Unconditional use of unexpect_irq() here seems incorrect for some cases,
>> such as sata_mv's use, where ata_qc_complete() is called multiple times
>> rather than a singleton ata_qc_complete_multiple() call.
>
> Indeed, sata_mv is calling ata_qc_complete() directly multiple times.
> I still think calling unexpect_irq() from ata_qc_complete() is correct
> as ata_qc_complete() is always a good indicator of completion events.

My basic point is that you are implicitly changing the entire 
ata_qc_complete() API, and associated underlying assumptions.

The existing assumption, since libata day #0, is that ata_qc_complete() 
works entirely within the scope of a single qc -- thus enabling multiple 
calls for a single controller interrupt.  Your change greatly widens the 
scope to an entire port.

This isn't just an issue with sata_mv, that was just the easy example I 
remember off the top of my head.  sata_fsl and sata_nv also make the 
same assumption.  And it's a reasonable assumption, IMO.

I think an unexpect_irq() call is more appropriate outside 
ata_qc_complete().

	Jeff
