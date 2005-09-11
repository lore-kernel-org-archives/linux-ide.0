From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] include: pci_find_device remove
	(include/asm-i386/ide.h)
Date: Sun, 11 Sep 2005 02:06:56 +0100
Message-ID: <1126400817.30449.22.camel@localhost.localdomain>
References: <200509102032.j8AKWxMC006246@localhost.localdomain>
	 <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com>
	 <432352A8.3010605@pobox.com> <20050910223333.GF4770@parisc-linux.org>
	 <43236DAE.8000802@pobox.com>  <20050911003409.GB25282@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:10156 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932504AbVIKAoP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Sep 2005 20:44:15 -0400
In-Reply-To: <20050911003409.GB25282@colo.lackof.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On Sad, 2005-09-10 at 18:34 -0600, Grant Grundler wrote:
> If ide_scan_pcibus() finds any pci device, it calls ide_scan_pcidev().
> ide_scan_pcidev() only seems to handle PCI devices.
> Are you saying there are PCI IDE devices out there that
> don't advertise PCI_CLASS_STORAGE_IDE?

Lots of them. We also want to know if PCI is present so we can know
whether to do the IDE tertiary scan which isn't safe on a PCI bus box.

