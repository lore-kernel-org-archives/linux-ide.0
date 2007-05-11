From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Fri, 11 May 2007 23:48:55 +0800
Message-ID: <46449067.70107@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com> <46441CA9.4030109@tw.ibm.com> <46447FB5.3040306@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:59735 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558AbXEKPtF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 11:49:05 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4BFn40f015118
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 11:49:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4BFn3s5205442
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 09:49:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4BFn2SC015576
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 09:49:03 -0600
In-Reply-To: <46447FB5.3040306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Albert Lee wrote:
> 
>>-static void ata_pio_sector(struct ata_queued_cmd *qc, int last)
>>+static void ata_pio_sector(struct ata_queued_cmd *qc, int last, int lock)
> 
> 
> I think the naming of @lock is a bit confusing here.  @clr_hsm_wq or
> @last_sector, maybe?
> 

How about "irq_handover"? When set to "true", it means the workqueue is going to
handover the control of the port to the irq handler.

> 
>>+		if (lock) {
>>+			tail = 8;
>>+			head = ATA_SECT_SIZE - tail; /* multiple of 8 bytes */
>>+			ap->ops->data_xfer(qc->dev, buf + offset, head, do_write);
>>+			spin_lock_irqsave(ap->lock, irq_flags);
>>+		}
>>+
>>+		ap->ops->data_xfer(qc->dev, buf + offset + head, tail, do_write);
> 
> 
> Aieee, we have to transfer the whole last sector while holding the spin
> lock and IRQ disabled.  That's sad but pushing locking into ->data_xfer
> doesn't sound attractive either.  Any better ideas?
> 
> 

Why need to transfer the last sector as a whole?
Spliting it into 504 (unlocked) + 8 (holding ap->lock) works on my machine...

--
albert

