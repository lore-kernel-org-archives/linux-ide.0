From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: devres and requesting resources
Date: Fri, 29 Feb 2008 18:04:09 +0100
Message-ID: <200802291804.09412.bzolnier@gmail.com>
References: <47C75392.3020606@garzik.org> <47C7FA8B.7040306@gmail.com> <20080229140106.41ccc843@core>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760298AbYB2Qud@vger.kernel.org>
In-Reply-To: <20080229140106.41ccc843@core>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Friday 29 February 2008, Alan Cox wrote:
> > controller like ICH AHCIs.  ata_generic or ide generic might attach to a
> > controller which is already being driven by ahci under certain
> > configurations.
> 
> ata_generic will not nor ata_legacy both are much too smart for that. The
> legacy old IDE driver might but that probably isn't going to be fixed by
> devres and is trivial to fix in that driver (just steal the code from
> pata_legacy).

Yep, nice trick.

Since it is your idea/code could you please also fix ide_generic? :)

> > have different requirements can just open code pci_request_regions() and
> > pcim_iomap().  pcim_request_regions() should provide sensible default
> > behavior for common cases.
> 
> Which is arguably the current behaviour. Changing the behaviour and not
> the name is a really bad idea and will cause problems in future so don't
> do that.
> >
> > I think the best solution is to allow duplicate request regions for
> > managed devices which is okay as we know we're holding the resource and
> > let drivers which need to reserve all regions call pci_request_regions()
> > before calling pcim_request_regions().

This will work until code outside libata (i.e. IDE) starts using devres...

[ Incidentally, just yesterday I finished moving resource management handling
  to host drivers so it might as well happen. ]

> How about
> 
> 	pcim_request_all_regions()
> 
> for the behaviour Jeff wants, simple, direct, differently named and
> obvious what it does.

Seconded.

Thanks,
Bart
