From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Fix sata_sil compilation error with libata debug enabled
 (2.6.29-rcX)
Date: Mon, 02 Feb 2009 22:38:43 -0500
Message-ID: <4987BC43.3040400@garzik.org>
References: <20090202194714.GN15052@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56795 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbZBCDir (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 22:38:47 -0500
In-Reply-To: <20090202194714.GN15052@edu.joroinen.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Pasi K=E4rkk=E4inen wrote:
> Hello!
>=20
> I tried compiling 2.6.29-rc1 and 2.6.29-rc3 with libata debugging ena=
bled
> and got the following error:
>=20
>   CC [M]  drivers/ata/sata_sil.o
> drivers/ata/sata_sil.c: In function 'sil_fill_sg':
> drivers/ata/sata_sil.c:327: error: 'pi' undeclared (first use in this=
 function)
> drivers/ata/sata_sil.c:327: error: (Each undeclared identifier is rep=
orted only once
> drivers/ata/sata_sil.c:327: error: for each function it appears in.)
> make[2]: *** [drivers/ata/sata_sil.o] Error 1
> make[1]: *** [drivers/ata] Error 2
> make: *** [drivers] Error 2
>=20
> include/linux/libata.h has the following enabled:
>=20
> #define ATA_DEBUG
> #define ATA_VERBOSE_DEBUG
> #define ATA_IRQ_TRAP
>=20
> The attached patch fixes the compilation.. I'm not sure if it's the c=
orrect
> fix, but looking at the code it seems correct.. or at least makes the
> code compile for me :)

applied


