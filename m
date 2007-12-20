From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pata_of_platform: Move electra-ide support over to new
	framework
Date: Thu, 20 Dec 2007 09:33:19 -0600
Message-ID: <20071220153319.GA17501@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204204432.GD8099@lixom.net> <4755BD7B.6030208@garzik.org> <20071204210344.GE8099@lixom.net> <18281.59210.200603.12093@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:42275 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933646AbXLTP0y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Dec 2007 10:26:54 -0500
Content-Disposition: inline
In-Reply-To: <18281.59210.200603.12093@cargo.ozlabs.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>

On Thu, Dec 20, 2007 at 02:53:46PM +1100, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > > FWIW I'm presuming this work will go via a powerpc tree not libata... 
> > > Generally that's not the case, but here it's largely an arch-specific work.
> > 
> > Ok, that works. I was thinking of letting this patch go through libata,
> > and do the removal through the powerpc merge path. But I can do both
> > through powerpc.
> 
> Are you going to send me a patch to do this addition plus the removal
> of the old stuff, or do you want me to merge this patch as is?

Yes, I will once the series it depends on has been sorted out and is
picked up somewhere, since it depends on it.


-Olof
