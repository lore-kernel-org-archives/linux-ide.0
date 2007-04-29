From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 12:51:25 +0900
Message-ID: <4634163D.1040408@gmail.com>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:61328 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbXD2DwY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 23:52:24 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1301857wra
        for <linux-ide@vger.kernel.org>; Sat, 28 Apr 2007 20:52:23 -0700 (PDT)
In-Reply-To: <46340E63.5070209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Jeff Garzik wrote:
>>> It's not really a good idea for SATA.  The "FIFO" often co-emulated by
>>> the SATA controller and SATA phy.  You just want to kick SATA really
>>> hard (i.e. bus reset and friends).
>> Sure.  So why don't we do that now?
> 
> We do that.  It's just that ata_piix is lacking SControl access so all
> we can do is SRST not PHY hardreset.  I don't think draining
> FIFO/whatever on most SATA controllers would be unnecessary as PHY
> hardreset would make most drives forget what they were doing.  I thought
> SRST would have similar effect.  It's supposed to reset the device's HSM
> and thus clear DRQ, right?  Stuck DRQ after SRST seems odd to me.
> 
> One more thing to note is that there might be no way to drain data
> safely on non-SFF (ahci/sil24...) interfaces and some controllers lock
> the machine up hard when TF registers are accessed in certain unexpected
> way (unsurprisingly, sata_nv), so if we do this, it needs to be
> configurable per-driver.  Another question is how would SATA controllers
> emulating TF interface react when data port is polled after a DMA
> command.  I'm pretty sure many of them would behave erratically.
> 
> Anyways, can you try to hack it into ata_bmdma_error_handler() and see
> whether it actually works?  You can check for AC_ERR_HSM there and drain
> data port if DRQ is set.  After HSM, ATA_NIEN is set and the port should
> be quiescent at that point.

Oh, and one more thing, was the drive SATA or PATA?  I think it could be
the SATA SFF emulation which doesn't reset itself on SRST.  Testing
whether SRST clears DRQ on actual PATA devices would be worthwhile.  If
it's really the controller's emulation HSM that's not getting reset, the
fix definitely should be applied per-driver.

Ah.. one more thing, is this draining also needed after DMA commands or
only after PIO commands?

Thanks.

-- 
tejun
