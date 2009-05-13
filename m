From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: Use IGN_SIMPLEX for ALi
Date: Wed, 13 May 2009 17:11:46 +0100
Message-ID: <20090513171146.59fe1425@lxorguk.ukuu.org.uk>
References: <20090513135941.11247.13097.stgit@t61.ukuu.org.uk>
	<20090513140201.11247.76226.stgit@t61.ukuu.org.uk>
	<4A0AEDAC.1020202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51884 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760934AbZEMQOm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 12:14:42 -0400
In-Reply-To: <4A0AEDAC.1020202@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> >  	/* Revision 0xC4 is UDMA100 */
> >  	static const struct ata_port_info info_c4 = {
> > -		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
> > +		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48 |
> > +							ATA_FLAG_IGN_SIMPLEX,
> 
>     Why it's always so far to the right?

Because your eyes are looking at the right hand side so by placing it
below and to the right when it doesn't quite fit you minimise the effort
needed to read it.

Anyone for a typesetting war 8)

Alan
