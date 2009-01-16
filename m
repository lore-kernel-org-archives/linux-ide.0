From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Fri, 16 Jan 2009 18:43:19 +0100
Message-ID: <200901161843.19487.bzolnier@gmail.com>
References: <200901141345.42583.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:62605 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757594AbZAPRnj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 12:43:39 -0500
Received: by bwz14 with SMTP id 14so5393699bwz.13
        for <linux-ide@vger.kernel.org>; Fri, 16 Jan 2009 09:43:37 -0800 (PST)
In-Reply-To: <200901141345.42583.stf_xl@wp.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org


Czesc,

Just some minor nitpicks:

On Wednesday 14 January 2009, Stanislaw Gruszka wrote:

[...]

> +static const struct ide_tp_ops at91_ide_tp_ops = {
> +	.exec_command = ide_exec_command,
> +	.read_status = ide_read_status,
> +	.read_altstatus = ide_read_altstatus,
> +	.set_irq = ide_set_irq,
> +
> +	.tf_load = at91_ide_tf_load,
> +	.tf_read = at91_ide_tf_read,
> +
> +	.input_data = at91_ide_input_data,
> +	.output_data = at91_ide_output_data,
> +};

no strong feelings about CodingStyle but we usually do:

...
	.exec_command	= ide_exec_command,
	.read_status	= ide_read_status,
...

which helps code readability and consistency

> +static void at91_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
> +{
> +	u8 chipselect = drive->hwif->extra_base;
> +
> +	pdbg("pio %u\n", pio);
> +
> +	if (pio > 6) {
> +		perr("can't set PIO %d mode\n", pio);
> +		return;
> +	}

no need for this check (core code guarantees that it won't happen)

> +static const struct ide_port_info at91_ide_port_info __initdata = {
> +	.port_ops = &at91_ide_port_ops,
> +	.tp_ops = &at91_ide_tp_ops,
> +	.host_flags = IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SINGLE,
> +	.pio_mask = ATA_PIO6,
> +};

AFAICS IDE_HFLAG_NO_IO_32BIT should also be set here,
you may also want to set IDE_HFLAG_UNMASK_IRQS while at it

and CodingStyle fixup would be a nice bonus

> +#if 0
> +	/* In 12-0275-01 version of the PCB address
> +	 * lines CF_A0 and CF_A2 are swapped */
> +	hw.io_ports.data_addr =	tf_base + 0;
> +	hw.io_ports.error_addr = tf_base + 4;
> +	hw.io_ports.nsect_addr = tf_base + 2;
> +	hw.io_ports.lbal_addr = tf_base + 6;
> +	hw.io_ports.lbam_addr = tf_base + 1;
> +	hw.io_ports.lbah_addr = tf_base + 5;
> +	hw.io_ports.device_addr = tf_base + 3;
> +	hw.io_ports.command_addr = tf_base + 7;
> +#else
> +	/* Proper lines addresses */
> +	hw.io_ports.data_addr = tf_base + 0;
> +	hw.io_ports.error_addr = tf_base + 1;
> +	hw.io_ports.nsect_addr = tf_base + 2;
> +	hw.io_ports.lbal_addr = tf_base + 3;
> +	hw.io_ports.lbam_addr = tf_base + 4;
> +	hw.io_ports.lbah_addr =	tf_base + 5;
> +	hw.io_ports.device_addr = tf_base + 6;
> +	hw.io_ports.command_addr = tf_base + 7;
> +#endif

How's about using enums for offsets, i.e.

enum {
#if 0
...
	AT91_IDE_ERROR_ADDR_OFFSET = 4,
...
#else
...
	AT91_IDE_ERROR_ADDR_OFFSET = 1,
...
#endif
};

?

otherwise (except issues already discussed in the other mail) it looks fine
