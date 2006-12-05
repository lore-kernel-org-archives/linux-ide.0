From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
Date: Tue, 5 Dec 2006 10:37:35 -0700
Message-ID: <20061205173735.GA13179@colo.lackof.org>
References: <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org> <4574197A.2020204@ru.mvista.com> <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org> <45741DDE.4080509@ru.mvista.com> <20061204132124.4f7c50a9@localhost.localdomain> <45742253.1000807@ru.mvista.com> <20061204142201.68d9621f@localhost.localdomain> <1165293679.29784.39.camel@localhost.localdomain> <20061205105126.GC12351@iram.es> <45756861.2050004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:53126 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968508AbWLERhi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Dec 2006 12:37:38 -0500
Content-Disposition: inline
In-Reply-To: <45756861.2050004@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, greg@kroah.com, linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz, Alan <alan@lxorguk.ukuu.org.uk>

On Tue, Dec 05, 2006 at 03:38:57PM +0300, Sergei Shtylyov wrote:
> >Well, I don't have the PCI specification, but I have a device with the 
> 
>    Try googling for pdf21.pdf, pdf22.pdf if you need it. :-)

I think you meant pci21.pdf/pci22.pdf/pci23.pdf.

And if you find them, trust me when I say whoever is hosting those files
can expect a cease-and-desist letter in the mail shortly there after.

Better to just ask someone with proper access to lookup the parts
you need to know (i.e. ask here). Member companies are listed at:
	http://www.pcisig.com/membership/about_us/membership_roster/

if you want to approach someone offlist.

> >following gem in its errata (name edited and changed to <Device>):
> 
> >""The <Device> contains two PCI base registers to allow for both greater 
> >flexibility in tightly constrained I/O space as well as the "on the fly" 
> >option to access the <Device> registers from either I/O or memory space. 
> >Both PCI base registers contained in the <Device> will accept the value 
> >of "zero" as a valid and decodable address. This differs from the PCI 2.1 
> >specification, where a zero value being written to the PCI base register 
> >should disable the register space.
> 
>    I haven't found such words in PCI 2.1 -- it only said that 0 is not a 
> valid address (those words are gone from 2.2).

AFAIK, zero is a valid address for IO Port space on several architectures.
But PCI generic code should never use it. See usage of PCIBIOS_MIN_IO
and PCIBIOS_MIN_MEM in the various asm-*/pci.h files.


> ><Device> will continue to decode for 
> >register accesses using the value "zero" written to the PCI_BS register 
> >as the base address for decoding.""
> 
>    I'd say it's absolutely valid bahavior.
> 
> >which makes me suspect that a base address of zero really should mean
> >unassigned and is a way to disable base registers on a region by region
> >basis.
> 
>    AFAIR, there's never been a provision to enable/disable BARs on an 
> individual basis in PCI (except the expansion ROM BAR). The decoders are
> only controlled via 2 command register bits for I/O and memory space.

One can "disable" a BAR by pointing it at an address that is NOT routed
by the upstream bridge. Ie CPU physical addresses that can never reach
that secondary bus. But I'm not aware of any code to do that currently
and it certainly won't work with all "PCI-like" (think integrated south
bridges) devices. But it might be sufficient for some special need.

hth,
grant
