From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 19:39:03 +0300
Message-ID: <4974ACA7.4060808@ru.mvista.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain> <20090119130322.24745.76137.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:56632 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751491AbZASQid (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 11:38:33 -0500
In-Reply-To: <20090119130322.24745.76137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

based on the promised file rename. :-)

> Index: b/drivers/ide/ide-io-sff.c
> ===================================================================
> --- /dev/null
> +++ b/drivers/ide/ide-io-sff.c
> @@ -0,0 +1,314 @@
> +
> +#include <linux/kernel.h>
> +#include <linux/ide.h>
> +
> +/*
> + *	Conventional PIO operations for ATA devices
> + */
> +
> +static u8 ide_inb(unsigned long port)
> +{
> +	return (u8) inb(port);
> +}
> +
> +static void ide_outb(u8 val, unsigned long port)
> +{
> +	outb(val, port);
> +}
> +
> +/*
> + *	MMIO operations, typically used for SATA controllers
> + */
> +
> +static u8 ide_mm_inb(unsigned long port)
> +{
> +	return (u8) readb((void __iomem *) port);
> +}
> +
> +static void ide_mm_outb(u8 value, unsigned long port)
> +{
> +	writeb(value, (void __iomem *) port);
> +}


    Inconsistent spacing in the type casts: space present everywhere above, 
absent everywhere below...

> +void ide_set_irq(ide_hwif_t *hwif, int on)
> +{
> +	u8 ctl = ATA_DEVCTL_OBS;
> +
> +	if (on == 4) { /* hack for SRST */
> +		ctl |= 4;
> +		on &= ~4;
> +	}
> +
> +	ctl |= on ? 0 : 2;
> +
> +	if (hwif->host_flags & IDE_HFLAG_MMIO)
> +		writeb(ctl, (void __iomem *)hwif->io_ports.ctl_addr);
> +	else
> +		outb(ctl, hwif->io_ports.ctl_addr);
> +}
> +EXPORT_SYMBOL_GPL(ide_set_irq);

    Ugh, I really need to convert set_irq() to write_devctl(), it's a pity I 
hasn't done it still...

> +/*
> + * Some localbus EIDE interfaces require a special access sequence
> + * when using 32-bit I/O instructions to transfer data.  We call this
> + * the "vlb_sync" sequence, which consists of three successive reads
> + * of the sector count register location, with interrupts disabled
> + * to ensure that the reads all happen together.
> + */
> +static void ata_vlb_sync(unsigned long port)

    Not clear why this has ata_ prefix...

> +{
> +	(void)inb(port);
> +	(void)inb(port);
> +	(void)inb(port);
> +}
> +
> +/*
> + * This is used for most PIO data transfers *from* the IDE interface
> + *
> + * These routines will round up any request for an odd number of bytes,
> + * so if an odd len is specified, be sure that there's at least one
> + * extra byte allocated for the buffer.
> + */
> +void ide_input_data(ide_drive_t *drive, struct request *rq, void *buf,
> +		    unsigned int len)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	unsigned long data_addr = io_ports->data_addr;
> +	u8 io_32bit = drive->io_32bit;
> +	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
> +
> +	len++;
> +
> +	if (io_32bit) {
> +		unsigned long uninitialized_var(flags);
> +
> +		if ((io_32bit & 2) && !mmio) {
> +			local_irq_save(flags);
> +			ata_vlb_sync(io_ports->nsect_addr);
> +		}
> +
> +		if (mmio)
> +			__ide_mm_insl((void __iomem *)data_addr, buf, len / 4);

    It's not clear why we're not using readsl()...

> +		else
> +			insl(data_addr, buf, len / 4);
> +
> +		if ((io_32bit & 2) && !mmio)
> +			local_irq_restore(flags);
> +
> +		if ((len & 3) >= 2) {
> +			if (mmio)
> +				__ide_mm_insw((void __iomem *)data_addr,
> +						(u8 *)buf + (len & ~3), 1);

    ... ans readsw(). Ah, some archs do cache flushes around reads[wl]().
Besides, I doubt that the definitions in include/asm-generic/ide_iops.h are 
correct as they use read[wl]() in a loop which may not fly on BE...

MBR, Sergei
