From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: implement and use DMA mask configuration helper
Date: Sun, 18 Mar 2007 13:47:48 -0400
Message-ID: <45FD7B44.5040509@garzik.org>
References: <20070309104945.GG32687@htj.dyndns.org> <45F155E3.9040604@garzik.org> <45FD5154.9040603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45956 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbXCRRru (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Mar 2007 13:47:50 -0400
In-Reply-To: <45FD5154.9040603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Implement and use DMA mask configuration helper.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>> ---
>>> This function probably belongs to pci layer.  Put it in libata with
>>> pci_test_bits() for the time being.
>> AFAIK the default DMA mask is always 32-bit.  Code (often written by me)
>> that sets it to a 32-bit mask was just paranoia, and not really needed.
>>
>> Hence, the pci_go_64() function I added, found in #upstream.
> 
> It isn't in #upstream yet.  Also, at the second thought, there is a
> problem with pci_go_64().  DMA masks are not reset after driver is
> detached.  Even if the device starts with 32bit DMA masks, after a 64bit
> enabled driver is attached and detached, the device's DMA masks are
> 64bit.  I'm refreshing new-init-model patchset and keeping
> pci_configure_dma_masks() for now.

That "problem" has existed since day one, and nobody seems to care :)

I can't think of a single 64-bit-capable driver that restores the masks, 
and can't think of a single bug report that resulted from it.

	Jeff



