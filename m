From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 07:56:32 -0400
Message-ID: <463487F0.4040701@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4591 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756386AbXD2L4f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Apr 2007 07:56:35 -0400
In-Reply-To: <4634163D.1040408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Tejun Heo wrote:
>..
>> Anyways, can you try to hack it into ata_bmdma_error_handler() and see
>> whether it actually works?  You can check for AC_ERR_HSM there and drain
>> data port if DRQ is set.  After HSM, ATA_NIEN is set and the port should
>> be quiescent at that point.

Sure, I'll do that here shortly.

> Oh, and one more thing, was the drive SATA or PATA?

The controller, and libata, think the drive is SATA.
(but it really is PATA with a bridge between it and the controller).

> Ah.. one more thing, is this draining also needed after DMA commands or
> only after PIO commands?

Dunno about DMA -- this instance was just an IDENTIFY command (PIO).
I think the drive also does IDENTIFY_DMA, though, so I can try that too.

Cheers
