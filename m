From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.21-mm1 2/2] sata_promise: SATAII-150/300 TX4 port
 numbering fix
Date: Thu, 10 May 2007 10:58:35 +0200
Message-ID: <17986.57019.188142.60725@alkaid.it.uu.se>
References: <200705062014.l46KE1U3026752@harpo.it.uu.se>
	<4642647A.5010901@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38458 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755269AbXEJJRj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 05:17:39 -0400
In-Reply-To: <4642647A.5010901@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik writes:
 > > +	if ((pi->flags & (PDC_FLAG_GEN_II|PDC_FLAG_4_PORTS)) == (PDC_FLAG_GEN_II|PDC_FLAG_4_PORTS)) {
 > > +		is_sataii_tx4 = 1;
 > > +		dev_printk(KERN_INFO, &pdev->dev, "applying SATAII TX4 port numbering workaround\n");
 > 
 >    ...though I'm not sure the printk is really wanted.  nonetheless, I 
 > applied it.

Thanks.

There's also the older "PATA port found\n", which is redundant
since libata will print "PATA" as it logs the corresponding ata dev.
I can remove both if you like.

/Mikael
