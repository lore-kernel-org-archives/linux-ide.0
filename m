From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3 v3] ide: add at91_ide driver
Date: Sun, 01 Mar 2009 22:42:41 +0300
Message-ID: <49AAE531.7020304@ru.mvista.com>
References: <200902181106.54260.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53934 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754025AbZCATmu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Mar 2009 14:42:50 -0500
In-Reply-To: <200902181106.54260.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

> This is IDE host driver for AT91 (SAM9, CAP9, AT572D940HF) Static Memory
> Controller with Compact Flash True IDE Mode logic.
>
> Driver have to switch 8/16 bit bus width when accessing Task Tile or Data
> Register. Moreover some extra things need to be done when setting PIO mode.
> Only PIO mode is used, hardware have no DMA support. If interrupt line is
> connected through GPIO extra quirk is needed to cope with fake interrupts.
>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
> new file mode 100644
> index 0000000..1bb50f4
> --- /dev/null
> +++ b/drivers/ide/at91_ide.c
>   
[...]
> +static void set_smc_timings(const u8 chipselect, const u16 cycle,
> +			    const u16 setup, const u16 pulse,
> +			    const u16 data_float, int use_iordy)
>   

   This bunch of *const* specifiers is pretty pointless...

> +static void at91_ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	struct ide_taskfile *tf = &task->tf;
> +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
> +
> +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
> +		HIHI = 0xFF;
> +
> +	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
> +		u16 data = (tf->hob_data << 8) | tf->data;
>   

   It's not quite correct -- should be:

		u8 data[2] = { tf->data, tf->hob_data };


   Although, if this is a little endian only code, it should be 
equivivalent. I shouldn't probably have asked to change this part at 
all... :-/

> +static void at91_ide_tf_read(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	struct ide_taskfile *tf = &task->tf;
> +
> +	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
> +		u16 data;
>   

   It would have been easier to just declare it as:

		u8 data[2];


> +
> +		at91_ide_input_data(drive, NULL, &data, 2);
> +		tf->data = data & 0xff;
> +		tf->hob_data = (data >> 8) & 0xff;
>   

		tf->data = data[0];
		tf->hob_data = data[1];


MBR, Sergei


