From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: [PATCH] Fix sata_sil compilation error with libata debug enabled (2.6.29-rcX)
Date: Tue, 3 Feb 2009 14:01:28 +0200
Message-ID: <20090203120128.GT15052@edu.joroinen.fi>
References: <20090202194714.GN15052@edu.joroinen.fi> <4987BC43.3040400@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754075AbZBCMBk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4987BC43.3040400@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 02, 2009 at 10:38:43PM -0500, Jeff Garzik wrote:
> Pasi K=E4rkk=E4inen wrote:
> >Hello!
> >
> >I tried compiling 2.6.29-rc1 and 2.6.29-rc3 with libata debugging en=
abled
> >and got the following error:
> >
> >  CC [M]  drivers/ata/sata_sil.o
> >drivers/ata/sata_sil.c: In function 'sil_fill_sg':
> >drivers/ata/sata_sil.c:327: error: 'pi' undeclared (first use in thi=
s=20
> >function)
> >drivers/ata/sata_sil.c:327: error: (Each undeclared identifier is re=
ported=20
> >only once
> >drivers/ata/sata_sil.c:327: error: for each function it appears in.)
> >make[2]: *** [drivers/ata/sata_sil.o] Error 1
> >make[1]: *** [drivers/ata] Error 2
> >make: *** [drivers] Error 2
> >
> >include/linux/libata.h has the following enabled:
> >
> >#define ATA_DEBUG
> >#define ATA_VERBOSE_DEBUG
> >#define ATA_IRQ_TRAP
> >
> >The attached patch fixes the compilation.. I'm not sure if it's the =
correct
> >fix, but looking at the code it seems correct.. or at least makes th=
e
> >code compile for me :)
>=20
> applied
>=20

Great, thanks!

-- Pasi
