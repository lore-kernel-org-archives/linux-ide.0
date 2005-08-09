From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Tue, 9 Aug 2005 13:59:58 -0400
Message-ID: <20050809175958.GA10315@havoc.gtf.org>
References: <200508071949.03782.inform@tiker.net> <42F6B8CD.4050100@gmail.com> <20050808030239.GA27502@havoc.gtf.org> <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:5254 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964900AbVHISAE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2005 14:00:04 -0400
Content-Disposition: inline
In-Reply-To: <42F8B41C.4040408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

On Tue, Aug 09, 2005 at 09:48:12AM -0400, Mark Lord wrote:
> Erik Slagter wrote:
> >
> >Is there a possibility that dell attaches PATA harddisks using a
> >SATA/PATA converter to the SATA connection of the ICH6M?
> 
> That chipset is used in virtually all modern laptops,
> and includes a PATA interface as well as SATA.
> 
> Most current laptops ship with a PATA hard drive, and a PATA
> ATAPI drive.  The easiest way to make them usable under Linux-2.6
> is to patch libata and turn on ATAPI support, using ata_piix.
> 
> This REALLY ought to be on by default now, Jeff.
> Especially since the default is to NOT work at all..

No, the IDE driver should be driving PATA chipsets at present, and if it
is not, someone should investigate the reason.

Turning on PATA support will probably be done soon, for PATA+SATA
combined mode situations, but not for others.  Flipping the switch
causes a lot of cases to switch from working /dev/hdX to working
/dev/sdX, which needs to be managed, and not done willy-nilly.

	Jeff



