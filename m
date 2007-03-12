From: "Davor Emard" <vordah@gmail.com>
Subject: Re: Marvell SATA AHCI 0x6141
Date: Mon, 12 Mar 2007 10:42:33 +0100
Message-ID: <cfc09f830703120242l757f0576sab366015f792be02@mail.gmail.com>
References: <20070309220200.GA17323@emard> <45F1E02C.2020203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:39807 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965389AbXCLJme (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 05:42:34 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1614555wxd
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 02:42:34 -0700 (PDT)
In-Reply-To: <45F1E02C.2020203@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

HI

For i386 it works (2.6.20.2).
(hotswap has bug,
disk has to first be inserted (nothing happens), then removed and
insterted again
then it's recognized)

However for amd64 (2.6.20.2) on the same hardware it doesn't work.
During boot the ata* messages appear on the ata4 controller where
the disk is connected but the kernel waits long with some
messages but in the end no disk is recognized. hoswap insert/remove
doesn't help either to detect the disk on amd64

I'd like to try this patch if it would fix amd64 but
How to download out the libata#mv-ahci patch?

Best regards, Davor


On 3/9/07, Jeff Garzik <jgarzik@pobox.com> wrote:
> Davor wrote:
> > HI
> >
> > I have onboard
> > 02:00.0 SATA controller: Marvell Technology Group Ltd. Unknown device 6141
> (rev 01)
> > 02:00.0 0106: 11ab:6141 (rev 01)
> >
> > and it's an AHCI compatible device so a simple patch makes it work
> > (patch agains linux-2.6.20.2)
> >
> > --- drivers/ata/ahci.c.orig	2007-03-09 21:58:26.000000000 +0100
> > +++ drivers/ata/ahci.c	2007-03-09 22:38:20.000000000 +0100
> > @@ -437,6 +437,9 @@ static const struct pci_device_id ahci_p
> >  	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
> >  	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
> >
> > +	/* Marvell */
> > +	{ PCI_VDEVICE(MARVELL, 0x6141), board_ahci },	/* 6141 */
>
> Yep, though you want the more-complete patch from libata-dev.git#mv-ahci
> or akpm's -mm.
>
> 	Jeff
>
>
>
>
>
