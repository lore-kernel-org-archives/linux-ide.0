From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 8/10] libata: remove writing of tf->ctl from ata_tf_load()
Date: Wed, 04 Jul 2007 15:09:11 -0400
Message-ID: <468BF057.9060408@rtr.ca>
References: <468B5C97.1000803@tw.ibm.com> <468B627A.6050605@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1934 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756804AbXGDTJN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 15:09:13 -0400
In-Reply-To: <468B627A.6050605@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Albert Lee wrote:
> Patch 8/10:
>  
> The relevant bits in the ctl register are HOB, SRST and nIEN.
>  - HOB is only used by ata_tf_read().
>  - For SRST, soft reset is not the duty of tf_load.
>  - For nIEN, explicit irq_on()/irq_off and freeze()/thaw() are provided.
> 
>   Since EH/HSM now call explicit freeze()/thaw() for irq off/on.
> Remove the implicit nIEN handling from ata_tf_load().

At some point soon, I hope to piece together enough old hardware here
to reconnect my PCI-X sata_qstor card, and then fix the driver.

It needs to have control over the nIEN bit, and currently that bit
is not behaving as it did way back in 2.6.11(?) when the driver was
first added.

The qstor chip *requires* that nIEN be "1" during R/W commands.
Is there a nice way to accomplish that here?

Thanks
