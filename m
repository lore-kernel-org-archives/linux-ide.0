From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH 2/3] Add GD-Rom support to the SEGA Dreamcast
Date: Sun, 16 Dec 2007 17:32:51 +0000
Message-ID: <1197826371.6254.14.camel@localhost.localdomain>
References: <8b67d60712151621j2101c411p19d75125c6d1c2f9@mail.gmail.com>
	 <20071216095019.GA12184@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20071216095019.GA12184@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Adrian McMenamin <lkmladrian@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, axboe@kernel.dk
List-Id: linux-ide@vger.kernel.org


On Sun, 2007-12-16 at 18:50 +0900, Paul Mundt wrote:
> Ok, I don't know anything about the CD-ROM layer, so I've just commented
> on the general and SH-specific stuff. Hopefully someone with a clue
> in this area (ie, not me) can offer input on the rest of the bits.
> 

> > +static char gdrom_execute_diagnostic(void)
> > +{
> > +	int count;
> > +	/* Restart the GDROM */
> > +	ctrl_outl(0x1fffff, GDROM_RESET_REG);
> > +	for (count = 0xa0000000; count < 0xa0200000; count += 4)
> > +		ctrl_inl(count);
> 
> Er? This ranged dummy reading of the P2 space needs some explanation. The
> GD-ROM isn't even mapped in to this space, so this seems like a hack to
> either work around a timing issue or a write ordering problem.
> 

I'll confess to not knowing what it's up to here either, other than it
looks like a mechanism to cause a G1 bus reset. This is a progressive
read of the Boot ROM area and that is all under G1 control (as is the GD
Rom obviously)

Replacing it with a simple delay of any length or, say, a read of one
word and then a delay, doesn't work.




