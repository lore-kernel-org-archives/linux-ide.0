From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA link power management issues
Date: Fri, 24 Apr 2015 17:44:54 -0400
Message-ID: <20150424214214.GD27034@htj.duckdns.org>
References: <3352987.ugV1Ipy7Z5@xps13>
 <9107428.nVaRUddl4K@xps13>
 <20150421205608.GF9455@htj.duckdns.org>
 <23060306.XvNh4Q3UlK@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vn0-f53.google.com ([209.85.216.53]:33851 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005AbbDXVo6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Apr 2015 17:44:58 -0400
Content-Disposition: inline
In-Reply-To: <23060306.XvNh4Q3UlK@xps13>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stripathi@apm.com

Hello, Gabriele.

On Tue, Apr 21, 2015 at 11:44:28PM +0200, Gabriele Mazzotta wrote:
> I haven't considered that possibility. Something like the following then?

Yeah, looks great.  Some minor comments below.

> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1700,6 +1700,8 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
>  	struct ahci_port_priv *pp = ap->private_data;
>  	struct ahci_host_priv *hpriv = ap->host->private_data;
>  	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
> +	unsigned long lpm_timeout = ap->link.last_lpm_change + 10 * HZ;

We prolly want to define the timeout as a constant symbol in libata.h
and explain what this is about.

> +	int ignore_event = 0;

Use bool?

> @@ -1707,8 +1709,13 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
>  	if (unlikely(resetting))
>  		status &= ~PORT_IRQ_BAD_PMP;
>  
> +	if (time_before(jiffies, lpm_timeout) &&
> +	    (ap->link.flags & ATA_LFLAG_CHANGED))
> +		ignore_event = 1;

Nothing major but testing LFLAG first would prolly be a better style
given that timeout value is relevant only while the flag is asserted
and some comment would be nice too.

> @@ -788,6 +789,8 @@ struct ata_link {
>  	struct ata_eh_context	eh_context;
>  
>  	struct ata_device	device[ATA_MAX_DEVICES];
> +
> +	unsigned long		last_lpm_change;

A brief explanation would be nice.

Thanks.

-- 
tejun
