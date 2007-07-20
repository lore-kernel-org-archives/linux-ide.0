From: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Subject: Re: PATA driver for Atmel AVR32
Date: Fri, 20 Jul 2007 14:14:55 +0200
Message-ID: <200707201414.55336.kngregertsen@norway.atmel.com>
References: <200707201108.19174.kngregertsen@norway.atmel.com> <200707201112.12444.kngregertsen@norway.atmel.com> <20070720121443.4c1d6fa5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:60237 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759461AbXGTMQE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:16:04 -0400
In-Reply-To: <20070720121443.4c1d6fa5@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, kernel@avr32linux.org, gregerts@stud.ntnu.no

On Friday 20 July 2007 13:14:43 Alan Cox wrote:
> > /*
> >  * SMC timings to match ATAPI-4 PIO timing specs (given in ns)
> >  * See Figure 20 and Table 29 on pages 262-263 in T13/1153D revision 18
> >  */
> > static const int smc_tot_cycle[5] = {600, 390, 350, 190, 135}; /* >= t0
> > */ static const int smc_nrd_setup[5] = {100,  60,  40,  40,  35}; /* >=
> > t1 */ static const int smc_nrd_pulse[5] = {400, 300, 290,  80,  70}; /*
> > >= t2 */
>
> (We have timing compute functions in libata for any final merge. You
> might want to compare the computed results with you own functions and see
> if they agree)

Thank you for reviewing my code :)

I will look into the timing functions of libATA and make use of them to verify 
or to replace my own.

> > /*
> >  * Functions for libATA
> >  */
> > static void pata_at32_set_piomode(struct ata_port *ap, struct ata_device
> > *adev) {
> > 	struct at32_ide_info *info = ap->host->private_data;
> > 	int pio_mode = adev->pio_mode - XFER_PIO_0;
> > 	int ret;
> >
> > 	/* Exit if the SMC is already configured for this PIO mode */
> > 	if (pio_mode == info->smc_pio_mode)
> > 		return;
>
> Where do you first initialise smc_pio_mode so that you will always set
> mode at least once ?

Currently info->smc_pio_mode is set to DEFAULT_PIO_MODE in function 
pata_at32_probe, just after the SMC is for initialized for DEFAULT_PIO_MODE 
the first time.

DEFAULT_PIO_MODE is currently defined as PIO0, but this migth not be needed? 
Does libATA always expect the hardware to be set for PIO0 at startup or could 
it be any mode? If it can only be PIO0 than I'll remove the DEFAULT_PIO_MODE 
define as it would be redundant.

> > 	/* Only use IORDY/NWAIT for PIO mode 3 and 4 */
> > 	if (pio_mode < 3)
> > 		info->smc.nwait_mode = 0;
> > 	else
> > 		info->smc.nwait_mode = 3;
>
> That is wrong. Any mode for PIO2+ will use IORDY. Modes below may require
> it sometimes (and its a good signal check). See ata_pio_need_iordy(atadev)

Woops, my bad. I'll fix it so that NWAIT is used at all times :)
-- 
Kristoffer Nyborg Gregertsen
MSc. student / Summer intern
Atmel Norway
