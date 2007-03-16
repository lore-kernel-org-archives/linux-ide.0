From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Add suport for Marvell 88SE6121 in ahci
Date: Fri, 16 Mar 2007 15:21:29 +0100
Message-ID: <200703161521.29461.jareguero@telefonica.net>
References: <200701311504.40277.jareguero@telefonica.net> <45C0AFB6.5010907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.telefonica.net ([213.4.149.66]:14445 "EHLO
	ctsmtpout4.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964917AbXCPOVm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:21:42 -0400
In-Reply-To: <45C0AFB6.5010907@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

El Mi=E9rcoles, 31 de Enero de 2007, Jeff Garzik escribi=F3:
> Jose Alberto Reguero wrote:
> > This work for kernel 2.6.20-rc6
> >
> > First apply this patch:
> >
> > http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D116986924301674&w=3D=
2
> >
> > Then apply the patch attached.
> >
> > Comments:
> >
> > The Marvell 88SE6121 has three ports (0,1,2). The PATA port is port=
 2.
> > (PATA port for 6141 is port 4). In M2V Motherboard(Marvell 88SE6121=
)
> > there is only two SATA ports, one of them is external SATA. This tw=
o
> > ports work well with this patch.
> >
> > With this part:
> >
> > <       if (pci_enable_msi(pdev) =3D=3D 0)
> > ---
> >
> >>       if ((pdev->vendor !=3D PCI_VENDOR_ID_MARVELL) &&
> >> (pci_enable_msi(pdev)
> >
> > =3D=3D 0))
> >
> > you don't need to disable MSI in kernel.
> > MMCONFIG is disabled at startup in M2V.
> >
> > dmesg:
> > ........
> > PCI: Not using MMCONFIG.
>
> Very useful data points, thanks!
>
> For the future, please make sure to create patches using "diff -u",
> otherwise the patches are very difficult to read and apply.
>
> I've attached your patch as a "diff -u" patch so that others can chec=
k
> it out.
>
> 	Jeff

I found that the driver work well for Marvel 6121 without the flag=20
ATA_FLAG_SKIP_D2H_BSY.
What is the meaning of this flag?

Jose Alberto
