From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sun, 01 Feb 2009 00:03:27 +0300
Message-ID: <4984BC9F.3090200@ru.mvista.com>
References: <49615667.9020408@iwl.com> <200901051736.18026.bzolnier@gmail.com> <49628C95.7080507@ru.mvista.com> <200901111847.12080.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40002 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752189AbZAaVDf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 16:03:35 -0500
In-Reply-To: <200901111847.12080.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> +enum {
>>> +	MSR_IDE_CFG		= 0x51300010,
>>> +	PCI_IDE_CFG		= 0x40,
>>> +
>>> +	CFG			= 0,
>>> +	DTC			= 2,
>>> +	CAST			= 3,
>>> +	ETC			= 4,
>>> +
>>> +	IDE_CFG_CHANEN		= (1 << 1),
>>> +	IDE_CFG_CABLE		= (1 << 17) | (1 << 16),
>>> +
>>> +	IDE_D0_SHIFT		= 24,
>>> +	IDE_D1_SHIFT		= 16,
>>> +	IDE_DRV_MASK		= 0xff,
>>> +
>>> +	IDE_CAST_D0_SHIFT	= 6,
>>> +	IDE_CAST_D1_SHIFT	= 4,
>>> +	IDE_CAST_DRV_MASK	= 0x3,
>>> +
>>> +	IDE_CAST_CMD_SHIFT	= 24,
>>> +	IDE_CAST_CMD_MASK	= 0xff,
>>> +};
>>>   
>>>       
>>    Declaring a lot of semi-related constants is not what enum was 
>> intended for I think...
>>     
>
> Don't know about that but it is still better than using defines.
>   

   That's what I doubt...

>>> +	cs5536_read(dev, CFG, &cfg);
>>> +
>>> +	if ((cfg & IDE_CFG_CHANEN) == 0) {
>>> +		printk(KERN_ERR DRV_NAME ": disabled by BIOS\n");
>>> +		return -ENODEV;
>>>   
>>>       
>>    Eh, why not do it via the usual .enablebits mechanism?
>>     
>
> Because we may be using MSR access instead of PCI one.
>   

   Ah...

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: add CS5536 host driver (v2)
>
> This is a port of libata's pata_cs5536.c (written by Martin K. Petersen)
> to IDE subsystem.
>
> Changes done while at it:
>
> * Reprogram PIO/MWDMA timings if needed before and after DMA transfer
>   (chipset uses shared PIO/MWDMA timings).
>
> * Fix cable detection to report 80-wires cable if BIOS set it for any
>   device on a port (IDE core will do drive-side cable detection later).
>
> * Don't disable UDMA while programming PIO timings.
>
> * Simplify PCI/MSR support.
>
> Pros of having IDE host driver in addition to libata's one:
>
> * IDE is much lighter than SCSI+libata, the host driver itself is also
>   a bit smaller:
>
>    text    data     bss     dec     hex filename
>    1237     500       4    1741     6cd drivers/ata/pata_cs5536.o
>    1214     128       4    1346     542 drivers/ide/cs5536.o
>
> * This allows use of IDE features which are unavailable under libata.
>
> v2:
> * Fixes per review from Sergei:
>   - simplify dependency check in Kconfig
>   - use IDE_DRV_MASK also for ->drive_data
>   - disable UDMA when programming MWDMA
>   - program new DTC timings only when necessary
>   - fix printk() level in cs5536_init_one()
>
> * Fix patch description according to comments from Alan and Sergei.
>
> Cc: Martin K. Petersen <mkp@mkp.net>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: Karl Auerbach <karl@iwl.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> v1->v2 interdiff only
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


> diff -u b/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
> --- b/drivers/ide/cs5536.c
> +++ b/drivers/ide/cs5536.c
> @@ -61,6 +61,9 @@
>  
>  	IDE_CAST_CMD_SHIFT	= 24,
>  	IDE_CAST_CMD_MASK	= 0xff,
> +
> +	IDE_ETC_UDMA_RELSHIFT	= 6,
> +	IDE_ETC_UDMA_MASK	= 0x3,
>   

   Too many shifts and mask values to my taste, why not just use 0xC0?

> @@ -186,22 +189,24 @@
>  	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
>  	u32 etc;
>  
> -	if (mode >= XFER_UDMA_0) {
> -		cs5536_read(pdev, ETC, &etc);
> +	cs5536_read(pdev, ETC, &etc);
>  
> +	if (mode >= XFER_UDMA_0) {
>  		etc &= ~(IDE_DRV_MASK << dshift);
>   

   Er, I'm not sure using IDE_DRV_MASK here is completely correct as 
only the mask 0xC7 actually controls UltraDMA enables and cycle time...

MBR, Sergei


