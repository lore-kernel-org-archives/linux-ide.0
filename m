From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [parisc-linux] Re: a fix for NS87415 on C3K broken
Date: Wed, 22 Sep 2004 17:53:41 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040922165341.GN16153@parcelfarce.linux.theplanet.co.uk>
References: <200409170243.06449.bzolnier@elka.pw.edu.pl> <4150193600000506@mail-7-bnl.tiscali.it> <20040922163708.GD4766@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43941 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266249AbUIVQxn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Sep 2004 12:53:43 -0400
Content-Disposition: inline
In-Reply-To: <20040922163708.GD4766@colo.lackof.org>
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Joel Soete <soete.joel@tiscali.be>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, parisc-linux@parisc-linux.org

On Wed, Sep 22, 2004 at 10:37:08AM -0600, Grant Grundler wrote:
> On Wed, Sep 22, 2004 at 12:41:21PM +0200, Joel Soete wrote:
> > --- arch/parisc/kernel/pci.c.Orig	2004-09-22 09:47:02.000000000 +0200
> > +++ arch/parisc/kernel/pci.c	2004-09-22 11:26:02.104187784 +0200
> > +/* Used in drivers/pci/quirks.c */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, superio_fixup_pci);
> 
> Uhm...any clue why this works?
> The same entry in drivers/parisc/superio.c should work too but it doesn't.
> I'd rather fix that than just blindly moving it.

I think I know.  The define is:

#define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook) \
        static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_u
sed__   \
        __attribute__((__section__(".pci_fixup_header"))) = { \
                vendor, device, hook };

Now, that's dealt with by include/asm-generic/vmlinux.lds.h:

#define RODATA                                                          \
[...]
        /* PCI quirks */                                                \
        .pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {        \
                VMLINUX_SYMBOL(__start_pci_fixups_header) = .;          \
                *(.pci_fixup_header)                                    \
                VMLINUX_SYMBOL(__end_pci_fixups_header) = .;            \
                VMLINUX_SYMBOL(__start_pci_fixups_final) = .;           \
                *(.pci_fixup_final)                                     \
                VMLINUX_SYMBOL(__end_pci_fixups_final) = .;             \
        }                                                               \

which links them all together.  *However* ... maybe order is important.
There's a grotty-looking:
c03f347c d __pci_fixup_PCI_ANY_IDPCI_ANY_IDquirk_ide_bases

which may need to come after our superio quirk?  I'm just testing this theory now ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
