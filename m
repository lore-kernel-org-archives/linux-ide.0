From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.21-mm1 2/2] sata_promise: SATAII-150/300 TX4 port
 numbering fix
Date: Fri, 01 Jun 2007 16:28:36 -0400
Message-ID: <46608174.6050900@garzik.org>
References: <200705062014.l46KE1U3026752@harpo.it.uu.se>	<4642647A.5010901@garzik.org> <17986.57019.188142.60725@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55552 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762206AbXFAU2j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Jun 2007 16:28:39 -0400
In-Reply-To: <17986.57019.188142.60725@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Jeff Garzik writes:
>  > > +	if ((pi->flags & (PDC_FLAG_GEN_II|PDC_FLAG_4_PORTS)) == (PDC_FLAG_GEN_II|PDC_FLAG_4_PORTS)) {
>  > > +		is_sataii_tx4 = 1;
>  > > +		dev_printk(KERN_INFO, &pdev->dev, "applying SATAII TX4 port numbering workaround\n");
>  > 
>  >    ...though I'm not sure the printk is really wanted.  nonetheless, I 
>  > applied it.
> 
> Thanks.
> 
> There's also the older "PATA port found\n", which is redundant
> since libata will print "PATA" as it logs the corresponding ata dev.
> I can remove both if you like.

Agreed, that would be nice.

	Jeff



