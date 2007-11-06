From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/12] libata: separate out ata_acpi_gtm_xfermask() from
 pacpi_discover_modes()
Date: Tue, 6 Nov 2007 10:54:01 +0000
Message-ID: <20071106105401.581eb83a@the-village.bc.nu>
References: <1194327550227-git-send-email-htejun@gmail.com>
	<11943275511318-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50966 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755749AbXKFKx0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 05:53:26 -0500
In-Reply-To: <11943275511318-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

> +/* Welcome to ACPI, bring a bucket */
> +const unsigned int ata_acpi_pio_cycle[7] = {
> +	600, 383, 240, 180, 120, 100, 80
> +};
> +EXPORT_SYMBOL_GPL(ata_acpi_pio_cycle);
> +
> +const unsigned int ata_acpi_mwdma_cycle[5] = {
> +	480, 150, 120, 100, 80
> +};
> +EXPORT_SYMBOL_GPL(ata_acpi_mwdma_cycle);
> +
> +const unsigned int ata_acpi_udma_cycle[7] = {
> +	120, 80, 60, 45, 30, 20, 15
> +};
> +EXPORT_SYMBOL_GPL(ata_acpi_udma_cycle);

Do we really need to keep exporting all these things. So far this patch
set has exported a set of very specific ACPI arrays and a load of
internal functions. That to me says the splitting up is wrong.

One option would be to make those tables private and simply make the
pata_acpi driver use the ata_timing functions

Alan
