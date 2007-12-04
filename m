From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata.h: Don't do a SATA check for 40wire_relaxed
Date: Tue, 4 Dec 2007 20:29:44 +0000
Message-ID: <20071204202944.57d93849@the-village.bc.nu>
References: <20071119152434.45363e5d@the-village.bc.nu>
	<4755A898.7050707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50560 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751108AbXLDUeL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 15:34:11 -0500
In-Reply-To: <4755A898.7050707@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> > -	if (ata_id_is_sata(dev_id))
> > -		return 0;	/* SATA */
> >  	if ((dev_id[93] & 0x2000) == 0x2000)
> >  		return 0;	/* 80 wire */
> >  	return 1;
> 
> I've been thinking a lot about this, and I am really wondering if we 
> should fix up the IDENTIFY DEVICE page instead?

You want to intercept all the SG_IO calls to do an ATAPI identify and
make them lie ? I'm not personally sure thats a good idea.

Alan
