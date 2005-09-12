From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] include: pci_find_device remove
	(include/asm-i386/ide.h)
Date: Mon, 12 Sep 2005 11:17:21 +0100
Message-ID: <1126520241.30449.42.camel@localhost.localdomain>
References: <200509102032.j8AKWxMC006246@localhost.localdomain>
	 <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com>
	 <432352A8.3010605@pobox.com> <20050910223333.GF4770@parisc-linux.org>
	 <43236DAE.8000802@pobox.com> <20050911003409.GB25282@colo.lackof.org>
	 <1126400817.30449.22.camel@localhost.localdomain>
	 <20050911013004.GI4770@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:42400 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751279AbVILJxD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Sep 2005 05:53:03 -0400
In-Reply-To: <20050911013004.GI4770@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On Sad, 2005-09-10 at 19:30 -0600, Matthew Wilcox wrote:
> > Lots of them. We also want to know if PCI is present so we can know
> > whether to do the IDE tertiary scan which isn't safe on a PCI bus box.
> 
> surely this is worthy of a comment in the code.  there's at least 3
> people on the cc who're confused bby what it's for.

Thats because someone removed the obvious pci_present() function some
time ago.

Alan

