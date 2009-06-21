From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 17:43:09 +0200
Message-ID: <200906211743.09840.bzolnier@gmail.com>
References: <200906202352.33894.elendil@planet.nl> <20090620.171945.140676687.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20090620.171945.140676687.davem@davemloft.net>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: elendil@planet.nl, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sunday 21 June 2009 02:19:45 David Miller wrote:

> Actually... the patch doesn't revert cleanly.  Let me setup a
> patch to test by hand.  It just removes the IDE_HFLAG_SERIALIZE
> flag from the chipset array entry.

We still need to fix the root cause of "screaming IRQ" but in the meantime
could you resend with your S-o-B (now that Frans has tested it)?

> diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
> index 80b777e..f98ba24 100644
> --- a/drivers/ide/cmd64x.c
> +++ b/drivers/ide/cmd64x.c
> @@ -425,8 +425,7 @@ static const struct ide_port_info cmd64x_chipsets[] __devinitdata = {
>  		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
>  		.port_ops	= &cmd64x_port_ops,
>  		.dma_ops	= &cmd648_dma_ops,
> -		.host_flags	= IDE_HFLAG_SERIALIZE |
> -				  IDE_HFLAG_ABUSE_PREFETCH,
> +		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
>  		.pio_mask	= ATA_PIO5,
>  		.mwdma_mask	= ATA_MWDMA2,
>  		.udma_mask	= ATA_UDMA2,
