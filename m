From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 2/3] pata/at91: use new introduce smc accessor
Date: Fri, 9 Dec 2011 07:24:00 +0100
Message-ID: <20111209062400.GK23884@game.jcrosoft.org>
References: <20111208150348.GD23884@game.jcrosoft.org>
 <1323357784-17555-2-git-send-email-plagnioj@jcrosoft.com>
 <4EE13B5D.9090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4EE13B5D.9090908@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: linux-ide@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 09:34 Fri 09 Dec     , Ryan Mallon wrote:
> On 09/12/11 02:23, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > this will allow to use the pata_at91 on a single zImage
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: linux-ide@vger.kernel.org
> 
> 
> Some comments below,
> 
> ~Ryan
> 
> > ---
> > Hi,
> > 
> > 	it's depends on other patch for AT91 can we apply via at91
> > 
> > Best Regards,
> > J.
> >  drivers/ata/pata_at91.c |   43 +++++++++++++++++++++----------------------
> >  1 files changed, 21 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> > index 5249e6d..c8d1154 100644
> > --- a/drivers/ata/pata_at91.c
> > +++ b/drivers/ata/pata_at91.c
> > @@ -207,11 +207,11 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
> >  {
> >  	int ret = 0;
> >  	int use_iordy;
> > +	struct sam9_smc_config smc;
> >  	unsigned int t6z;         /* data tristate time in ns */
> >  	unsigned int cycle;       /* SMC Cycle width in MCK ticks */
> >  	unsigned int setup;       /* SMC Setup width in MCK ticks */
> >  	unsigned int pulse;       /* CFIOR and CFIOW pulse width in MCK ticks */
> > -	unsigned int cs_setup = 0;/* CS4 or CS5 setup width in MCK ticks */
> >  	unsigned int cs_pulse;    /* CS4 or CS5 pulse width in MCK ticks*/
> >  	unsigned int tdf_cycles;  /* SMC TDF MCK ticks */
> >  	unsigned long mck_hz;     /* MCK frequency in Hz */
> > @@ -244,26 +244,25 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
> >  	}
> >  
> >  	dev_dbg(dev, "Use IORDY=%u, TDF Cycles=%u\n", use_iordy, tdf_cycles);
> > -	info->mode |= AT91_SMC_TDF_(tdf_cycles);
> >  
> >  	/* write SMC Setup Register */
> > -	at91_sys_write(AT91_SMC_SETUP(info->cs),
> > -			AT91_SMC_NWESETUP_(setup) |
> > -			AT91_SMC_NRDSETUP_(setup) |
> > -			AT91_SMC_NCS_WRSETUP_(cs_setup) |
> > -			AT91_SMC_NCS_RDSETUP_(cs_setup));
> > +	smc.nrd_setup = setup;
> > +	smc.nwe_setup = smc.nrd_setup;
> > +	smc.ncs_read_setup = 0;
> > +	smc.ncs_write_setup = smc.ncs_read_setup;
> >  	/* write SMC Pulse Register */
> > -	at91_sys_write(AT91_SMC_PULSE(info->cs),
> > -			AT91_SMC_NWEPULSE_(pulse) |
> > -			AT91_SMC_NRDPULSE_(pulse) |
> > -			AT91_SMC_NCS_WRPULSE_(cs_pulse) |
> > -			AT91_SMC_NCS_RDPULSE_(cs_pulse));
> > +	smc.nrd_pulse = pulse;
> > +	smc.nwe_pulse = smc.nrd_pulse;
> > +	smc.ncs_read_pulse =cs_pulse;
> 
> 
> Nitpick: Whitespace around the = operator.
> 
> > +	smc.ncs_write_pulse = smc.ncs_read_pulse;
> >  	/* write SMC Cycle Register */
> > -	at91_sys_write(AT91_SMC_CYCLE(info->cs),
> > -			AT91_SMC_NWECYCLE_(cycle) |
> > -			AT91_SMC_NRDCYCLE_(cycle));
> > +	smc.read_cycle = cycle;
> > +	smc.write_cycle = smc.read_cycle;
> >  	/* write SMC Mode Register*/
> > -	at91_sys_write(AT91_SMC_MODE(info->cs), info->mode);
> > +	smc.tdf_cycles = tdf_cycles;
> 
> 
> The "write SMC Mode Register" comment should be removed.
> 
> > +	smc.mode = info->mode;
> > +
> > +	sam9_smc_configure(0, info->cs, &smc);
> 
> 
> This new function returns an int, should we be checking the return value
> here?
> 
> >  }
> >  
> >  static void pata_at91_set_piomode(struct ata_port *ap, struct ata_device *adev)
> > @@ -288,20 +287,20 @@ static unsigned int pata_at91_data_xfer_noirq(struct ata_device *dev,
> >  	struct at91_ide_info *info = dev->link->ap->host->private_data;
> >  	unsigned int consumed;
> >  	unsigned long flags;
> > -	unsigned int mode;
> > +	struct sam9_smc_config smc;
> >  
> >  	local_irq_save(flags);
> > -	mode = at91_sys_read(AT91_SMC_MODE(info->cs));
> > +	sam9_smc_read_mode(0, info->cs, &smc);
> >  
> >  	/* set 16bit mode before writing data */
> > -	at91_sys_write(AT91_SMC_MODE(info->cs),
> > -			(mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_16);
> > +	smc.mode = (smc.mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_16;
> > +	sam9_smc_write_mode(0, info->cs, &smc);
> 
> 
> Do sam9_smc_read/write_mode really need to pass the whole smc structure?
> The only fields used are mode and tdf_cycles. It might be clearer to
> pass those directly.
> 
> Also the original code here doesn't write tdf_cycles as part of the
> mode. Perhaps it would be better to have sam9_smc_write_mode to be:
> 
>   int sam9_smc_write_mode(int id, int cs, unsigned mode);
no as you will force the write to read to content before updating it
which I do not want the the need to you update the mode
> 
> and in set_smc_timing above explicitly or in the tdf_cycles bits?
the mode and tdf_cycles are closely related so I choose to manipulate them
together

and  as it's supposed to be register independant you always pass the struct

and the implemetation manage the write

Best Regards,
J.
