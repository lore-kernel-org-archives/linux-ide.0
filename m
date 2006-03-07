From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] implement and use port_task
Date: Tue, 07 Mar 2006 02:21:09 -0500
Message-ID: <440D3465.1040203@pobox.com>
References: <11415401073423-git-send-email-htejun@gmail.com> <440D2497.7050504@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:63679 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932415AbWCGHVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2006 02:21:18 -0500
In-Reply-To: <440D2497.7050504@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Albert Lee wrote:
> Something related to the PIO HSM.
> After the task renaming by this patchset, the task name is changed from pio_task to port_task.
> Should we add polling DMA support to the polling HSM?
> It could make the polling HSM more complete.
> 
> Polling DMA does no performance gain. However, DMA has crc check,
> so it won't be worse than PIO when irq is not working.


Polling DMA support with nIEN=1 is theoretically invalid.  You are not 
supposed to touch the ATA shadow register set until after receiving an 
irq event.

On chipsets where nIEN=0 and the chip's IntrMask is also zero, its doable.

I'm satisfied with simply never doing polling DMA, and change our mind 
only if a critical need arises.

	Jeff



