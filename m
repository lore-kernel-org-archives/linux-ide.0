From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] 2.6.21 fix lba48 bug in libata fill_result_tf()
Date: Tue, 03 Apr 2007 11:29:47 -0400
Message-ID: <461272EB.7040705@rtr.ca>
References: <46116593.6050609@rtr.ca> <4611792C.1040404@rtr.ca> <4612405C.1000005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:4630 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030319AbXDCP3w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Apr 2007 11:29:52 -0400
In-Reply-To: <4612405C.1000005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Ric Wheeler <ric@emc.com>

Tejun Heo wrote:
> Mark Lord wrote:
>> Mark Lord wrote:
>>> This patch corrects fill_result_tf() so that the flags
>>> get copied to result_tf before they are used by tf_read().
>>>
>>> Signed-off-by:  Mark Lord <mlord@pobox.com>
>>> ---
>>> --- linux/drivers/ata/libata-core.c.orig    2007-03-21
>>> 12:46:06.000000000 -0400
>>> +++ linux/drivers/ata/libata-core.c    2007-04-02 16:16:28.000000000
>>> -0400
>>> @@ -4763,8 +4763,8 @@
>>> {
>>>     struct ata_port *ap = qc->ap;
>>>
>>> -    ap->ops->tf_read(ap, &qc->result_tf);
>>>     qc->result_tf.flags = qc->tf.flags;
>>> +    ap->ops->tf_read(ap, &qc->result_tf);
>>> }
>>>
>>> /**
>>>
>> If I understand this correctly, the impact of (not patching) this
>> is that error-handling for LBA48 accesses is broken.  Right, Tejun?
> 
> Yes, you're right.  Thanks for fixing this.
> 
> Acked-by: Tejun Heo <htejun@gmail.com>

This should really go into 2.6.21, as well as be backported
to the 2.6.20.xx point releases.

Where's Jeff?

