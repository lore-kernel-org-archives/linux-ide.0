From: David Miller <davem@davemloft.net>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 22:45:10 -0700 (PDT)
Message-ID: <20090621.224510.96380426.davem@davemloft.net>
References: <200906211446.38598.elendil@planet.nl>
	<20090621.185621.31766784.davem@davemloft.net>
	<200906220628.37237.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906220628.37237.elendil@planet.nl>
Sender: sparclinux-owner@vger.kernel.org
To: elendil@planet.nl
Cc: sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Mon, 22 Jun 2009 06:28:36 +0200

> On Monday 22 June 2009, David Miller wrote:
>> +#if 1
>> +	{
>> +		static int times = 0;
>> +
>> +		if (++times <= 32)
> 
> Should this be >=32 maybe?

Yes, it should be >= 32 :-)

> If you really do want the to skip the first 32 and capture the rest, I can 
> still get it, but I'd have to split the printk as it's too wide for my 
> serial console so part gets truncated.

Sure.

> This is what I could get from the *second* series:
> IDE-DEBUG: host->host_flags[0x10] hwif(fffff8003e326800) 
> host->cur_port((null)) 
> hwif->port_ops(cmd648_port_ops+0x0/0xfffffffffffffe54 [cmd64x]) 
> hwif->hand
> 
> Rest is truncated. This first part seemed constant.

The basic gist of the problem seems to be that when the chip is
brought up, the initial request_irq() forces a lingering interrupt
status in the chip to have somewhere to go.

But the IDE layer refuses to do something to clear it because it's
not expecting any interrupts (this is the: cur_port != hwif).

Some things other than the commit in question have changed in the area
of interrupt and chip initialization and I'll try to go through
the commits to get some clues.

Thanks!

