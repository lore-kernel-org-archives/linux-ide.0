From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: [PATCH v4 1/2] ata: pata_at91.c bugfix for initial_timing
 initialisation
Date: Mon, 28 Mar 2011 20:31:51 +0400
Message-ID: <1301329911.2668.3.camel@homepc>
References: <1301316975-27761-1-git-send-email-plyatov@gmail.com>
	 <4D90B3ED.8080608@ru.mvista.com>
Reply-To: plyatov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D90B3ED.8080608@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello Sergei!

> Hello.
> 
> Igor Plyatov wrote:
> 
> > The "struct ata_timing" must contain 10 members, but ".dmack_hold" member was
> > forgotten for "initial_timing" initialisation. This patch fixes such a problem.
> 
> > Signed-off-by: Igor Plyatov <plyatov@gmail.com>
> > ---
> >  drivers/ata/pata_at91.c |   14 ++++++++++++--
> >  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> > diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> > index 0da0dcc..0267d54 100644
> > --- a/drivers/ata/pata_at91.c
> > +++ b/drivers/ata/pata_at91.c
> > @@ -49,8 +49,18 @@ struct at91_ide_info {
> >  	void __iomem *alt_addr;
> >  };
> >  
> > -static const struct ata_timing initial_timing =
> > -	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
> > +static const struct ata_timing initial_timing = {
> > +	.mode		= XFER_PIO_0,
> > +	.setup		= 70,
> > +	.act8b		= 290,
> > +	.rec8b		= 240,
> > +	.cyc8b		= 600,
> > +	.active		= 165,
> > +	.recover	= 150,
> > +	.dmack_hold	= 0,
> > +	.cycle		= 600,
> > +	.udma		= 0
> > +};
> 
>    There's no need to explicitly initialize to 0.
> 
> MBR, Sergei

It's much better to explicitly initialise, then use old wrong code,
where .dmack_hold member was equal to 600.

Best regards!
--
Igor Plyatov
