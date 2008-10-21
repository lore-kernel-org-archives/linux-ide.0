From: Tejun Heo <htejun@gmail.com>
Subject: Re: [smartmontools-support] inactive SATA drives won't stay in standby
 or sleep, PATA models did. (fwd)
Date: Tue, 21 Oct 2008 13:18:22 +0900
Message-ID: <48FD580E.4080101@gmail.com>
References: <D73D40172004714D95D7A84AC3E68EC802282133@wdscexbe03.sc.wdc.com>	<48EBFE9B.9070503@gmail.com>	<18674.4081.839329.116533@harpo.it.uu.se>	<48F2D9A8.1030502@gmail.com> <18683.50533.786782.474536@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:10918 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbYJUEUY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Oct 2008 00:20:24 -0400
Received: by ti-out-0910.google.com with SMTP id b6so992376tic.23
        for <linux-ide@vger.kernel.org>; Mon, 20 Oct 2008 21:20:23 -0700 (PDT)
In-Reply-To: <18683.50533.786782.474536@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Christian Mueller <Christian.Mueller@wdc.com>, Bruce Allen <ballen@gravity.phys.uwm.edu>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mikael.

> --- linux-2.6.27/drivers/ata/sata_promise.c.~1~	2008-07-14 10:22:36.000000000 +0200
> +++ linux-2.6.27/drivers/ata/sata_promise.c	2008-10-20 00:20:58.000000000 +0200
> @@ -153,6 +153,7 @@ static void pdc_freeze(struct ata_port *
>  static void pdc_sata_freeze(struct ata_port *ap);
>  static void pdc_thaw(struct ata_port *ap);
>  static void pdc_sata_thaw(struct ata_port *ap);
> +static int pdc_prereset(struct ata_link *link, unsigned long deadline);
>  static void pdc_error_handler(struct ata_port *ap);
>  static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
>  static int pdc_pata_cable_detect(struct ata_port *ap);
> @@ -175,6 +176,7 @@ static const struct ata_port_operations 
>  	.sff_irq_clear		= pdc_irq_clear,
>  
>  	.post_internal_cmd	= pdc_post_internal_cmd,
> +	.prereset		= pdc_prereset,
>  	.error_handler		= pdc_error_handler,
>  };
>  
> @@ -691,6 +693,12 @@ static void pdc_sata_thaw(struct ata_por
>  	readl(host_mmio + hotplug_offset); /* flush */
>  }
>  
> +static int pdc_prereset(struct ata_link *link, unsigned long deadline)
> +{
> +	pdc_reset_port(link->ap);

I would put this into ->hardreset itself as the controller can also
get out of sync with reality during reset.  Other than that, looks
like the correct approach.

Thanks.

-- 
tejun
