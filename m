From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: share PIO limits among devices sharing a
 channel
Date: Thu, 25 Jan 2007 12:30:30 +0000
Message-ID: <20070125123030.3093fb32@localhost.localdomain>
References: <20070125112947.GC8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34677 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933163AbXAYMTJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 07:19:09 -0500
In-Reply-To: <20070125112947.GC8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, 25 Jan 2007 20:29:47 +0900
Tejun Heo <htejun@gmail.com> wrote:

> PIO xfermask limits should be shared by all devices on the same
> channel to avoid violating device selection timing.  libata used to

NAK, this is totally wrong

> +	/* PIO xfermask limits are shared by all devices on the same
> +	 * channel to avoid violating device selection timing.
> +	 */
> +	for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +		struct ata_device *d = &ap->device[i];
> +		unsigned int pio_mask;
> +
> +		if (ata_dev_absent(d))
> +			continue;
> +
> +		ata_unpack_xfermask(ata_id_xfermask(d->id),
> +				    &pio_mask, NULL, NULL);
> +		pio_mask &= d->pio_mask;
> +		xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
> +	}

NAK

This "guarantee" was deliberately removed long ago and is completely
bogus.

The good ATA chipsets do not suffer from selection timing limits of this
form. The less smart ones do and the drivers correctly merge the timing
values, including a whole chunk of functionality in the ata_timing
interface to get it right when doing DMA modes.

Adding this patch is the regression. Even the ancient drivers/ide code
does this properly.

Alan
