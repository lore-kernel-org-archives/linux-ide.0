From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_pcmcia: Minor cleanups and support for dual channel
 cards
Date: Fri, 23 Nov 2007 19:47:34 -0500
Message-ID: <474774A6.5020906@garzik.org>
References: <20071119144307.7b67f09e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020905080601080707090803"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56706 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbXKXArj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:47:39 -0500
In-Reply-To: <20071119144307.7b67f09e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020905080601080707090803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_pcmcia.c linux-2.6.24-rc2-mm1/drivers/ata/pata_pcmcia.c
> --- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_pcmcia.c	2007-11-16 17:55:11.000000000 +0000
> +++ linux-2.6.24-rc2-mm1/drivers/ata/pata_pcmcia.c	2007-11-16 18:18:38.000000000 +0000
> @@ -42,7 +42,7 @@
>  
>  
>  #define DRV_NAME "pata_pcmcia"
> -#define DRV_VERSION "0.3.2"
> +#define DRV_VERSION "0.3.3"
>  
>  /*
>   *	Private data structure to glue stuff together
> @@ -198,7 +198,6 @@
>  /**
>   *	pcmcia_init_one		-	attach a PCMCIA interface
>   *	@pdev: pcmcia device
> - *	@ops: operations for this device
>   *
>   *	Register a PCMCIA IDE interface. Such interfaces are PIO 0 and
>   *	shared IRQ.
> @@ -217,9 +216,10 @@
>  		cistpl_cftable_entry_t dflt;
>  	} *stk = NULL;
>  	cistpl_cftable_entry_t *cfg;
> -	int pass, last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM;
> +	int pass, last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM, p;
>  	unsigned long io_base, ctl_base;
>  	void __iomem *io_addr, *ctl_addr;
> +	int n_ports = 1;
>  
>  	struct ata_port_operations *ops = &pcmcia_port_ops;
>  
> @@ -348,7 +348,7 @@
>  	/* FIXME: Could be more ports at base + 0x10 but we only deal with
>  	   one right now */
>  	if (pdev->io.NumPorts1 >= 0x20)
> -		printk(KERN_WARNING DRV_NAME ": second channel not yet supported.\n");
> +		n_ports = 2;
>  
>  	if (pdev->manf_id == 0x0097 && pdev->card_id == 0x1620)
>  		ops = &pcmcia_8bit_port_ops;
> @@ -357,20 +357,23 @@
>  	 *	sane.
>  	 */
>  	ret = -ENOMEM;
> -	host = ata_host_alloc(&pdev->dev, 1);
> +	host = ata_host_alloc(&pdev->dev, n_ports);
>  	if (!host)
>  		goto failed;
> -	ap = host->ports[0];
>  
> -	ap->ops = ops;
> -	ap->pio_mask = 1;		/* ISA so PIO 0 cycles */
> -	ap->flags |= ATA_FLAG_SLAVE_POSS;
> -	ap->ioaddr.cmd_addr = io_addr;
> -	ap->ioaddr.altstatus_addr = ctl_addr;
> -	ap->ioaddr.ctl_addr = ctl_addr;
> -	ata_std_ports(&ap->ioaddr);
> +	for (p = 0; p < n_ports; p++) {
> +		ap = host->ports[p];
>  
> -	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", io_base, ctl_base);
> +		ap->ops = ops;
> +		ap->pio_mask = 1;		/* ISA so PIO 0 cycles */
> +		ap->flags |= ATA_FLAG_SLAVE_POSS;
> +		ap->ioaddr.cmd_addr = io_addr + 0x10 * p;
> +		ap->ioaddr.altstatus_addr = ctl_addr + 0x10 * p;
> +		ap->ioaddr.ctl_addr = ctl_addr + 0x10 * p;
> +		ata_std_ports(&ap->ioaddr);

a bit of coordination confusion here...

This patch requires

	commit 33a2d9226557c298a5df13b95bd31b8b1d749918
	Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
	Date:   Mon Oct 15 20:44:11 2007 +0100

	    pata_pcmcia: Add support for dumb 8bit IDE emulations

found in #for-testing.  Should that patch be promoted to #upstream 
(queued for 2.6.25), and then this patch applied on top, also in #upstream?

If you're curious, here is the current content of #for-testing 
(attached).  You need to poke me to move stuff from #for-testing to 
#upstream, since I dropped it into #for-testing at your direction.

(for other readers, #for-testing is a branch always merged into #ALL and 
thus -mm)

	Jeff



--------------020905080601080707090803
Content-Type: text/plain;
 name="for-testing.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="for-testing.txt"

Alan Cox (4):
      libata: fix (hopefully) all the remaining problems with devices failing setup/identify
      pata_pcmcia: Add support for dumb 8bit IDE emulations
      libata-core: Don't have screaming fits over DF/ERR combinations
      libata/pata_it821x: Improve handling of poorly compatible emulations

 drivers/ata/libata-core.c |   61 ++++++++++++++++++++++++++++-----------
 drivers/ata/pata_it821x.c |   35 +++++++++++++++++++++-
 drivers/ata/pata_pcmcia.c |   71 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 147 insertions(+), 20 deletions(-)

--------------020905080601080707090803--
