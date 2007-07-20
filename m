From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA driver for Atmel AVR32
Date: Fri, 20 Jul 2007 12:14:43 +0100
Message-ID: <20070720121443.4c1d6fa5@the-village.bc.nu>
References: <200707201108.19174.kngregertsen@norway.atmel.com>
	<200707201112.12444.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52496 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758576AbXGTLIM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 07:08:12 -0400
In-Reply-To: <200707201112.12444.kngregertsen@norway.atmel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, kernel@avr32linux.org, gregerts@stud.ntnu.no, kngregertsen@norway.atmel.com

> /*
>  * SMC timings to match ATAPI-4 PIO timing specs (given in ns)
>  * See Figure 20 and Table 29 on pages 262-263 in T13/1153D revision 18
>  */
> static const int smc_tot_cycle[5] = {600, 390, 350, 190, 135}; /* >= t0 */
> static const int smc_nrd_setup[5] = {100,  60,  40,  40,  35}; /* >= t1 */
> static const int smc_nrd_pulse[5] = {400, 300, 290,  80,  70}; /* >= t2 */

(We have timing compute functions in libata for any final merge. You
might want to compare the computed results with you own functions and see
if they agree)

> /*
>  * Functions for libATA
>  */
> static void pata_at32_set_piomode(struct ata_port *ap, struct ata_device *adev)
> {
> 	struct at32_ide_info *info = ap->host->private_data;
> 	int pio_mode = adev->pio_mode - XFER_PIO_0;
> 	int ret;
> 
> 	/* Exit if the SMC is already configured for this PIO mode */
> 	if (pio_mode == info->smc_pio_mode)
> 		return;

Where do you first initialise smc_pio_mode so that you will always set
mode at least once ?

> 	/* Only use IORDY/NWAIT for PIO mode 3 and 4 */
> 	if (pio_mode < 3)
> 		info->smc.nwait_mode = 0;
> 	else
> 		info->smc.nwait_mode = 3;

That is wrong. Any mode for PIO2+ will use IORDY. Modes below may require
it sometimes (and its a good signal check). See ata_pio_need_iordy(atadev)

