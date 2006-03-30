From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.16] sata_mv.c :: three bug fixes
Date: Wed, 29 Mar 2006 19:46:05 -0500
Message-ID: <442B2A4D.4010606@pobox.com>
References: <200603290950.32219.lkml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:640 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751313AbWC3AqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Mar 2006 19:46:09 -0500
In-Reply-To: <200603290950.32219.lkml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>, sander@humilis.net

Mark Lord wrote:
>  	u8 ata_status = 0;
[...]
>  	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
> -		ap = host_set->ports[port];
> +		struct ata_port *ap = host_set->ports[port];
> +		struct mv_port_priv *pp = ap->private_data;
>  		hard_port = port & MV_PORT_MASK;	/* range 0-3 */


Applied, even though it should be quite obvious that the patch does not 
apply to 2.6.16 at all; its missing your previous ata_status patch, 
which the upstream kernel has already included.

	Jeff


