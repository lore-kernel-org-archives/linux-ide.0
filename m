From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC] PATA port on SATA controllers
Date: Sun, 14 Nov 2004 20:49:00 -0500
Message-ID: <41980B0C.1090108@pobox.com>
References: <20041003034752.55539.qmail@web60306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18873 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261395AbUKOBtO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Nov 2004 20:49:14 -0500
In-Reply-To: <20041003034752.55539.qmail@web60306.mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Benada <erikbenada@yahoo.ca>
Cc: linux-ide@vger.kernel.org

Erik Benada wrote:
> Hi Jeff,
> 
> this is the first attempt to properly support SATA and PATA ports on the same controller.
> Patch is against 2.6.9-rc3.
> 
> Changes:
> - ata_probe_ent: multiple ata_port_operations, per port flags
> - libata-core.c: changes for new ata_probe_ent + minor cleanups (mostly in comments)
> - sata_promise.c: PATA port support using new infrastructure
> 
> Tested on my PDC20378.
> 
> Any suggestions, comments?

Sorry it took so long to comment, I was pondering the best way things 
should look.


> Questions:
> -----------
> 1. In your e-mail outlining steps required to properly support PATA port on SATA controller
> you mentioned ata_host_set structure. Why do we need multiple ata_port_operations in there? I
> couldn't find any code that uses anything but irq_handler, irq_clear and host_stop.
> 
> 2. Would it make sense to create ata_host_ops structure to move host related operations (like
> irq_handler, irq_clear, host_stop) from ata_port_operations and replace ata_host_set->ops with it?

Yes, and this sorta answers questions #1 as well.  irq_handler/etc. are 
host-granularity not port-granularity, and so would be more appropriate 
to have a separate host_ops rather than referencing port_ops[0]->foo().


> 3. ata_port_info structure - is it intended to describe just 1 port or should it now support
> multiple ports (by adding n_ports and multiple ata_port_operations)?

ata_port_info was intended to describe a single controller, so it's a 
bit misnamed per the current scheme.


> @@ -104,35 +109,55 @@ static Scsi_Host_Template pdc_sata_sht =
>  	.bios_param		= ata_std_bios_param,
>  };
>  
> -static struct ata_port_operations pdc_sata_ops = {
> -	.port_disable		= ata_port_disable,
> -	.tf_load		= pdc_tf_load_mmio,
> -	.tf_read		= ata_tf_read,
> -	.check_status		= ata_check_status,
> -	.exec_command		= pdc_exec_command_mmio,
> -	.dev_select		= ata_std_dev_select,
> -	.phy_reset		= pdc_phy_reset,
> -	.qc_prep		= pdc_qc_prep,
> -	.qc_issue		= pdc_qc_issue_prot,
> -	.eng_timeout		= pdc_eng_timeout,
> -	.irq_handler		= pdc_interrupt,
> -	.irq_clear		= pdc_irq_clear,
> -	.scr_read		= pdc_sata_scr_read,
> -	.scr_write		= pdc_sata_scr_write,
> -	.port_start		= pdc_port_start,
> -	.port_stop		= pdc_port_stop,
> +static struct ata_port_operations pdc_port_ops[] = {
> +	{	/* SATA port operations */
> +		.port_disable		= ata_port_disable,
> +		.tf_load		= pdc_tf_load_mmio,
> +		.tf_read		= ata_tf_read,
> +		.check_status		= ata_check_status,
> +		.exec_command		= pdc_exec_command_mmio,
> +		.dev_select		= ata_std_dev_select,
> +		.phy_reset		= pdc_sata_phy_reset,
> +		.qc_prep		= pdc_qc_prep,
> +		.qc_issue		= pdc_qc_issue_prot,
> +		.eng_timeout		= pdc_eng_timeout,
> +		.irq_handler		= pdc_interrupt,
> +		.irq_clear		= pdc_irq_clear,
> +		.scr_read		= pdc_sata_scr_read,
> +		.scr_write		= pdc_sata_scr_write,
> +		.port_start		= pdc_port_start,
> +		.port_stop		= pdc_port_stop,
> +	},
> +	{	/* PATA port operations */
> +		.port_disable		= ata_port_disable,
> +		.tf_load		= pdc_tf_load_mmio,
> +		.tf_read		= ata_tf_read,
> +		.check_status		= ata_check_status,
> +		.exec_command		= pdc_exec_command_mmio,
> +		.dev_select		= ata_std_dev_select,
> +		.phy_reset		= pdc_pata_phy_reset,
> +		.qc_prep		= pdc_qc_prep,
> +		.qc_issue		= pdc_qc_issue_prot,
> +		.eng_timeout		= pdc_eng_timeout,
> +		.irq_handler		= pdc_interrupt,
> +		.irq_clear		= pdc_irq_clear,
> +		.scr_read		= pdc_sata_scr_read,
> +		.scr_write		= pdc_sata_scr_write,
> +		.port_start		= pdc_port_start,
> +		.port_stop		= pdc_port_stop,
> +	},

I would prefer two named variables, to a single array.

	Jeff


