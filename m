From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement and use DMA mask configuration helper
Date: Mon, 09 Apr 2007 18:20:30 +0900
Message-ID: <461A055E.2050506@gmail.com>
References: <20070309104945.GG32687@htj.dyndns.org> <45F155E3.9040604@garzik.org> <45FD5154.9040603@gmail.com> <45FD7B44.5040509@garzik.org> <4619ECB7.9060601@gmail.com> <4619FDA7.10007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:7583 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbXDIJUf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 05:20:35 -0400
Received: by nz-out-0506.google.com with SMTP id s1so983614nze
        for <linux-ide@vger.kernel.org>; Mon, 09 Apr 2007 02:20:35 -0700 (PDT)
In-Reply-To: <4619FDA7.10007@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff, there are further problems with doing pci_go_64() only on devices
>> which support 64bit.  pci_set_dma_mask() is the only place where the PCI
>> code can test whether DMA is usable or not, so if we don't configure DMA
>> mask on 32bit controllers, there's no way to tell whether DMA is allowed
>> on the controller/bus or not.  We end up blindly enabling bus mastering
>> without consulting the PCI bus.
>>
>> I think it's just cleaner to do pci_configure_dma_masks() on all cases
>> with proper DMA mask.
> 
> 
> There is always a cleaner solution :)
> 
> My implementation is based on current practice for all 64-bit drivers.
> 
> If you wish to change current practice, that is another matter...

The thing is that in the current implementation, we do the following.

1. For 32bit devices, we do set_dma/set_persistent to set 32bit masks
manually.

2. For 64bit devices, we do set_dma/set_persistent to set 64bit masks
but falls back to 32bit.  This is sometimes done manually sometimes
using a helper (pci_go_64).

This patch tries to do #1 and #2 in the same way and the end result
doesn't change - we're just using the same helper function instead of
doing things directly for both 32bit and 64bit cases.  Are you
suggesting to just generalize pci_go_64 and leave 32bit cases as they are?

Thanks.

-- 
tejun
