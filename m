From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support
Date: Mon, 20 Oct 2008 23:14:50 +0900 (JST)
Message-ID: <20081020.231450.51866269.anemo@mba.ocn.ne.jp>
References: <20081017.231036.26097587.anemo@mba.ocn.ne.jp>
	<48FB7D9E.4030803@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <48FB7D9E.4030803@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org
List-Id: linux-ide@vger.kernel.org

On Sun, 19 Oct 2008 22:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	struct tx4938ide_platform_info pdata = {
> > +		.ioport_shift = shift,
> > +		.gbus_clock = tune ? txx9_gbus_clock : 0,
> 
>     Any reason not to supply the GBUS clock?

The EBUS channel might be used for both ATA and ISA or other local bus
devices.  In that case, the board setup code should initialize best
timings for all devices and the IDE driver should not overrite it.

>     I'm afraid you can't just early return from the set_pio_mode() method...

Do you mean I should use IDE_HFLAG_NO_SET_MODE instead of just
returning from set_pio_mode?

> > +	for (i = 0; i < 8; i++) {
> > +		/* check EBCCRn.ISA, EBCCRn.BSZ, EBCCRn.ME */
> > +		if ((__raw_readq(&tx4938_ebuscptr->cr[i]) & 0x00f00008)
> > +		    == 0x00e00008)
> > +			break;
> > +	}
> > +	if (i == 8)
> > +		return;
> > +	pdata.ebus_ch = i;
> 
>     Why not grab the base address from this register as well and put it into 
> the resource?

Well, ... no reason :-)  I will do that way.  Thank you.
---
Atsushi Nemoto
