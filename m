From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] libata updates for 2.6.34
Date: Fri, 5 Mar 2010 19:58:24 +0100
Message-ID: <201003051958.24987.bzolnier@gmail.com>
References: <20100301202330.GA14977@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:10486 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab0CETAR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Mar 2010 14:00:17 -0500
In-Reply-To: <20100301202330.GA14977@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>

On Monday 01 March 2010 09:23:30 pm Jeff Garzik wrote:

>       libata: Pass host flags into the pci helper

It introduces a subtle bug:

struct ata_host {
...
	unsigned long		flags;

> @@ -1642,8 +1643,8 @@ extern int ata_pci_sff_activate_host(struct ata_host *host,
>  				     irq_handler_t irq_handler,
>  				     struct scsi_host_template *sht);
>  extern int ata_pci_sff_init_one(struct pci_dev *pdev,
> -				const struct ata_port_info * const * ppi,
> -				struct scsi_host_template *sht, void *host_priv);
> +		const struct ata_port_info * const * ppi,
> +		struct scsi_host_template *sht, void *host_priv, int hflags);

'int' type is not equal 'unsigned long' one on 64-bit architectures.

Besides doing it this way is clearly suboptimal as the same effect
could have been achieved by doing:

extern int __ata_pci_sff_init_one(struct pci_dev *pdev,
				const struct ata_port_info * const *ppi,
				struct scsi_host_template *sht, void *host_priv,
				int hflag);
static inline int ata_pci_sff_init_one(struct pci_dev *pdev,
				const struct ata_port_info * const *ppi,
				struct scsi_host_template *sht, void *host_priv)
{
	return __ata_pci_sff_init_one(pdev, ppi, sht, host_priv, 0);
}

without the need to update all drivers and without breaking pending
out-of-tree driver patches (yeah, it breaks my pata_ep93xx patches)..

--
Bartlomiej Zolnierkiewicz
