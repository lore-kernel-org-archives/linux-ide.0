From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH libata-2.6 4/5] Prevent the device from overrunning the
 buffer in __atapi_pio_bytes()
Date: Tue, 22 Mar 2005 14:11:52 -0500
Message-ID: <42406DF8.6050504@pobox.com>
References: <423A8AA4.5040601@tw.ibm.com> <58cb370e0503180031d40b0a3@mail.gmail.com> <423A9989.7050008@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20168 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261665AbVCVTMH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Mar 2005 14:12:07 -0500
In-Reply-To: <423A9989.7050008@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
>  >
>  > Bartlomiej Zolnierkiewicz wrote:
> 
>>>
>>> Problem:
>>>   Some bad behaved CD-ROM drives will return more data than ask to.
>>> (I have such CD-RW drive and it crashed the kernel.)
>>
>>
>>
>> These devices are compliant with original ATAPI spec.
>>
>> Such condition shouldn't be treated as an error
>> - extra data should be read and dumped.
>>
>>
> Hi Bart,
> 
> For read, we can read and discard the extra data from the device.
> For write, the device is asking for more data than we have.
> Should we supply some dummy data to the device? Or we just stop and 
> return it as error?

For write, we need to pad.  For DMA, we need to add additional zeroes, 
until the DMA transfer ends on a dword boundary.  For PIO, we must at 
least pad to a word boundary.

	Jeff


