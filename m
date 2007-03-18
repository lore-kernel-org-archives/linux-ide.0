From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement and use DMA mask configuration helper
Date: Mon, 19 Mar 2007 02:54:18 +0900
Message-ID: <45FD7CCA.40500@gmail.com>
References: <20070309104945.GG32687@htj.dyndns.org> <45F155E3.9040604@garzik.org> <45FD5154.9040603@gmail.com> <45FD7B44.5040509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:10304 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbXCRRyW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 13:54:22 -0400
Received: by nz-out-0506.google.com with SMTP id s1so510733nze
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 10:54:22 -0700 (PDT)
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

In reality, it shouldn't really matter as unloading and loading
different drivers for the same device is extremely rare.  Still
incorrect tho.  Just making pci_enable_device() reset both DMA masks to
32bit should do the trick.

-- 
tejun
