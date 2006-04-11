From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] libata: fix can't free irq 14 on legacy mode pata
 driver
Date: Tue, 11 Apr 2006 18:42:20 +0800
Message-ID: <443B880C.5070303@tw.ibm.com>
References: <443B7BD9.4040901@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:8584 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750726AbWDKKmo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 06:42:44 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3BAgbtw028044
	for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:42:37 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3BAd9ne176588
	for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 04:39:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3BAga7J016864
	for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 04:42:37 -0600
In-Reply-To: <443B7BD9.4040901@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Unicorn Chang <uchang@tw.ibm.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@maxeymade.com>

Unicorn Chang wrote:
> -fix can't free irq 14 on legacy mode pata driver
> -fix the ata_host_set_remove() memory leak problem
> 
> Signed-off-by: Unicorn Chang <uchang@tw.ibm.com>
> ---
> 
> keep all ata_host_set structure for free irq use on legacy mode pata
> driver. 
> (Patch against upstream branch)
> 
> using "rmmod pata_amd" and then "modprobe pata_amd" to produce bug and
> same bug report by Krzysztof Halasa:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114122847813360&w=2
> 
> --- a/drivers/scsi/libata-core.c	2006-04-10 16:30:46.718750000 +0800
> +++ b/drivers/scsi/libata-core.c	2006-04-11 17:02:52.109375000 +0800
> @@ -4794,6 +4794,8 @@ int ata_device_add(const struct ata_prob
>  		ata_scsi_scan_host(ap);
>  	}
>  
> +	/* don't lose last one, free irq will need it */
> +	host_set->host_set_chain = dev_get_drvdata(dev);
>  	dev_set_drvdata(dev, host_set);
>  
>  	VPRINTK("EXIT, returning %u\n", ent->n_ports);
> @@ -4826,6 +4828,9 @@ void ata_host_set_remove(struct ata_host
>  	struct ata_port *ap;
>  	unsigned int i;
>  
> +	if(host_set->host_set_chain)
> +		ata_host_set_remove(host_set->host_set_chain);
> +	
>  	for (i = 0; i < host_set->n_ports; i++) {
>  		ap = host_set->ports[i];
>  		scsi_remove_host(ap->host);
> --- a/include/linux/libata.h	2006-04-10 16:32:06.656250000 +0800
> +++ b/include/linux/libata.h	2006-04-10 17:51:19.812500000 +0800
> @@ -304,6 +304,7 @@ struct ata_host_set {
>  	int			simplex_claimed;	/* Keep seperate in case we
>  							   ever need to do this locked */
>  	struct ata_port *	ports[0];
> +	struct ata_host_set	*host_set_chain;	/* Keep last host_set */
>  };
>  
>  struct ata_queued_cmd { 
> 
> 

Jeff,

Althouth this patch fixes the irq/host_set leak, the SIMPLEX flag
is still assigned to both host_sets of legacy primary/secondary port.
Under legacy two-port case, both ports might claim the SIMPLEX flag (and DMA engine).
This is another problem not fixed by this patch.

Is there any consideration to assign each legacy port its own host_set?
Maybe we could let both primary/secondary legacy port share the same host_set,
as done in the native case? (Maybe adding an addtional irq to host_set is good enough.)
For each PCI devfn, assigning a corresponding host_set (instead of two) looks more reasonable.

--
albert

