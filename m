From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 16:25:50 -0400
Message-ID: <42FBB44E.1020004@pobox.com>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain> <42FBB33D.8050003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:38056 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932433AbVHKUZz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:25:55 -0400
In-Reply-To: <42FBB33D.8050003@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>, Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> The system is thus:
> 
> 1) drivers/pci/quirks.c reserves SATA ports (only!) for libata
> 2) Legacy IDE driver claims the unreserved PATA port
> 3) libata loads and uses the ports reserved in #1
> 
> This requires a specific kernel configuration:
> (a) CONFIG_IDE_GENERIC be set, and
> (b) IDE driver is built into the kernel.
> 
> This also requires that your SATA device is listed in drivers/pci/quirks.c.
> 
> Both (a) and (b) are kernel configuration issues.  I never saw anything 
> in any email thread indicating that (a) and (b) were verified and 
> eliminated as problem sources.

To be more clear:

The legacy ISA IDE driver, not the PIIX IDE driver, must claim the PATA 
port.

That is why it was incorrect to add ICH SATA PCI IDs to 
drivers/ide/pci/piix.c.

	Jeff


