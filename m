From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/14] sata_mv Mask transient IRQs.
Date: Sat, 26 Jan 2008 10:11:45 -0500
Message-ID: <479B4DB1.2080209@rtr.ca>
References: <4798FB68.70400@rtr.ca> <4798FBCC.2040309@rtr.ca> <479AB2D0.20001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3554 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbYAZPLr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 10:11:47 -0500
In-Reply-To: <479AB2D0.20001@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> sata_mv Mask transient IRQs.
>>
>> The chips can handle many transient errors internally without a 
>> software IRQ.
>> We now mask/ignore those interrupts here.  This is necessary for NCQ, 
>> later on.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>> --- old/drivers/ata/sata_mv.c    2008-01-24 11:11:26.000000000 -0500
>> +++ new/drivers/ata/sata_mv.c    2008-01-24 11:17:42.000000000 -0500
>> @@ -170,7 +170,7 @@
>>
>>     PCIE_IRQ_CAUSE_OFS    = 0x1900,
>>     PCIE_IRQ_MASK_OFS    = 0x1910,
>> -    PCIE_UNMASK_ALL_IRQS    = 0x70a,    /* assorted bits */
>> +    PCIE_UNMASK_ALL_IRQS    = 0x40a,    /* assorted bits */
>>
>>     HC_MAIN_IRQ_CAUSE_OFS    = 0x1d60,
>>     HC_MAIN_IRQ_MASK_OFS    = 0x1d64,
>> @@ -241,17 +241,36 @@
>>     EDMA_ERR_BIST_ASYNC    = (1 << 8),    /* BIST FIS or Async Notify */
>>     EDMA_ERR_TRANS_IRQ_7    = (1 << 8),    /* Gen IIE transprt layer 
>> irq */
>>     EDMA_ERR_CRQB_PAR    = (1 << 9),    /* CRQB parity error */
>> -    EDMA_ERR_CRPB_PAR    = (1 << 10),    /* CRPB parity error */
>> -    EDMA_ERR_INTRL_PAR    = (1 << 11),    /* internal parity error */
>> -    EDMA_ERR_IORDY        = (1 << 12),    /* IORdy timeout */
>> -    EDMA_ERR_LNK_CTRL_RX    = (0xf << 13),    /* link ctrl rx error */
>> -    EDMA_ERR_LNK_CTRL_RX_2    = (1 << 15),
>> -    EDMA_ERR_LNK_DATA_RX    = (0xf << 17),    /* link data rx error */
>> -    EDMA_ERR_LNK_CTRL_TX    = (0x1f << 21),    /* link ctrl tx error */
>> -    EDMA_ERR_LNK_DATA_TX    = (0x1f << 26),    /* link data tx error */
>> -    EDMA_ERR_TRANS_PROTO    = (1 << 31),    /* transport protocol 
>> error */
>> -    EDMA_ERR_OVERRUN_5    = (1 << 5),
>> -    EDMA_ERR_UNDERRUN_5    = (1 << 6),
>> +    EDMA_ERR_CRPB_PAR    = (1 << 10),    /* CRPB parity error */
>> +    EDMA_ERR_INTRL_PAR    = (1 << 11),    /* internal parity error */
>> +    EDMA_ERR_IORDY        = (1 << 12),    /* IORdy timeout */
>> +
>> +    EDMA_ERR_LNK_CTRL_RX    = (0xf << 13),    /* link ctrl rx error */
>> +    EDMA_ERR_LNK_CTRL_RX_0    = (1 << 13),    /* transient: CRC err */
>> +    EDMA_ERR_LNK_CTRL_RX_1    = (1 << 14),    /* transient: FIFO err */
>> +    EDMA_ERR_LNK_CTRL_RX_2    = (1 << 15),    /* fatal: caught SYNC */
>> +    EDMA_ERR_LNK_CTRL_RX_3    = (1 << 16),    /* transient: FIS rx 
>> err */
>> +
>> +    EDMA_ERR_LNK_DATA_RX    = (0xf << 17),    /* link data rx error */
>> +
>> +    EDMA_ERR_LNK_CTRL_TX    = (0x1f << 21),    /* link ctrl tx error */
>> +    EDMA_ERR_LNK_CTRL_TX_0    = (1 << 21),    /* transient: CRC err */
>> +    EDMA_ERR_LNK_CTRL_TX_1    = (1 << 22),    /* transient: FIFO err */
>> +    EDMA_ERR_LNK_CTRL_TX_2    = (1 << 23),    /* transient: caught 
>> SYNC */
>> +    EDMA_ERR_LNK_CTRL_TX_3    = (1 << 24),    /* transient: caught 
>> DMAT */
>> +    EDMA_ERR_LNK_CTRL_TX_4    = (1 << 25),    /* transient: FIS 
>> collision */
>> +
>> +    EDMA_ERR_LNK_DATA_TX    = (0x1f << 26),    /* link data tx error */
>> +
>> +    EDMA_ERR_TRANS_PROTO    = (1 << 31),    /* transport protocol 
>> error */
>> +    EDMA_ERR_OVERRUN_5    = (1 << 5),
>> +    EDMA_ERR_UNDERRUN_5    = (1 << 6),
>> +
>> +    EDMA_ERR_IRQ_TRANSIENT  = EDMA_ERR_LNK_CTRL_RX_0 |
>> +                  EDMA_ERR_LNK_CTRL_RX_1 |
>> +                  EDMA_ERR_LNK_CTRL_RX_3 |
>> +                  EDMA_ERR_LNK_CTRL_TX,
>> +
>>     EDMA_EH_FREEZE        = EDMA_ERR_D_PAR |
>>                   EDMA_ERR_PRD_PAR |
>>                   EDMA_ERR_DEV_DCON |
> 
> Overall operational changes -- ACK
> 
> However, I do not want to remove definitions for unchecked hardware 
> bits, because the documentation is not public.
..

Sure thing.  But the patch above does NOT remove any.

Cheers
