From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes 2/3] pata_hpt366: fix cable detection
Date: Mon, 8 Dec 2008 11:44:42 +0000
Message-ID: <20081208114442.6310391d@lxorguk.ukuu.org.uk>
References: <493CED7A.2010505@kernel.org>
	<493CEE74.3060601@kernel.org>
	<493D03A4.1090409@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41284 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755196AbYLHLox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 06:44:53 -0500
In-Reply-To: <493D03A4.1090409@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

> >  	pci_read_config_byte(pdev, 0x5A, &ata66);
> > -	if (ata66 & (1 << ap->port_no))
> > +	if (ata66 & (2 >> ap->port_no))
> >   
> 
>    HPT36x are single channel per function, so the shift can be removed.

In the case of two channels are you sure the bits appear as bit 2 in both
cases ?

Alan
