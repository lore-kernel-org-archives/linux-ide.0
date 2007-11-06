From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 08/12] libata: implement ata_timing_cycle2mode() and use
 it in libata-acpi and pata_acpi
Date: Tue, 6 Nov 2007 10:59:12 +0000
Message-ID: <20071106105912.1526c770@the-village.bc.nu>
References: <1194327550227-git-send-email-htejun@gmail.com>
	<11943275513901-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54608 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752201AbXKFK6g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 05:58:36 -0500
In-Reply-To: <11943275513901-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Tue,  6 Nov 2007 14:39:06 +0900
Tejun Heo <htejun@gmail.com> wrote:

> libata-acpi is using separate timing tables for transfer modes
> although libata-core has the complete ata_timing table.  Implement
> ata_timing_cycle2mode() to look for matching mode given transfer type
> and cycle duration and use it in libata-acpi and pata_acpi to replace
> private timing tables.

Ok that makes sense having now seen the second chunk of patches. Just one
problem:


> +	/* PIO */
> +	mode = ata_timing_cycle2mode(ATA_SHIFT_PIO, gtm->drive[unit].pio);
> +	xfer_mask |= ata_xfer_mode2mask(mode);

No check v 0xFF

> + *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
> + *	@xfer_shift: ATA_SHIFT_* value for transfer type to examine.
> + *	@cycle: cycle duration in ns
> + *
> + *	Return matching xfer mode for @cycle.  The returned mode is of
> + *	the transfer type specified by @xfer_shift.  If @cycle is too
> + *	slow for @xfer_shift, 0xff is returned.  If @cycle is faster
> + *	than the fastest known mode, the fasted m

Can return 0xFF

