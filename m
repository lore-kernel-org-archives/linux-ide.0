From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/9] libata: normalize port_info, port_operations and
 sht tables
Date: Mon, 4 Feb 2008 14:24:50 +0000
Message-ID: <20080204142450.38478f70@core>
References: <12016853433196-git-send-email-htejun@gmail.com>
	<12016853433225-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47631 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751145AbYBDObn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 09:31:43 -0500
In-Reply-To: <12016853433225-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com, Tejun Heo <htejun@gmail.com>

> * Every driver for SFF controllers now uses ata_pci_default_filter()
>   unless the driver has custom implementation.

That is only needed for DMA capable devices. I guess it does no harm to
be consistent and call it anyway but you then say ..

> * No reason to set ata_pci_default_filter() for PIO-only drivers.

and your patches add the calls for the CS5520 ?


> diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
> index 972ed9f..5614e76 100644
> --- a/drivers/ata/pata_cs5520.c
> +++ b/drivers/ata/pata_cs5520.c
> @@ -160,6 +160,7 @@ static struct scsi_host_template cs5520_sht = {
>  static struct ata_port_operations cs5520_port_ops = {
>  	.set_piomode		= cs5520_set_piomode,
>  	.set_dmamode		= cs5520_set_dmamode,
> +	.mode_filter		= ata_pci_default_filter,

This case is wrong. CS5520 doesn't do DMA (just VDMA which we don't
support) and in addition doesn't use BAR4 so its not a generic PCI
controller and this is asking for trouble later.

> diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
> index 8f79447..ebb9dc1 100644
> --- a/drivers/ata/pata_opti.c
> +++ b/drivers/ata/pata_opti.c
> @@ -184,6 +184,7 @@ static struct scsi_host_template opti_sht = {
>  
>  static struct ata_port_operations opti_port_ops = {
>  	.set_piomode	= opti_set_piomode,
> +	.mode_filter	= ata_pci_default_filter,

PIO only


> --- a/drivers/ata/pata_rz1000.c
> +++ b/drivers/ata/pata_rz1000.c
> @@ -72,6 +72,7 @@ static struct scsi_host_template rz1000_sht = {
>  
>  static struct ata_port_operations rz1000_port_ops = {
>  	.set_mode	= rz1000_set_mode,
> +	.mode_filter	= ata_pci_default_filter,

PIO only

