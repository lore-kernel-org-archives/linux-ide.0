From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Tue, 09 Sep 2008 21:08:14 +0400
Message-ID: <48C6AD7E.10005@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp> <20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:57065 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752518AbYIIRHk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 13:07:40 -0400
In-Reply-To: <20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Alan Cox wrote:

>>+#define TX4939IDE_readl(base, reg) \
>>+	__raw_readl((void __iomem *)((base) + TX4939IDE_REG32(reg)))
>>+#define TX4939IDE_readw(base, reg) \
>>+	__raw_readw((void __iomem *)((base) + TX4939IDE_REG16(reg)))
>>+#define TX4939IDE_readb(base, reg) \
>>+	__raw_readb((void __iomem *)((base) + TX4939IDE_REG8(reg)))
>>+#define TX4939IDE_writel(val, base, reg) \
>>+	__raw_writel(val, (void __iomem *)((base) + TX4939IDE_REG32(reg)))
>>+#define TX4939IDE_writew(val, base, reg) \
>>+	__raw_writew(val, (void __iomem *)((base) + TX4939IDE_REG16(reg)))
>>+#define TX4939IDE_writeb(val, base, reg) \
>>+	__raw_writeb(val, (void __iomem *)((base) + TX4939IDE_REG8(reg)))

> It's generally frowned upon to hide all the detail in macros, it is much
> easier to read and understand the code if you don't do this.

>>+#define TX4939IDE_BASE(hwif)	((hwif)->io_ports.data_addr & ~0xfff)

> Why do you have void __iomem casts all over the write methods not in the
> _BASE() method - that would let sparse do its job properly

    I don't get why there's need for & at all -- isn't IDE data register 
address always on 4K boundary?

>>+	for (i = 0; i < MAX_DRIVES; i++) {
>>+		if (drive != &hwif->drives[i] &&

> You don't actually need the first test.

    No, he does need it -- in order not to clamp the new PIO mode based on the 
previosly selected one. Although, one should call ide_get_paired_drive() ISO 
this loop.

> This also appears wrong. In your
> tests MW_DMA_0 is 'faster' than PIO4 but in fact MW_DMA_0 PIO timings are
> *slower* than PIO4 so the mode is not in fact slower.

    I don't think it's about the DMA timings at all. Though indeed, MWDMA0/1 
do (iff it's drive's max) implies slower max PIO mode than PIO4.

>>+	case XFER_MW_DMA_2:
>>+	case XFER_MW_DMA_1:
>>+	case XFER_MW_DMA_0:
>>+	case XFER_PIO_4:
>>+		value |= 0x0400;
>>+		break;

> This looks odd according to the speed tables. Can you clarify what is
> going on ?

    This apparently selects the command PIO timing safest for both drives but 
does this incorrectly -- the current DMA (or even PIO) mode shouldn't be a 
part of the equation.  There are several examples how to do this including 
siimage.c and cs5535.c...

MBR, Sergei
