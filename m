From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 8/10] libata: remove writing of tf->ctl from ata_tf_load()
Date: Thu, 05 Jul 2007 19:40:03 +0900
Message-ID: <468CCA83.5020606@gmail.com>
References: <468B5C97.1000803@tw.ibm.com> <468B627A.6050605@tw.ibm.com> <468BF057.9060408@rtr.ca> <468C5ADD.9050700@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:35612 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbXGEKkM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 06:40:12 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1812303nze
        for <linux-ide@vger.kernel.org>; Thu, 05 Jul 2007 03:40:12 -0700 (PDT)
In-Reply-To: <468C5ADD.9050700@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Hello,

Albert Lee wrote:
>> At some point soon, I hope to piece together enough old hardware here
>> to reconnect my PCI-X sata_qstor card, and then fix the driver.
>>
>> It needs to have control over the nIEN bit, and currently that bit
>> is not behaving as it did way back in 2.6.11(?) when the driver was
>> first added.
>>
>> The qstor chip *requires* that nIEN be "1" during R/W commands.
>> Is there a nice way to accomplish that here?
> 
> Does it mean that during the execution of PIO R/W commands, no interrupt
> will be generated? Currently the sata_qstor driver uses the
> ATA_FLAG_PIO_POLLING flag, does such polling pio fulfill the need of
> qstor? If not, maybe we could check what needs to be added and include
> them into consideration.

I'm not too familiar with how the qstor works but that sounds like
something which would fit very well into private ->qc_issue, no?

> Hmm, another consideration for qstor, irq_on/off do have their value for
> nIEN manipulation. The patchset maybe too far in scope.  I will limit
> the scope of the patchset and leave irq_on/off alone (rather than
> integrate with thaw/freeze).

I like the idea of killing ->freeze/thaw.  As you've just shown, they
provide almost the identical functionality as ->irq_off/on but just have
more cryptic names and with wide spread use of SATA, the meaning of NIEN
itself is diminishing, so I don't really see a point in keeping it for
the sake of controlling NIEN.

One way or the other, all we need is for the controller to not raise IRQ
during polling or when things look odd.  If some controller and/or
device need specific handling of NIEN, it'll be actually easier to deal
with if we define ->irq_off as "whatever you do, just shut up".

So, I'm all for it.

-- 
tejun
