From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 8/10] libata: remove writing of tf->ctl from ata_tf_load()
Date: Thu, 05 Jul 2007 10:43:41 +0800
Message-ID: <468C5ADD.9050700@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com> <468B627A.6050605@tw.ibm.com> <468BF057.9060408@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:50741 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbXGECnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 22:43:53 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l652hp8x032076
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 22:43:51 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l652hpQZ226926
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 20:43:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l652hoSC021662
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 20:43:50 -0600
In-Reply-To: <468BF057.9060408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Mark Lord wrote:
> Albert Lee wrote:
> 
>> Patch 8/10:
>>  
>> The relevant bits in the ctl register are HOB, SRST and nIEN.
>>  - HOB is only used by ata_tf_read().
>>  - For SRST, soft reset is not the duty of tf_load.
>>  - For nIEN, explicit irq_on()/irq_off and freeze()/thaw() are provided.
>>
>>   Since EH/HSM now call explicit freeze()/thaw() for irq off/on.
>> Remove the implicit nIEN handling from ata_tf_load().
> 
> 
> At some point soon, I hope to piece together enough old hardware here
> to reconnect my PCI-X sata_qstor card, and then fix the driver.
> 
> It needs to have control over the nIEN bit, and currently that bit
> is not behaving as it did way back in 2.6.11(?) when the driver was
> first added.
> 
> The qstor chip *requires* that nIEN be "1" during R/W commands.
> Is there a nice way to accomplish that here?
> 

Does it mean that during the execution of PIO R/W commands, no interrupt
will be generated? Currently the sata_qstor driver uses the
ATA_FLAG_PIO_POLLING flag, does such polling pio fulfill the need of
qstor? If not, maybe we could check what needs to be added and include
them into consideration.

Hmm, another consideration for qstor, irq_on/off do have their value for
nIEN manipulation. The patchset maybe too far in scope.  I will limit
the scope of the patchset and leave irq_on/off alone (rather than
integrate with thaw/freeze).

Thanks for the comments.
--
albert

