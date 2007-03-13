From: "Davor Emard" <vordah@gmail.com>
Subject: Re: Marvell SATA AHCI 0x6141
Date: Tue, 13 Mar 2007 01:05:12 +0100
Message-ID: <cfc09f830703121705qa819089x712124ebd7f83b17@mail.gmail.com>
References: <20070309220200.GA17323@emard> <45F1E02C.2020203@pobox.com>
	 <cfc09f830703120242l757f0576sab366015f792be02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:35253 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbXCMAFN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 20:05:13 -0400
Received: by an-out-0708.google.com with SMTP id b33so1661117ana
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 17:05:12 -0700 (PDT)
In-Reply-To: <cfc09f830703120242l757f0576sab366015f792be02@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

hi

I got it running on amd64 (with my minimalistic patch)
I checked out the 2.6.21-rc3-mm there's some marvell
related stuff but I think it's for a mixed marvell cards with
serail and parallel ata. Still this patch has chip id 0x6145
while my 0x6141 (it's serial ata only) has to be added
to get recognized by ahci.c


On 3/12/07, Davor Emard <vordah@gmail.com> wrote:
> HI
>
> For i386 it works (2.6.20.2).
> (hotswap has bug,
> disk has to first be inserted (nothing happens), then removed and
> insterted again
> then it's recognized)
>
> However for amd64 (2.6.20.2) on the same hardware it doesn't work.
> During boot the ata* messages appear on the ata4 controller where
> the disk is connected but the kernel waits long with some
> messages but in the end no disk is recognized. hoswap insert/remove
> doesn't help either to detect the disk on amd64
>
> I'd like to try this patch if it would fix amd64 but
> How to download out the libata#mv-ahci patch?
>
> Best regards, Davor
>
>
> On 3/9/07, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Davor wrote:
> > > HI
> > >
> > > I have onboard
> > > 02:00.0 SATA controller: Marvell Technology Group Ltd. Unknown device
> 6141
> > (rev 01)
> > > 02:00.0 0106: 11ab:6141 (rev 01)
> > >
> > > and it's an AHCI compatible device so a simple patch makes it work
> > > (patch agains linux-2.6.20.2)
> > >
> > > --- drivers/ata/ahci.c.orig	2007-03-09 21:58:26.000000000 +0100
> > > +++ drivers/ata/ahci.c	2007-03-09 22:38:20.000000000 +0100
> > > @@ -437,6 +437,9 @@ static const struct pci_device_id ahci_p
> > >  	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
> > >  	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
> > >
> > > +	/* Marvell */
> > > +	{ PCI_VDEVICE(MARVELL, 0x6141), board_ahci },	/* 6141 */
> >
> > Yep, though you want the more-complete patch from libata-dev.git#mv-ahci
> > or akpm's -mm.
> >
> > 	Jeff
> >
> >
> >
> >
> >
>
