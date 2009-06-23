From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [git patches] libata updates
Date: Tue, 23 Jun 2009 21:37:43 +0400
Message-ID: <20090623213743.2f1dfe5d@realm>
References: <20090623060600.GA9603@havoc.gtf.org>
	<20090622233157.fe0e0e2c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:54271 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbZFWRpI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 13:45:08 -0400
Received: by fg-out-1718.google.com with SMTP id e12so170160fga.17
        for <linux-ide@vger.kernel.org>; Tue, 23 Jun 2009 10:45:09 -0700 (PDT)
In-Reply-To: <20090622233157.fe0e0e2c.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, 22 Jun 2009 23:31:57 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 23 Jun 2009 02:06:00 -0400 Jeff Garzik <jeff@garzik.org>
> wrote:
> 
> > 
> > ...
> >
> > --- /dev/null
> > +++ b/drivers/ata/pata_at91.c
> > @@ -0,0 +1,361 @@
> > +/*
> > + * PATA driver for AT91SAM9260 Static Memory Controller
> > + * with CompactFlash interface in True IDE mode
> > + *
> > + * Copyright (C) 2009 Matyukevich Sergey
> > + *
> > + * Based on:
> > + *      * generic platform driver by Paul Mundt:
> > drivers/ata/pata_platform.c
> > + *      * pata_at32 driver by Kristoffer Nyborg Gregertsen
> > + *      * at91_ide driver by Stanislaw Gruszka
> > + *
> > + * This program is free software; you can redistribute it and/or
> > modify it
> > + * under the terms of the GNU General Public License version 2
> > + * as published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/blkdev.h>
> > +#include <scsi/scsi_host.h>
> > +#include <linux/ata.h>
> > +#include <linux/clk.h>
> > +#include <linux/libata.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/ata_platform.h>
> > +
> > +#include <mach/at91sam9260_matrix.h>
> > +#include <mach/at91sam9_smc.h>
> > +#include <mach/at91sam9260.h>
> > +#include <mach/board.h>
> > +#include <mach/gpio.h>
> > +
> > +
> > +#define DRV_NAME "pata_at91"
> > +#define DRV_VERSION "0.1"
> > +
> > +#define CF_IDE_OFFSET	    0x00c00000
> > +#define CF_ALT_IDE_OFFSET   0x00e00000
> > +#define CF_IDE_RES_SIZE     0x08
> > +
> > +struct at91_ide_info {
> > +	unsigned long mode;
> > +	unsigned int cs;
> > +
> > +	void __iomem *ide_addr;
> > +	void __iomem *alt_addr;
> > +};
> > +
> > +const struct ata_timing initial_timing =
> > +	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
> 
> static.
> 
> > +static unsigned int calc_mck_cycles(unsigned int ns, unsigned int
> > mck_hz) +{
> > +	unsigned long mul;
> > +
> > +    /*
> > +     * cycles = x [nsec] * f [Hz] / 10^9 [ns in sec] =
> > +     *     x * (f / 1_000_000_000) =
> > +     *     x * ((f * 65536) / 1_000_000_000) / 65536 =
> > +     *     x * (((f / 10_000) * 65536) / 100_000) / 65536 =
> > +     */
> > +
> > +    mul = (mck_hz / 10000) << 16;
> > +    mul /= 100000;
> > +
> > +    return (ns * mul + 65536) >> 16;    /* rounding */
> > +}
> 
> yum, fixed-point float.
> 
> This combination of uints and ulongs is just asking for 32bit-vs-64bit
> overflow bugs.
> 
> > +static void set_smc_mode(struct at91_ide_info *info)
> > +{
> > +    at91_sys_write(AT91_SMC_MODE(info->cs), info->mode);
> > +    return;
> > +}
> > +
> > +static void set_smc_timing(struct device *dev,
> > +		struct at91_ide_info *info, const struct
> > ata_timing *ata) +{
> > +	int read_cycle, write_cycle, active, recover;
> > +	int nrd_setup, nrd_pulse, nrd_recover;
> > +	int nwe_setup, nwe_pulse;
> > +
> > +	int ncs_write_setup, ncs_write_pulse;
> > +	int ncs_read_setup, ncs_read_pulse;
> > +
> > +	unsigned int mck_hz;
> > +	struct clk *mck;
> > +
> > +	read_cycle  = ata->cyc8b;
> > +	nrd_setup   = ata->setup;
> > +	nrd_pulse   = ata->act8b;
> > +	nrd_recover = ata->rec8b;
> > +
> > +	mck = clk_get(NULL, "mck");
> > +	BUG_ON(IS_ERR(mck));
> 
> That seems harsh.
> 
> > +	mck_hz = clk_get_rate(mck);
> > +
> > +	read_cycle  = calc_mck_cycles(read_cycle, mck_hz);
> > +	nrd_setup   = calc_mck_cycles(nrd_setup, mck_hz);
> > +	nrd_pulse   = calc_mck_cycles(nrd_pulse, mck_hz);
> > +	nrd_recover = calc_mck_cycles(nrd_recover, mck_hz);
> > +
> > +	clk_put(mck);
> > +
> > +	active  = nrd_setup + nrd_pulse;
> > +	recover = read_cycle - active;
> > +
> > +	/* Need at least two cycles recovery */
> > +	if (recover < 2)
> > +		read_cycle = active + 2;
> > +
> > +	/* (CS0, CS1, DIR, OE) <= (CFCE1, CFCE2, CFRNW, NCSX)
> > timings */
> > +	ncs_read_setup = 1;
> > +	ncs_read_pulse = read_cycle - 2;
> > +
> > +	/* Write timings same as read timings */
> > +	write_cycle = read_cycle;
> > +	nwe_setup = nrd_setup;
> > +	nwe_pulse = nrd_pulse;
> > +	ncs_write_setup = ncs_read_setup;
> > +	ncs_write_pulse = ncs_read_pulse;
> > +
> > +	dev_dbg(dev, "ATA timings: nrd_setup = %d nrd_pulse = %d
> > nrd_cycle = %d\n",
> > +			nrd_setup, nrd_pulse, read_cycle);
> > +	dev_dbg(dev, "ATA timings: nwe_setup = %d nwe_pulse = %d
> > nwe_cycle = %d\n",
> > +			nwe_setup, nwe_pulse, write_cycle);
> > +	dev_dbg(dev, "ATA timings: ncs_read_setup = %d
> > ncs_read_pulse = %d\n",
> > +			ncs_read_setup, ncs_read_pulse);
> > +	dev_dbg(dev, "ATA timings: ncs_write_setup = %d
> > ncs_write_pulse = %d\n",
> > +			ncs_write_setup, ncs_write_pulse);
> > +
> > +	at91_sys_write(AT91_SMC_SETUP(info->cs),
> > +			AT91_SMC_NWESETUP_(nwe_setup) |
> > +			AT91_SMC_NRDSETUP_(nrd_setup) |
> > +			AT91_SMC_NCS_WRSETUP_(ncs_write_setup) |
> > +			AT91_SMC_NCS_RDSETUP_(ncs_read_setup));
> > +
> > +	at91_sys_write(AT91_SMC_PULSE(info->cs),
> > +			AT91_SMC_NWEPULSE_(nwe_pulse) |
> > +			AT91_SMC_NRDPULSE_(nrd_pulse) |
> > +			AT91_SMC_NCS_WRPULSE_(ncs_write_pulse) |
> > +			AT91_SMC_NCS_RDPULSE_(ncs_read_pulse));
> > +
> > +	at91_sys_write(AT91_SMC_CYCLE(info->cs),
> > +			AT91_SMC_NWECYCLE_(write_cycle) |
> > +			AT91_SMC_NRDCYCLE_(read_cycle));
> > +
> > +	return;
> > +}
> > +


Hi,
Could you tell me where to send update for pata_at91 driver modified
according to Andrew's remarks ? To Jeff ? 

Thanks,
Sergey




