From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_Re: sata_mv success on 2.6.16-rc6-mm2
Date: Sun, 19 Mar 2006 16:25:36 -0500
Message-ID: <441DCC50.2000800@garzik.org>
References: <200603191613.37386.lkml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43173 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750910AbWCSVZk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Mar 2006 16:25:40 -0500
In-Reply-To: <200603191613.37386.lkml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Andrew Morton <akpm@osdl.org>, sander@humilis.net, linux-ide@vger.kernel.org, jgarzik@favonius.humilis.net

Mark Lord wrote:
> --- sata_mv.c.alignment	2006-03-19 15:14:29.000000000 -0500
> +++ sata_mv.c	2006-03-19 15:12:49.000000000 -0500
> @@ -1180,7 +1180,6 @@
>  	u32 hc_irq_cause;
>  	int shift, port, port0, hard_port, handled;
>  	unsigned int err_mask;
> -	u8 ata_status = 0;
>  
>  	if (hc == 0) {
>  		port0 = 0;
> @@ -1198,6 +1197,7 @@
>  		hc,relevant,hc_irq_cause);
>  
>  	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
> +		u8 ata_status = 0;

ACK, that's a bug (and fix) all right.

I'll wait and apply whatever cleaned-up patch arises out of this...

	Jeff


