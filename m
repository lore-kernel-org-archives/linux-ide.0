From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 8/8] libata: ack more unsolicited INTRQ
Date: Thu, 17 May 2007 16:59:30 +0800
Message-ID: <464C1972.6050205@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>	<464AB2F3.7030103@tw.ibm.com> <20070516140201.29d0f6f0@the-village.bc.nu>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:59430 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXEQJAQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 05:00:16 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4H90EtZ005679
	for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 05:00:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4H90DrT055008
	for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 03:00:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4H90Cth020139
	for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 03:00:13 -0600
In-Reply-To: <20070516140201.29d0f6f0@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>>As previously discussed, the possible issue with this patch is:
>>Some ATA/ATAPI devices might be unhappy if the STATUS register
>>is read during data transfer (not sure if this is true or not).
>>(Patch 5/8 doesn't have such issue.) 
> 
> 
> Some older intel eats your disk if you do that.

Ah, too bad. Thanks for the advice.

> 
> Neither of these approaches quite work. Much as I dislike the "old IDE"
> disable/enable irq approach it does look like that is the only safe
> answer for some controllers.
> 

Agreed reading the status register during data transfer looks bad.
Please disregard this patch.

Back to the problem that the patch was trying to solve,
i.e. unsolicited interrupt when HSM doing data transfer in the wq,
is there any experience about how often such situation occurs?

IMHO, it seems not something that happens often. If the cable/devices
are well configured, the intrq would mostly occur when it should.

Even if the unsolicited irq happens, maybe the current code has
good chance to handle it?
e.g. ata_irq_task() already reads the status before data transfer,
thus possibly clearing some of unsolicited irqs.
e.g. maybe the data transfer in the workqueue is quick enough?
If yes, hopefully the ATA_PFLAG_HSM_WQ is soon cleared, and
then the interrupt handler can come in ack the irq. (Much the same
way when the irq handler encounters "early irq" by bad devices.)

--
albert


