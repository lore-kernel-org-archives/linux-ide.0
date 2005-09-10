From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Date: Sat, 10 Sep 2005 16:33:33 -0600
Message-ID: <20050910223333.GF4770@parisc-linux.org>
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com> <432352A8.3010605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932339AbVIJWdm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <432352A8.3010605@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
List-Id: linux-ide@vger.kernel.org

On Sat, Sep 10, 2005 at 05:39:52PM -0400, Jeff Garzik wrote:
> Look at what the IDE code is trying to do.  All it cares about is 
> whether -any PCI device at all- is present, a boolean value.

Why not change it to query whether any IDE device is present, perhaps
using pci_get_class()?
