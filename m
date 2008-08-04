From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SW-IOMMU / ata_piix errors with 2.6.27-rc1
Date: Sun, 03 Aug 2008 20:47:10 -0600
Message-ID: <48966DAE.2020203@shaw.ca>
References: <fa.64b92XSd5HpCdpOYcDENnJSZJyw@ifi.uio.no> <4896157A.2020907@shaw.ca> <4896500E.2040304@blackdown.de> <48966728.5080901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:55826 "EHLO
	pd2mo1so-dmz.prod.shaw.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753946AbYHDCrM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 22:47:12 -0400
In-Reply-To: <48966728.5080901@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Juergen Kreileder <jk@blackdown.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Juergen Kreileder wrote:
>> Robert Hancock wrote:
>>> Juergen Kreileder wrote:
>>>> Hi,
>>>>
>>>> I get lots of errors like this with 2.6.27-rc1 on my
>>>> Macbook Pro (3rd generation), 2.6.26 seems to work fine:
>>>>
>>>> [  907.524509] DMA: Out of SW-IOMMU space for 45056 bytes at device 0000:00:1f.2
>>>> [  907.524783] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>>>> [  907.524796] ata3.00: cmd 35/00:50:08:91:5c/00:01:0f:00:00/e0 tag 0 dma 172032 out
>>>> [  907.524798]          res 50/00:00:ff:90:5c/00:00:0f:00:00/ef Emask 0x40 (internal error)
>>>> [  907.524805] ata3.00: status: { DRDY }
>>>> [  907.646590] ata3.00: configured for UDMA/133
>>>> [  907.646624] ata3: EH complete
>>>> Any suggestions?
>>> You can try increasing the swiotlb size by booting with swiotlb=65536 
>>> (for 128MB) or swiotlb=131072 (for 256MB), and see if that makes the 
>>> problem go away.. It's unclear why you'd be running out of SWIOTLB space 
>>> now, though, if 2.6.26 worked fine..
>> Still happening, although 256M make it a bit harder to trigger.
> 
> Hmm... sounds like mapping is leaking.  Eh... iommu leak debug seems to
> support only AMD GART IOMMU.  How long does it take to reproduce the
> bug?  Once it happens, it never recovers, right?  Does the problem
> happen with minimal configuration w/ only libata enabled (no network, no
> sound, no usb...)?

Yes, that would be a good test.. Easiest way might be booting with 
init=/bin/sh and running some processes that do lots of disk access..
