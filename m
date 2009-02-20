From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_nv frees DMA memory with different size (possibly a generic
 libata bug)
Date: Thu, 19 Feb 2009 20:58:35 -0600
Message-ID: <499E1C5B.1050207@gmail.com>
References: <20090217202156B.fujita.tomonori@lab.ntt.co.jp>	<20090218152516.7b4457b3@dhcp-100-2-144.bos.redhat.com>	<20090218170544.714e53a8@dhcp-100-2-144.bos.redhat.com> <20090219220901R.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:46571 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZBTC6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Feb 2009 21:58:39 -0500
Received: by gxk22 with SMTP id 22so2023245gxk.13
        for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2009 18:58:38 -0800 (PST)
In-Reply-To: <20090219220901R.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: cebbert@redhat.com, linux-ide@vger.kernel.org, wes.shull@gmail.com

FUJITA Tomonori wrote:
> On Wed, 18 Feb 2009 17:05:44 -0500
> Chuck Ebbert <cebbert@redhat.com> wrote:
> 
>> On Wed, 18 Feb 2009 15:25:16 -0500
>> Chuck Ebbert <cebbert@redhat.com> wrote:
>>
>>> On Tue, 17 Feb 2009 20:22:05 +0900
>>> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
>>>
>>>  
>>>>>>>> sata_nv 0000:00:0d.0: DMA-API: device driver frees DMA memory with different
>>>>>>>> size [device address=0x00000000da031000] [map size=4096 bytes] [unmap
>>>>>>> That's rather curious. It seems to be saying that the sg length is 
>>>>>>> different between the map and unmap, but it doesn't look like sata_nv 
>>>>>>> mucks with that anywhere, and neither does libata core..
>>>>>> Could the SCSI code have merged two requests?
>>>>> I wouldn't think so.. and if it did it seems like it would have to have 
>>>>> changed the list after libata got the request somehow..
>>>> Does this box uses GART IOMMU?
>>> I don't think so, but I've asked for the dmesg.
>> Okay, it _is_ using GART IOMMU:
>>
>> DMA-API: preallocated 8192 debug entries
>> DMA-API: debugging enabled by kernel config
>> PCI-DMA: Disabling AGP.
>> PCI-DMA: aperture base @ 20000000 size 65536 KB
>> PCI-DMA: using GART IOMMU.
>> PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> 
> Thanks, that makes sense.
> 
> I think that the following patch could fix this:
> 
> http://marc.info/?l=linux-ide&m=123484533504307&w=2

The patch looks reasonable to me. I'm CCing the reporter of the bug. 
Wes, would you be able to test out Fujita's patch linked above?
