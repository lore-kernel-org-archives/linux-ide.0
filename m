From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 6/20] libata: implement legacy ATA init helpers
Date: Tue, 19 Sep 2006 01:26:11 -0400
Message-ID: <450F7F73.1000409@pobox.com>
References: <1155977971677-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:2719 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752069AbWISF0c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:26:32 -0400
In-Reply-To: <1155977971677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement the following legacy ATA init helpers.
> 
> * ata_legacy_acquire_resources()	: acquire legacy ATA resources
> * ata_legacy_release_resources()	: release legacy ATA resources
> * ata_legacy_init_ports()		: init legacy port addresses
> * ata_legacy_request_irqs()		: request legacy ATA IRQs
> * ata_legacy_free_irqs()		: free legacy ATA IRQs
> 
> These helpers can be used independently or called implictly from other
> bus helpers which has support for legacy ATA device for compatibility
> (e.g. PCI).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

The irq part will change based on comments from previous email



> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 2109d75..1a98559 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -15,6 +15,11 @@ config ATA
>  	  that "speaks" the ATA protocol, also called ATA controller),
>  	  because you will be asked for it.
>  
> +config ATA_LEGACY
> +	bool
> +	depends on ATA
> +	default n
> +
>  config SATA_AHCI
>  	tristate "AHCI SATA support"
>  	depends on ATA && PCI
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index c17ae9c..61d3e76 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -19,3 +19,6 @@ obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
>  
>  libata-objs	:= libata-core.o libata-scsi.o libata-bmdma.o libata-eh.o
>  
> +ifeq ($(CONFIG_ATA_LEGACY),y)
> +libata-objs	+= libata-legacy.o
> +endif
> diff --git a/drivers/ata/libata-legacy.c b/drivers/ata/libata-legacy.c
> new file mode 100644
> index 0000000..00b70b0
> --- /dev/null
> +++ b/drivers/ata/libata-legacy.c
> @@ -0,0 +1,241 @@
> +/*
> + *  libata-legacy.c - helper library for legacy ATA
> + *
> + *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
> + *    		    Please ALWAYS copy linux-ide@vger.kernel.org
> + *		    on emails.
> + *
> + *  Copyright 2006 Tejun Heo <htejun@gmail.com>
> + *
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License as
> + *  published by the Free Software Foundation; either version 2, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; see the file COPYING.  If not, write to
> + *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
> + *  USA.
> + *
> + *
> + *  libata documentation is available via 'make {ps|pdf}docs',
> + *  as Documentation/DocBook/libata.*
> + *
> + *  Hardware documentation available from http://www.t13.org/ and
> + *  http://www.sata-io.org/
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/libata.h>
> +
> +#include "libata.h"
> +
> +static unsigned long ata_legacy_addr(int port, int sel)
> +{
> +	if (port == 0) {
> +		if (sel == 0)
> +			return ATA_PRIMARY_CMD;
> +		else
> +			return ATA_PRIMARY_CTL;
> +	} else {
> +		if (sel == 0)
> +			return ATA_SECONDARY_CMD;
> +		else
> +			return ATA_SECONDARY_CTL;
> +	}
> +}

insufficient long term, but matches current code so ACK for now.

This will change depending on platform, and for easier x86 chipsets



> +static int ata_legacy_acquire_port(struct ata_port *ap)
> +{
> +	struct ata_host *host = ap->host;
> +	unsigned long cmd_addr = ata_legacy_addr(ap->port_no, 0);
> +
> +	if (request_region(cmd_addr, 8, "libata") != NULL)
> +		host->legacy_flags |= ATA_LEGACY_RES_PRI << ap->port_no;
> +	else {
> +		struct resource *conflict, res;
> +
> +		res.start = cmd_addr;
> +		res.end = cmd_addr + 8 - 1;
> +		conflict = ____request_resource(&ioport_resource, &res);
> +
> +		if (strcmp(conflict->name, "libata")) {
> +			printk(KERN_WARNING "ata: 0x%0lX IDE port busy\n",
> +			       cmd_addr);
> +			host->flags |= ATA_HOST_DEV_BUSY;
> +			return -EBUSY;
> +		}
> +		printk("ata: 0x%0lX IDE port preallocated\n", cmd_addr);

obviously needs updating based on the patch I just applied to 
libata#upstream from Arnaud @ Mandriva


> +/**
> + *	ata_legacy_acquire_resources - acquire legacy ATA resources
> + *	@host: target ATA host
> + *	@p_reason: out arg for error message (can be NULL)
> + *
> + *	Acquire legacy ATA resources for ports specified by
> + *	ATA_PORT_PRIMARY/SECONDARY mask in host->legacy_flags.  If the
> + *	port is busy, this function makes the port dummy instead of
> + *	failing.  This is to allow legacy ports to be driven by other
> + *	drivers.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + */
> +int ata_legacy_acquire_resources(struct ata_host *host, const char **p_reason)
> +{
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
> +		if (!(host->legacy_flags & (ATA_PORT_PRIMARY << i)))
> +			continue;
> +		BUG_ON(i >= host->n_ports);
> +
> +		if (ata_legacy_acquire_port(host->ports[i]))
> +			host->ports[i]->ops = &ata_dummy_port_ops;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + *	ata_legacy_release_resources - release legacy ATA resources
> + *	@host: target ATA host
> + *
> + *	Free all legacy ATA resources @host is holding.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +void ata_legacy_release_resources(struct ata_host *host)
> +{
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
> +		if (host->legacy_flags & (ATA_LEGACY_RES_PRI << i)) {
> +			release_region(ata_legacy_addr(i, 0), 8);
> +			host->legacy_flags &= ~(ATA_LEGACY_RES_PRI << i);
> +		}
> +	}
> +}
> +
> +/**
> + *	ata_legacy_init_ports - initialize legacy ATA port addresses
> + *	@host: target ATA host
> + *
> + *	Initialize legacy ATA port addresses for non-dummy legacy
> + *	ports in @host.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer.
> + */
> +void ata_legacy_init_ports(struct ata_host *host)
> +{
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
> +		struct ata_port *ap = host->ports[i];
> +
> +		if (host->legacy_flags & (ATA_PORT_PRIMARY << i) &&
> +		    !ata_port_is_dummy(ap)) {
> +			struct ata_ioports *ioaddr = &ap->ioaddr;
> +			unsigned long cmd_addr = ata_legacy_addr(i, 0);
> +			unsigned long ctl_addr = ata_legacy_addr(i, 1);
> +
> +			ioaddr->cmd_addr = cmd_addr;
> +			ioaddr->altstatus_addr = ctl_addr;
> +			ioaddr->ctl_addr = ctl_addr;
> +			ata_std_ports(ioaddr);
> +		}
> +	}
> +}
> +
> +/**
> + *	ata_legacy_request_irqs - request legacy ATA IRQs
> + *	@host: target ATA host
> + *	@handler: array of IRQ handlers
> + *	@irq_flags: array of IRQ flags
> + *	@dev_id: array of IRQ dev_ids
> + *	@p_reason: out arg for error message (can be NULL)
> + *
> + *	Request legacy IRQs for non-dummy legacy ports in @host.  All
> + *	IRQ parameters are passed as array to allow ports to have
> + *	separate IRQ handlers.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + *
> + *	RETURNS:
> + *	0 on success, -errno otherwise.
> + */
> +int ata_legacy_request_irqs(struct ata_host *host,
> +		irqreturn_t (* const * handler)(int, void *, struct pt_regs *),
> +		const unsigned int *irq_flags, void * const *dev_id,
> +		const char **p_reason)
> +{
> +	const unsigned int legacy_irq[] = { 14, 15 };
> +	const char *reason;
> +	int i, rc;
> +
> +	for (i = 0; i < 2; i++) {
> +		struct ata_port *ap = host->ports[i];
> +		unsigned int irq = legacy_irq[i];
> +
> +		if (!(host->legacy_flags & (ATA_PORT_PRIMARY << i)) ||
> +		    ata_port_is_dummy(ap))
> +			continue;
> +
> +		if (!handler[i]) {
> +			reason = "NULL handler";
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +
> +		rc = ata_host_request_irq_marker(host, irq,
> +					handler[i], irq_flags[i], dev_id[i],
> +					ata_legacy_request_irqs, &reason);
> +		if (rc)
> +			goto err;
> +
> +		/* only for info printing */
> +		if (i == 0)
> +			host->irq = irq;
> +		else
> +			host->irq2 = irq;
> +	}
> +
> +	return 0;
> +
> + err:
> +	ata_legacy_free_irqs(host);
> +	if (p_reason)
> +		*p_reason = reason;
> +	return rc;
> +}
> +
> +/**
> + *	ata_legacy_free_irqs - free legacy ATA IRQs
> + *	@host: target ATA host
> + *
> + *	Free all legacy ATA IRQs of @host.
> + *
> + *	LOCKING:
> + *	Inherited from calling layer (may sleep).
> + */
> +void ata_legacy_free_irqs(struct ata_host *host)
> +{
> +	ata_host_free_irqs_marker(host, ata_legacy_request_irqs);
> +}
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 1d24254..0601c4a 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -117,6 +117,17 @@ extern void ata_schedule_scsi_eh(struct 
>  extern void ata_scsi_dev_rescan(void *data);
>  extern int ata_bus_probe(struct ata_port *ap);
>  
> +/* libata-legacy.c */
> +extern int ata_legacy_acquire_resources(struct ata_host *host,
> +					const char **p_reason);
> +extern void ata_legacy_release_resources(struct ata_host *host);
> +extern void ata_legacy_init_ports(struct ata_host *host);
> +extern int ata_legacy_request_irqs(struct ata_host *host,
> +		irqreturn_t (* const * handler)(int, void *, struct pt_regs *),
> +		const unsigned int *irq_flags, void * const *dev_id,
> +		const char **p_reason);
> +extern void ata_legacy_free_irqs(struct ata_host *host);
> +
>  /* libata-eh.c */
>  extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
>  extern void ata_scsi_error(struct Scsi_Host *host);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index b050517..9535f54 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -200,8 +200,16 @@ enum {
>  	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
>  
>  	/* host set flags */
> -	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
> -	
> +	ATA_HOST_SIMPLEX	= (1 << 0), /* host is simplex, one DMA channel per host only */
> +	ATA_HOST_DEV_BUSY	= (1 << 1), /* host device was busy on init */

this flag is set but never used.  doesn't seem necessary anyway... just 
return an error code.

