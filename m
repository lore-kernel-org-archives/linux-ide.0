From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pata_bf54x: fix BMIDE status register emulation
Date: Fri, 30 Dec 2011 13:59:47 +0400
Message-ID: <4EFD8B93.1020405@mvista.com>
References: <201112281836.45834.sshtylyov@ru.mvista.com> <DB904C5425BA6F4E8424B3B51A1414D16D768609F8@NWD2CMBX1.ad.analog.com> <4EFC74C0.5030802@mvista.com> <DB904C5425BA6F4E8424B3B51A1414D16D76860ACB@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:52317 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1L3KAw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Dec 2011 05:00:52 -0500
Received: by wgbds13 with SMTP id ds13so19472248wgb.1
        for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2011 02:00:50 -0800 (PST)
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16D76860ACB@NWD2CMBX1.ad.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>

Hello.

On 30-12-2011 10:07, Zhang, Sonic wrote:

>> SG list was not implemented in pata_bf54x driver from the beginning, because ATAPI controller on BF54x support maximum 131070 bytes in one BMDMA transfer.

>      So what? You can chain transfers in software, using "done" interrupts I think...

> Sonic>  I just figure out that this can be solved by setting the max sg_tablesize to 4.

    Why to 4?

>> The size in sg list buffers may exceeds this limitation easily. Do you know a way to set the maximum total buffer size in a sg list?

>      Maybe thru 'max_sectors' field in scsi_host_template? Though sectors can be
> of different size...

> Sonic>  max_sectors doesn't affect the max size of a sg list.

>> Static struct scsi_host_template bfin_sht = {
>>           ATA_BASE_SHT(DRV_NAME),
>>           .sg_tablesize                   = SG_NONE,
>>           .dma_boundary           = ATA_DMA_BOUNDARY,
>> };

>      Ah, I have overlooked this. Anyway 'dma_boundary' should be twice more than
> ATA_DMA_BOUNDARY.

> Sonic>  I don't find this boundary limit in the spec of the DMA controller for BF54x ATAPI device.

    You just mentioned that ATAPI controller can transfer only 128KB in one go.

> So, it can be removed.

>> Sonic

>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]
>> Sent: Wednesday, December 28, 2011 11:37 PM
>> To: linux-ide@vger.kernel.org; jgarzik@pobox.com; Zhang, Sonic
>> Subject: [PATCH] pata_bf54x: fix BMIDE status register emulation

>> The author of this driver clearly wasn't familiar with the BMIDE specification
>> (also known as SFF-8038i) when he implemented the bmdma_status() method: first,
>> the interrupt bit of the BMIDE status register corresponds to nothing else but
>> INTRQ signal (ATAPI_DEV_INT here); second, the error bit is only set if the
>> controller encounters issue doing the bus master transfers, not on the DMA burst
>> termination interrupts like here (moreover, setting the error bit doesn't cause
>> an interrupt).

>> (The only thing I couldn't figure out is how to flush the FIFO to memory once
>> the interrupt happens as required by the mentioned spec.)

>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

>> ---
>> The patch is against the current Linus' tree.
>> Sonic, if you still work in Analog Devices, please give this a try.

>> I looked over the driver, and it left pretty bad impression. In particular,
>> I highly doubt that the transfers with more than one S/G item can work. And
>> this is after the driver has been in the kernel for 4 years already...
>> Unfortunately, I have neither hardware nor much time to work on improving it...

WBR, Sergei
