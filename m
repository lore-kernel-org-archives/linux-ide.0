From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement and use DMA mask configuration helper
Date: Mon, 09 Apr 2007 16:35:19 +0900
Message-ID: <4619ECB7.9060601@gmail.com>
References: <20070309104945.GG32687@htj.dyndns.org> <45F155E3.9040604@garzik.org> <45FD5154.9040603@gmail.com> <45FD7B44.5040509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:44371 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbXDIHfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 03:35:25 -0400
Received: by nz-out-0506.google.com with SMTP id s1so971916nze
        for <linux-ide@vger.kernel.org>; Mon, 09 Apr 2007 00:35:25 -0700 (PDT)
In-Reply-To: <45FD7B44.5040509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> Implement and use DMA mask configuration helper.
>>>>
>>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>>> ---
>>>> This function probably belongs to pci layer.  Put it in libata with
>>>> pci_test_bits() for the time being.
>>> AFAIK the default DMA mask is always 32-bit.  Code (often written by me)
>>> that sets it to a 32-bit mask was just paranoia, and not really needed.
>>>
>>> Hence, the pci_go_64() function I added, found in #upstream.
>>
>> It isn't in #upstream yet.  Also, at the second thought, there is a
>> problem with pci_go_64().  DMA masks are not reset after driver is
>> detached.  Even if the device starts with 32bit DMA masks, after a 64bit
>> enabled driver is attached and detached, the device's DMA masks are
>> 64bit.  I'm refreshing new-init-model patchset and keeping
>> pci_configure_dma_masks() for now.
> 
> That "problem" has existed since day one, and nobody seems to care :)
> 
> I can't think of a single 64-bit-capable driver that restores the masks,
> and can't think of a single bug report that resulted from it.

Jeff, there are further problems with doing pci_go_64() only on devices
which support 64bit.  pci_set_dma_mask() is the only place where the PCI
code can test whether DMA is usable or not, so if we don't configure DMA
mask on 32bit controllers, there's no way to tell whether DMA is allowed
on the controller/bus or not.  We end up blindly enabling bus mastering
without consulting the PCI bus.

I think it's just cleaner to do pci_configure_dma_masks() on all cases
with proper DMA mask.

Thanks.

-- 
tejun
