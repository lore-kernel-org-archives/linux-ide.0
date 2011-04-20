From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
 boot on parisc
Date: Wed, 20 Apr 2011 09:28:18 -0500
Message-ID: <1303309698.2587.10.camel@mulgrave.site>
References: <1303152147.7167.12.camel@mulgrave.site>
	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	 <1303159802.7167.30.camel@mulgrave.site>
	 <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
	 <4DADF798.6010705@ru.mvista.com>
	 <20110419221900.67528a07@lxorguk.ukuu.org.uk>
	 <4DADFD2E.9070809@ru.mvista.com>
	 <20110419222838.6a6f36aa@lxorguk.ukuu.org.uk>
	 <1303254709.11237.34.camel@mulgrave.site>  <4DAEAF9A.1020704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38421 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752248Ab1DTO2V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Apr 2011 10:28:21 -0400
In-Reply-To: <4DAEAF9A.1020704@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>

On Wed, 2011-04-20 at 14:04 +0400, Sergei Shtylyov wrote:

> > +		dev_printk(KERN_NOTICE, &pdev->dev, "Mobility Bridge detected, ignoring CNTRL port enable/disable\n");
> > +	/* 643 and 646 no UDMA, primary port always enabled */
> > +	if (port_ok && id->driver_data > 1 &&  !(reg & CNTRL_PRIMARY)) {
> 
>     PCI0646U and later revisions on PCI0646 do have the primary port enable 
> bit. The same about UltraDMA -- PCI0646U2 has it. Look at what cmd64x does in 
> cmd64x_init_one()...

Where?  All I see in drivers/ide/cmd64x.c is that it only ignores the
primary for the id->driver_data == 0 case, which is what I originally
coded.

James


