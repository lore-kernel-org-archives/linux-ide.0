From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/12] libata: kill ata_id_to_dma_mode()
Date: Tue, 27 Nov 2007 22:52:17 +0900
Message-ID: <474C2111.7080809@gmail.com>
References: <11961602293422-git-send-email-htejun@gmail.com>	<11961602303295-git-send-email-htejun@gmail.com> <20071127113035.46806f39@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.179]:55551 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXK0NwZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 08:52:25 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1665722roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 05:52:25 -0800 (PST)
In-Reply-To: <20071127113035.46806f39@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Tue, 27 Nov 2007 19:43:41 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> ata_id_to_dma_mode() isn't quite generic.  The function is basically
>> privately implemented ata_id_xfermask() combined with hardcoded mode
>> printing and configuration which are specific to ata_generic.
>>
>> Kill the function and open code it in generic_set_mode() using generic
>> xfermode handling functions.
> 
> That one I still think is a bad idea. This sort of internal knowledge
> belongs in library routines. It is a pretty generic function for the case
> where the device is using existing modes and wants to display them.

The thing that bothers me is that the code assumes SWDMA and reports
"DMA" and sets xfer_mask for MWDMA0.  This is specific to ata_generic
and with that part removed, what can be factored out is...

	ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
		       ata_mode_string(xfer_mask));
	dev->xfer_mode = ata_xfer_mask2mode(xfer_mask);
	dev->xfer_shift = ata_xfer_mode2shift(dev->xfer_mode);

Unfortunately, ata_generic won't be able to use such generic helper
because it uses unspecified DMA and PIO modes which generic helper
wouldn't support.

Unless we are gonna have other drivers which would blindly trust device
setting regarding PIO/DMA modes, I don't think ata_id_to_dma_mode()
would be useful, and if we are going to have more such drivers, we at
least need to rename ata_id_to_dma_mode() to note that the function
blindly trusts device reported configuration.

Thanks.

-- 
tejun
