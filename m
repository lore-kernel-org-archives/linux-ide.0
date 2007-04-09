From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: implement and use DMA mask configuration helper
Date: Mon, 09 Apr 2007 04:47:35 -0400
Message-ID: <4619FDA7.10007@garzik.org>
References: <20070309104945.GG32687@htj.dyndns.org> <45F155E3.9040604@garzik.org> <45FD5154.9040603@gmail.com> <45FD7B44.5040509@garzik.org> <4619ECB7.9060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52777 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbXDIIrh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Apr 2007 04:47:37 -0400
In-Reply-To: <4619ECB7.9060601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff, there are further problems with doing pci_go_64() only on devices
> which support 64bit.  pci_set_dma_mask() is the only place where the PCI
> code can test whether DMA is usable or not, so if we don't configure DMA
> mask on 32bit controllers, there's no way to tell whether DMA is allowed
> on the controller/bus or not.  We end up blindly enabling bus mastering
> without consulting the PCI bus.
> 
> I think it's just cleaner to do pci_configure_dma_masks() on all cases
> with proper DMA mask.


There is always a cleaner solution :)

My implementation is based on current practice for all 64-bit drivers.

If you wish to change current practice, that is another matter...

	Jeff


