From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH] pata_bf54x: fix BMIDE status register emulation
Date: Fri, 30 Dec 2011 01:07:03 -0500
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16D76860ACB@NWD2CMBX1.ad.analog.com>
References: <201112281836.45834.sshtylyov@ru.mvista.com>
 <DB904C5425BA6F4E8424B3B51A1414D16D768609F8@NWD2CMBX1.ad.analog.com>
 <4EFC74C0.5030802@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:56381
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750916Ab1L3GG6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Dec 2011 01:06:58 -0500
In-Reply-To: <4EFC74C0.5030802@mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>

Hi,

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
Sent: Thursday, December 29, 2011 10:10 PM
To: Zhang, Sonic
Cc: Sergei Shtylyov; linux-ide@vger.kernel.org; jgarzik@pobox.com
Subject: Re: [PATCH] pata_bf54x: fix BMIDE status register emulation

Hello.

On 12/29/2011 02:31 PM, Zhang, Sonic wrote:

> Acked-by: Sonic Zhang<sonic.zhang@analog.com>


> SG list was not implemented in pata_bf54x driver from the beginning, because ATAPI controller on BF54x support maximum 131070 bytes in one BMDMA transfer.

    So what? You can chain transfers in software, using "done" interrupts I think...

Sonic> I just figure out that this can be solved by setting the max sg_tablesize to 4.

> The size in sg list buffers may exceeds this limitation easily. Do you know a way to set the maximum total buffer size in a sg list?

    Maybe thru 'max_sectors' field in scsi_host_template? Though sectors can be
of different size...

Sonic> max_sectors doesn't affect the max size of a sg list.

> Static struct scsi_host_template bfin_sht = {
>          ATA_BASE_SHT(DRV_NAME),
>          .sg_tablesize                   = SG_NONE,
>          .dma_boundary           = ATA_DMA_BOUNDARY,
> };

    Ah, I have overlooked this. Anyway 'dma_boundary' should be twice more than
ATA_DMA_BOUNDARY.

Sonic> I don't find this boundary limit in the spec of the DMA controller for BF54x ATAPI device. So, it can be removed.

> Sonic

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]
> Sent: Wednesday, December 28, 2011 11:37 PM
> To: linux-ide@vger.kernel.org; jgarzik@pobox.com; Zhang, Sonic
> Subject: [PATCH] pata_bf54x: fix BMIDE status register emulation

> The author of this driver clearly wasn't familiar with the BMIDE specification
> (also known as SFF-8038i) when he implemented the bmdma_status() method: first,
> the interrupt bit of the BMIDE status register corresponds to nothing else but
> INTRQ signal (ATAPI_DEV_INT here); second, the error bit is only set if the
> controller encounters issue doing the bus master transfers, not on the DMA burst
> termination interrupts like here (moreover, setting the error bit doesn't cause
> an interrupt).

> (The only thing I couldn't figure out is how to flush the FIFO to memory once
> the interrupt happens as required by the mentioned spec.)

> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

> ---
> The patch is against the current Linus' tree.
> Sonic, if you still work in Analog Devices, please give this a try.
>
> I looked over the driver, and it left pretty bad impression. In particular,
> I highly doubt that the transfers with more than one S/G item can work. And
> this is after the driver has been in the kernel for 4 years already...
> Unfortunately, I have neither hardware nor much time to work on improving it...

WBR, Sergei


