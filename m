From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] 2.6.21 fix lba48 bug in libata fill_result_tf()
Date: Tue, 03 Apr 2007 20:54:04 +0900
Message-ID: <4612405C.1000005@gmail.com>
References: <46116593.6050609@rtr.ca> <4611792C.1040404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:21502 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965565AbXDCLyL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2007 07:54:11 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1860120wra
        for <linux-ide@vger.kernel.org>; Tue, 03 Apr 2007 04:54:10 -0700 (PDT)
In-Reply-To: <4611792C.1040404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Ric Wheeler <ric@emc.com>

Mark Lord wrote:
> Mark Lord wrote:
>>
>> This patch corrects fill_result_tf() so that the flags
>> get copied to result_tf before they are used by tf_read().
>>
>> Signed-off-by:  Mark Lord <mlord@pobox.com>
>> ---
>> --- linux/drivers/ata/libata-core.c.orig    2007-03-21
>> 12:46:06.000000000 -0400
>> +++ linux/drivers/ata/libata-core.c    2007-04-02 16:16:28.000000000
>> -0400
>> @@ -4763,8 +4763,8 @@
>> {
>>     struct ata_port *ap = qc->ap;
>>
>> -    ap->ops->tf_read(ap, &qc->result_tf);
>>     qc->result_tf.flags = qc->tf.flags;
>> +    ap->ops->tf_read(ap, &qc->result_tf);
>> }
>>
>> /**
>>
> 
> If I understand this correctly, the impact of (not patching) this
> is that error-handling for LBA48 accesses is broken.  Right, Tejun?

Yes, you're right.  Thanks for fixing this.

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
