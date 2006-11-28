From: "Allen Martin" <AMartin@nvidia.com>
Subject: RE: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
Date: Mon, 27 Nov 2006 17:51:31 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48D3C1@hqemmail02.nvidia.com>
References: <20061127151541.16a93d49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:64792 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S933568AbWK1Bxz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Nov 2006 20:53:55 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20061127151541.16a93d49.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Nicolas.Mailhot@LaPoste.net

> >  static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
> >  {
> >  	struct ata_host *host = dev_instance;
> >  	int i, handled = 0;
> > +	u32 notifier_clears[2];
> >  
> >  	spin_lock(&host->lock);
> >  
> >  	for (i = 0; i < host->n_ports; i++) {
> >  		struct ata_port *ap = host->ports[i];
> > +		notifier_clears[i] = 0;
> 
> Promise us that n_ports will never exceed 2?

I promise it will never exceed 2, at least as far as NVIDIA ADMA
hardware is concerned.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
