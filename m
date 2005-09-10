From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Date: Sat, 10 Sep 2005 19:35:10 -0400
Message-ID: <43236DAE.8000802@pobox.com>
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com> <432352A8.3010605@pobox.com> <20050910223333.GF4770@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:44438 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932257AbVIJXfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Sep 2005 19:35:25 -0400
In-Reply-To: <20050910223333.GF4770@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

Matthew Wilcox wrote:
> On Sat, Sep 10, 2005 at 05:39:52PM -0400, Jeff Garzik wrote:
> 
>>Look at what the IDE code is trying to do.  All it cares about is 
>>whether -any PCI device at all- is present, a boolean value.
> 
> 
> Why not change it to query whether any IDE device is present, perhaps
> using pci_get_class()?

Because that's not what the code is attempting to discover.

	Jeff



