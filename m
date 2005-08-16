From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Tue, 16 Aug 2005 14:40:29 +0100
Message-ID: <20050816134029.GA5113@parcelfarce.linux.theplanet.co.uk>
References: <200508111424.43150.bjorn.helgaas@hp.com> <1123836012.22460.16.camel@localhost.localdomain> <200508151507.22776.bjorn.helgaas@hp.com> <58cb370e050816023845b57a74@mail.gmail.com> <1124196958.17555.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1124196958.17555.8.camel@localhost.localdomain>
Sender: linux-ia64-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 16, 2005 at 01:55:58PM +0100, Alan Cox wrote:
> On Maw, 2005-08-16 at 11:38 +0200, Bartlomiej Zolnierkiewicz wrote:
> > * removing IDE_ARCH_OBSOLETE_INIT define has some implications,
> >   * non-functional ide-cs driver (but there is no PCMCIA on IA64?)
> 
> IA64 systems can support PCI->Cardbus/PCMCIA cards so they do actually
> need this support. They could also do with cardbus IDE support but that
> means a whole pile of patches still although the refcounting stuff means
> its a lot closer to doable now

Then IDE_ARCH_OBSOLETE_INIT needs to be added back for all other
architectures that support PCI too ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
