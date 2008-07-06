From: Tejun Heo <htejun@gmail.com>
Subject: Re: [KERNEL 2.6.26-rc4]  bugreport : pata_pcmcia with Sandisk Extreme
 III 8GB
Date: Sun, 06 Jul 2008 23:19:24 +0900
Message-ID: <4870D46C.7000604@gmail.com>
References: <20080528225049.9a134e0d.Kristoffer.Ericson@Gmail.com>	<20080528222740.GB20893@isilmar.linta.de>	<20080530135728.be02d3dc.Kristoffer.Ericson@Gmail.com>	<20080607223716.7d142072.komurojun-mbn@nifty.com>	<20080611072029.GB28692@comet.dominikbrodowski.net>	<20080614120055.ad8fbee0.komurojun-mbn@nifty.com>	<48537149.4040102@garzik.org>	<20080614213612.96873c25.komurojun-mbn@nifty.com>	<4855D8E2.10409@gmail.com>	<20080616221145.e3b069b9.komurojun-mbn@nifty.com>	<485669A0.6000404@gmail.com>	<20080617212345.c452d8c5.komurojun-mbn@nifty.com> <20080706103752.13935ffd.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:61541 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309AbYGFOTy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 10:19:54 -0400
Received: by ti-out-0910.google.com with SMTP id b6so301559tic.23
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 07:19:52 -0700 (PDT)
In-Reply-To: <20080706103752.13935ffd.komurojun-mbn@nifty.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-pcmcia <linux-pcmcia@lists.infradead.org>, linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, jgarzik@redhat.com, rjw@sisk.pl

Hello, Komuro.

Komuro wrote:
> Hi, Tejun
> 
> The patch below fixes the pata_pcmcia problem.
> 
> I think the ap->lock points to bogus address.
> 
> Any comment?
> 
> --- linux-2.6.26-rc8/drivers/ata/libata-core.c.orig	2008-07-06 10:05:46.000000000 +0900
> +++ linux-2.6.26-rc8/drivers/ata/libata-core.c	2008-07-06 10:09:16.000000000 +0900
> @@ -5304,6 +5304,8 @@ struct ata_host *ata_host_alloc(struct d
>  			goto err_out;
>  
>  		ap->port_no = i;
> +		ap->lock = &ap->__lock;
> +		spin_lock_init(ap->lock);
>  		host->ports[i] = ap;
>  	}
>  
> --- linux-2.6.26-rc8/include/linux/libata.h.orig	2008-07-06 10:03:54.000000000 +0900
> +++ linux-2.6.26-rc8/include/linux/libata.h	2008-07-06 10:04:35.000000000 +0900
> @@ -639,6 +639,7 @@ struct ata_port {
>  	struct Scsi_Host	*scsi_host; /* our co-allocated scsi host */
>  	struct ata_port_operations *ops;
>  	spinlock_t		*lock;
> +	spinlock_t		__lock;
>  	unsigned long		flags;	/* ATA_FLAG_xxx */
>  	unsigned int		pflags; /* ATA_PFLAG_xxx */
>  	unsigned int		print_id; /* user visible unique port ID */

Hmmm... Strange.  From ata_port_alloc(),

struct ata_port *ata_port_alloc(struct ata_host *host)
{
	struct ata_port *ap;

	DPRINTK("ENTER\n");

	ap = kzalloc(sizeof(*ap), GFP_KERNEL);
	if (!ap)
		return NULL;

	ap->pflags |= ATA_PFLAG_INITIALIZING;
	ap->lock = &host->lock;
	^^^^^^^^^^^^^^^^^^^^^^^

How come ap->lock can get set to bogus address?  Can you please printk
&host->lock and ap->lock after ata_host_alloc() without the patch?

Thanks.

-- 
tejun
