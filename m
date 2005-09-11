From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] include: pci_find_device remove
	(include/asm-i386/ide.h)
Date: Sun, 11 Sep 2005 01:06:20 +0100
Message-ID: <1126397180.30449.16.camel@localhost.localdomain>
References: <200509102032.j8AKWxMC006246@localhost.localdomain>
	 <4323482E.2090409@pobox.com>  <20050910211932.GA13679@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:22448 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932383AbVIJXlW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Sep 2005 19:41:22 -0400
In-Reply-To: <20050910211932.GA13679@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On Sad, 2005-09-10 at 14:19 -0700, Greg KH wrote:
> > Looks like we need to resurrect pci_present() from the ancient past.
> 
> Heh, ick, no :)
> 
> Jiri, any other way to do this instead?

IDE really does want to know if you have a PCI bus of any kind attached.
Perhaps pci_present should really come back - its better than hiding the
gory details in drivers

