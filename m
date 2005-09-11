From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Date: Sat, 10 Sep 2005 19:30:04 -0600
Message-ID: <20050911013004.GI4770@parisc-linux.org>
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com> <432352A8.3010605@pobox.com> <20050910223333.GF4770@parisc-linux.org> <43236DAE.8000802@pobox.com> <20050911003409.GB25282@colo.lackof.org> <1126400817.30449.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932738AbVIKBaK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1126400817.30449.22.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
List-Id: linux-ide@vger.kernel.org

On Sun, Sep 11, 2005 at 02:06:56AM +0100, Alan Cox wrote:
> On Sad, 2005-09-10 at 18:34 -0600, Grant Grundler wrote:
> > If ide_scan_pcibus() finds any pci device, it calls ide_scan_pcidev().
> > ide_scan_pcidev() only seems to handle PCI devices.
> > Are you saying there are PCI IDE devices out there that
> > don't advertise PCI_CLASS_STORAGE_IDE?
> 
> Lots of them. We also want to know if PCI is present so we can know
> whether to do the IDE tertiary scan which isn't safe on a PCI bus box.

surely this is worthy of a comment in the code.  there's at least 3
people on the cc who're confused bby what it's for.
