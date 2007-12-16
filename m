From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] Add GD-Rom support to the SEGA Dreamcast
Date: Sun, 16 Dec 2007 10:09:13 +0000
Message-ID: <20071216100913.GA1208@infradead.org>
References: <8b67d60712151621j2101c411p19d75125c6d1c2f9@mail.gmail.com> <20071216095019.GA12184@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071216095019.GA12184@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Adrian McMenamin <lkmladrian@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, axboe@kernel.dk
List-Id: linux-ide@vger.kernel.org

On Sun, Dec 16, 2007 at 06:50:19PM +0900, Paul Mundt wrote:
> > +static irqreturn_t gdrom_command_interrupt(int irq, void *dev_id)
> > +{
> > +	if (dev_id != &gd)
> > +		return IRQ_NONE;
> 
> You aren't setting this up as a shared IRQ, so this shouldn't be
> necessary.

It's not nessecary for shared irqs either.  The irq code will never
pass you a different cookied back than the one you passed in.
Everything else would be a nighmare and these cargo cult workarounds
wouldn't help either.

