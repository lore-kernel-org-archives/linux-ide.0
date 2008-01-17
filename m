From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Thu, 17 Jan 2008 23:23:03 +0000
Message-ID: <20080117232303.3f34c87a@lxorguk.ukuu.org.uk>
References: <200801172150.57059.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49030 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755634AbYAQXYy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2008 18:24:54 -0500
In-Reply-To: <200801172150.57059.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Thu, 17 Jan 2008 21:50:56 +0300
Anton Salnikov <asalnikov@ru.mvista.com> wrote:

> This is Palmchip BK3710 IDE controller support for kernel version 2.6.24-rc8.
> The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
> Supports interface to compact Flash (CF) configured in True-IDE mode.

New drivers should really be going at least parallel into drivers/ata and
legacy IDE.

> +struct palm_bk3710_ideconfigregs {
> +	unsigned short idetimp __attribute__((packed));
> +	unsigned short idetims __attribute__((packed));
> +	unsigned char sidetim;
> +	unsigned short slewctl __attribute__((packed));
> +	unsigned char idestatus;
> +	unsigned short udmactl __attribute__((packed));
> +	unsigned short udmatim __attribute__((packed));
> +	unsigned char rsvd0[4];
> +	unsigned int miscctl __attribute__((packed));
> +	unsigned int regstb __attribute__((packed));

NAK - the size of an unsigned int in the kernel isn't defined. All the
packed stuff is also horribly platform dependant. True the driver is ARM
only currently but that doesn't make it a good idea.

Can't you use defined offsets ?


> +struct palm_bk3710_ideregs {
> +	struct palm_bk3710_dmaengineregs dmaengine;

So why are only some packed ?

> +		/* udmatim Register */
> +		palm_bk3710_base->config.udmatim &= 0xFFF0;
> +		palm_bk3710_base->config.udmatim |= level;

Direct memory access to I/O space - should be using read/write functions


> +	if (mate && mate->present) {
> +		u8 mode2 = ide_get_best_pio_mode(mate, 255, 4);

If the pair device is present but not in the best mode it can do this
will be wrong surely ?


> +	if (!request_region(mem->start, 8, palm_bk3710_hwif->name)) {
> +		printk(KERN_ERR "Error, ports in use.\n");
> +		return -EBUSY;
> +	}
> +
> +	palm_bk3710_hwif->dmatable_cpu = dma_alloc_coherent(
> +				NULL,
> +				PRD_ENTRIES * PRD_BYTES,
> +				&palm_bk3710_hwif->dmatable_dma,
> +				GFP_ATOMIC);
> +
> +	if (!palm_bk3710_hwif->dmatable_cpu) {

Leaks the reserved region

> +		printk(KERN_ERR "Error, unable to allocate DMA table.\n");
> +		return -ENOMEM;
> +	}

> -static void ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
> +void ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
>  {
>  	/* issue cmd to drive */
>  	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, 
> dma_timer_expiry);
>  }
> +EXPORT_SYMBOL(ide_dma_exec_cmd);

These are not needed the NULL default request will fill them in for you

Alan
