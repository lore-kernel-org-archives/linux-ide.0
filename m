From: Christian Vogel <vogel@pi2.physik.uni-erlangen.de>
Subject: sata_promise support for pci id 0x3d18 {Re: Problem with Promise SATA-II 150 TX4 Controller (rev 2) [105a:3d18]}
Date: Mon, 3 Jan 2005 13:43:49 +0100
Message-ID: <20050103124349.GA13949@pi2.physik.uni-erlangen.de>
References: <m3zmzy492i.fsf@reason.gnu-hamburg> <m3pt0u45l9.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from skunk.physik.uni-erlangen.de ([131.188.163.240]:35970 "EHLO
	pi2.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261366AbVACMn6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jan 2005 07:43:58 -0500
Content-Disposition: inline
In-Reply-To: <m3pt0u45l9.fsf@reason.gnu-hamburg>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Georg C. F. Greve" <greve@gnu.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, rick@linuxmafia.com

Hi Georg, Jeff, Rick, linux-ide,

On Tue, Dec 28, 2004 at 07:53:38PM +0100, Georg C. F. Greve wrote:
> After some more investigation, I stumbled upon the thread that dealt
> with the Promise 579 in October 2004, which contained a similar
> situation and error message with the proposed fix at
> 
>  http://marc.theaimsgroup.com/?l=linux-ide&m=109814647928388&w=2
> 
> so I made the changes

I also made this changes right now and it seems to work quite fine,
we already copied several GB without any error, both the filesystem
(no kernel messages) and the data (compared md5sums) seem to be fine.

This is a Promise SATA-II 150 TX4 on a Intel motherboard with four
Maxtor 6B200M0 disks connected to it.

	Chris

> --- linux-2.6.10/drivers/scsi/sata_promise.c	2004-12-24 22:35:23.000000000 +0100
> +++ linux-2.6.10-lirc/drivers/scsi/sata_promise.c	2004-12-28 19:03:31.000000000 +0100
> @@ -160,10 +160,11 @@ static struct pci_device_id pdc_ata_pci_
>  	  board_20319 },
>  	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_20319 },
> +	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_20319 },
>  	{ }	/* terminate list */
>  };
>  
> -
>  static struct pci_driver pdc_ata_pci_driver = {
>  	.name			= DRV_NAME,
>  	.id_table		= pdc_ata_pci_tbl,
> @@ -408,6 +409,8 @@ static irqreturn_t pdc_interrupt (int ir
>  
>          spin_lock(&host_set->lock);
>  
> +        writel(mask, mmio_base + PDC_INT_SEQMASK);
> +
>          for (i = 0; i < host_set->n_ports; i++) {
>  		VPRINTK("port %u\n", i);
>  		ap = host_set->ports[i];


-- 
Everything is gone;
Your life's work has been destroyed.
Squeeze trigger (yes/no)?
-- David Carlson
