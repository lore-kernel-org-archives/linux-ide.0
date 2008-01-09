From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: eliminate the home grown dma padding in favour
 of	that provided by the block layer
Date: Wed, 09 Jan 2008 14:13:50 +0900
Message-ID: <4784580E.3060000@gmail.com>
References: <1199138168.3110.12.camel@localhost.localdomain>	 <47842D29.8020509@gmail.com> <1199852673.3534.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1199852673.3534.76.camel@localhost.localdomain>
Sender: linux-scsi-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jens Axboe <Jens.Axboe@oracle.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

James Bottomley wrote:
>>  Also, DMA alignment at
>> block layer isn't enough for ATA.  ATA needs drain buffers for ATAPI
>> commands with variable length response.  :-(
> 
> OK, where is this in the libata code?  The dma_pad size is only 4 bytes,
> so this drain, I assume is only a word long?  Given the word alignment
> requirements of ATA doesn't this still mean it's only draining up to the
> word boundary anyway (so the code is still correct)?

Patch is acked but not merged yet.

http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=commit;h=6cd22a0febc74bebe52d58eb22271b8770892a2d

The full function can be read from the following.  It's
ata_sg_setup_extra().

http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=blob;f=drivers/ata/libata-core.c;h=d763c072e6cefc724ea24cb68a7adf47b340f054;hb=6cd22a0febc74bebe52d58eb22271b8770892a2d

-- 
tejun
