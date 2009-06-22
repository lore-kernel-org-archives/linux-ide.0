From: Frans Pop <elendil@planet.nl>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Mon, 22 Jun 2009 06:28:36 +0200
Message-ID: <200906220628.37237.elendil@planet.nl>
References: <200906202352.33894.elendil@planet.nl> <200906211446.38598.elendil@planet.nl> <20090621.185621.31766784.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20090621.185621.31766784.davem@davemloft.net>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

On Monday 22 June 2009, David Miller wrote:
> Can you apply this debugging patch and print out the output?

I get completely flooded...
I get the debug output 2 times (ide0 and ide1 maybe?): the first time it 
stops after a few 100 lines and driver init continues a bit, but the 
second time it just goes on and on and eventually I decided to reset the 
box.

> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index 1059f80..8992fda 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -797,6 +797,25 @@ irqreturn_t ide_intr (int irq, void *dev_id)
>  	int plug_device = 0;
>  	struct request *uninitialized_var(rq_in_flight);
>
> +#if 1
> +	{
> +		static int times = 0;
> +
> +		if (++times <= 32)

Should this be >=32 maybe?

If you really do want the to skip the first 32 and capture the rest, I can 
still get it, but I'd have to split the printk as it's too wide for my 
serial console so part gets truncated.

> +			goto no_log;
> +
> +		printk(KERN_INFO "IDE-DEBUG: host->host_flags[0x%lx] "
> +		       "hwif(%p) host->cur_port(%p) "
> +		       "hwif->port_ops(%pS) hwif->handler(%pS) "
> +		       "hwif->polling(%d)\n",
> +		       host->host_flags, hwif, host->cur_port,
> +		       hwif->port_ops, hwif->handler, (int) hwif->polling);
> +
> +	no_log:
> +		;
> +	}
> +#endif
> +
>  	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
>  		if (hwif != host->cur_port)
>  			goto out_early;

This is what I could get from the *second* series:
IDE-DEBUG: host->host_flags[0x10] hwif(fffff8003e326800) 
host->cur_port((null)) 
hwif->port_ops(cmd648_port_ops+0x0/0xfffffffffffffe54 [cmd64x]) 
hwif->hand

Rest is truncated. This first part seemed constant.
