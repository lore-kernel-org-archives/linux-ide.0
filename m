From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] AVR32 PATA driver
Date: Tue, 7 Aug 2007 16:54:09 +0100
Message-ID: <20070807165409.4c2a4451@the-village.bc.nu>
References: <200708071126.08735.kngregertsen@norway.atmel.com>
	<200708071127.09751.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41111 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758019AbXHGPtf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 11:49:35 -0400
In-Reply-To: <200708071127.09751.kngregertsen@norway.atmel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Cc: linux-ide@vger.kernel.org, gregerts@stud.ntnu.no

 +static int pata_at32_get_pio_mask(void)
> +{
> +	switch (max_pio) {
> +	case 0:
> +		return 0x01;
> +	case 1:
> +		return 0x03;
> +	case 2:
> +		return 0x07;
> +	case 3:
> +		return 0x0f;
> +	case 4:
> +		return 0x1f;
> +	default:
> +		return 0x01;


What is wrong with just using  (1 << max_pio) - 1 as the range is only
0-4 anyway.

> +static void pata_at32_data_xfer(struct ata_device *adev, unsigned char *buf,
> +				unsigned int buflen, int write_data)
> +{
> +	struct at32_ide_info *info = adev->ap->host->private_data;
> +
> +	/* Set SMC to data transfer speed */
> +	if (info->smc_pio_mode < 3)
> +		smc_restore_registers(info->cs, &info->smc_16.reg);
> +
> +	/* Transfer data */
> +	ata_data_xfer(adev, buf, buflen, write_data);
> +
> +	/* Set SMC back to register transfer speed */
> +	if (info->smc_pio_mode < 3)
> +		smc_restore_registers(info->cs, &info->smc_8.reg);

Should be safe currently for IRQ driven behaviour, might be for polled but
remember that without locking you could end up reading the status before
you switch the clock back  so I'm not 100% sure.


