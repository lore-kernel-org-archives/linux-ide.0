From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC 3/3] libata: interrupt driven pio for LLD
Date: Fri, 23 Sep 2005 10:40:31 +0800
Message-ID: <43336B1F.5080107@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com> <43322FBB.5060403@tw.ibm.com> <4332A9FF.3010400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36312 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751127AbVIWCkv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2005 22:40:51 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8N2eeFD029553
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 22:40:40 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8N2eeYO100816
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 22:40:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j8N2ecD1025339
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 22:40:39 -0400
In-Reply-To: <4332A9FF.3010400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>

Hi Mark:

> Albert Lee wrote:
>
>> Patch 3/3: interrupt driven pio patch for LLD
>>
>> sata_qstor.c:
>>  Private irq handler, need modification to handle interrupt driven 
>> mode in the future.
>>  Use polling mode for the unsupported protocols for the time being.
>
> ...
>      default:
> +        /* FIXME: qs_intr_mmio() doesn't handle
> +         * interrupt driven pio/atapi cdb intr yet.
>
> The qs_intr_mmio() handler is set up for interrupt driven
> pio/atapi usage, and should already be usable for that.
>
> How do I cause a command to use "interrupt driven" PIO mode
> with these patches?  I could try it to make sure it still works.
>
Please apply the following patch 1/3:
http://marc.theaimsgroup.com/?l=linux-ide&m=112736217011430&w=2

The ata_qc_issue_prot() is changed. So qs_intr_mmio() will be called not 
only to complete a command, but also for PIO data transfer, atapi cdb 
intr, etc.

Albert


