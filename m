From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: Re: [PATCH 02/73] [ide/ata]: add ATA_MWDMA3 and ATA_MWDMA4 masks
Date: Sat, 14 Mar 2009 20:30:30 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142025300.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142010100.59456@anduin.net> <49BC041B.4040700@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:61483 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbZCNTad convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:30:33 -0400
In-Reply-To: <49BC041B.4040700@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Sat, 14 Mar 2009, Jeff Garzik wrote:
> Erik Inge Bols=C3=B8 wrote:
> > diff --git a/include/linux/ata.h b/include/linux/ata.h
> > index 9a061ac..386eeac 100644
> > --- a/include/linux/ata.h
> > +++ b/include/linux/ata.h
> > @@ -117,6 +117,8 @@ enum {
> >  	ATA_MWDMA0		=3D (1 << 0),
> >  	ATA_MWDMA1		=3D ATA_MWDMA0 | (1 << 1),
> >  	ATA_MWDMA2		=3D ATA_MWDMA1 | (1 << 2),
> > +	ATA_MWDMA3		=3D ATA_MWDMA2 | (1 << 3),
> > +	ATA_MWDMA4		=3D ATA_MWDMA3 | (1 << 4),
>=20
> This patch should be patch #1, and all the driver changes should be r=
olled up
> into patch #2.
>=20
> It is the same logical change, and therefore should not be broken up =
into 73
> tiny patches.

=46air enough. Will quash together and redo, didn't think you liked pat=
ches=20
touching dozens of files at once. Back in a bit.

--
-erik	http://useofwords.blogspot.com/
