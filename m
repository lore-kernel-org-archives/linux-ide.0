From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC 3/4] libata: interrupt driven pio for libata-core
Date: Fri, 30 Sep 2005 19:28:28 +0800
Message-ID: <433D215C.6080206@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com>	 <58cb370e05092903083e0d001c@mail.gmail.com> <433CF12D.900@tw.ibm.com> <58cb370e0509300228h7ab212ebg3916e89c637bed53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:4049 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751249AbVI3L2d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2005 07:28:33 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8UBR0eX007766
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:27:00 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8UBSPf4530966
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 05:28:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8UBSPQT024818
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 05:28:25 -0600
In-Reply-To: <58cb370e0509300228h7ab212ebg3916e89c637bed53@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Hi Bart,:

>
>>When the state is HSM_ST_FIRST,  ata_host_intr() checks the
>>(qc->dev->flags & ATA_DFLAG_CDB_INTR) flag.
>>Also in atapi_packet_task(), the host lock is aquired during the state
>>transition from HSM_ST_FIRST to next state.
>>So, the race between the irq handler and atapi_packet_task() is avoided.
>>    
>>
>
>What about ATAPI device with !dev->flags & ATA_DFLAG_CDB_INTR)?
>
>Shouldn't we do spin_lock_irqsave() in atapi_packet_task() before
>actually touching hardware?
>
>  
>
For the ATAPI devices that don't raise CDB interrupes,
when atapi_packet_task() is entered, the state is HSM_ST_FIRST.
 In this state, the irq handler will check the ATA_DFLAG_CDB_INTR flag 
and skip touching the hardware.
atapi_packet_task() is safe to read the device status register at this 
state.
atapi_packet_task() does spin_lock_irqsave() when changing the states 
from HSM_ST_FIRST to say, HSM_ST and sending out the data.

For the ATAPI devices that raise CDB interrupes,
ata_qc_issue_prot() won't queue an new atapi_packet_task().
The irq handler takes over after ata_qc_issue_prot() and can touch the 
hardware.

Thanks for the comments,

Albert

