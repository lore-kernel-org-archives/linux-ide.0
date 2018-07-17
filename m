From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/2] ata: libahci: Correct setting of DEVSLP register
Date: Mon, 16 Jul 2018 20:43:27 -0700
Message-ID: <701525498127eae51cd95f89fa88b53d411a9b71.camel@linux.intel.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
         <20180702190154.6864-2-srinivas.pandruvada@linux.intel.com>
         <CAAtuYK9zXJHhJ8_aRqfqOPJJ9L29patDA9RuUs9r+GJVZMCy=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAtuYK9zXJHhJ8_aRqfqOPJJ9L29patDA9RuUs9r+GJVZMCy=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: AceLan Kao <acelan@gmail.com>
Cc: tj@kernel.org, hdegoede@redhat.com, rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2018-07-17 at 11:26 +0800, AceLan Kao wrote:
> Tested-by: AceLan Kao <acelan.kao@canonical.com>

Thanks Kao for the test.

-Srinivas

> 
> The patches help the power consumption a little bit on my test
> system,
> and no obvious issue I can observe. 
> 
> 2018-07-03 3:01 GMT+08:00 Srinivas Pandruvada <srinivas.pandruvada@li
> nux.intel.com>:
> > We have seen that on some platforms, SATA device never show any
> > DEVSLP
> > residency. This prevent power gating of SATA IP, which prevent
> > system
> > to transition to low power mode in systems with SLP_S0 aka modern
> > standby systems. The PHY logic is off only in DEVSLP not in
> > slumber.
> > Reference:
> > https://www.intel.com/content/dam/www/public/us/en/documents/datash
> > eets
> > /332995-skylake-i-o-platform-datasheet-volume-1.pdf
> > Section 28.7.6.1
> > 
> > Here driver is trying to do read-modify-write the devslp register.
> > But
> > not resetting the bits for which this driver will modify values
> > (DITO,
> > MDAT and DETO). So simply reset those bits before updating to new
> > values.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/ata/libahci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 965842a08743..f6795d261869 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -2159,6 +2159,8 @@ static void ahci_set_aggressive_devslp(struct
> > ata_port *ap, bool sleep)
> >                 deto = 20;
> >         }
> > 
> > +       /* Make dito, mdat, deto bits to 0s */
> > +       devslp &= ~GENMASK_ULL(24, 2);
> >         devslp |= ((dito << PORT_DEVSLP_DITO_OFFSET) |
> >                    (mdat << PORT_DEVSLP_MDAT_OFFSET) |
> >                    (deto << PORT_DEVSLP_DETO_OFFSET) |
> > -- 
> > 2.17.1
> > 
> 
> 
