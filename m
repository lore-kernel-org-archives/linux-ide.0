From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_fsl: fix build with ATA_VERBOSE_DEBUG
Date: Sun, 24 Feb 2008 00:30:11 -0500
Message-ID: <47C100E3.90108@garzik.org>
References: <20080222165425.GA27460@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36124 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875AbYBXFaO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 00:30:14 -0500
In-Reply-To: <20080222165425.GA27460@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Anton Vorontsov wrote:
> This patch fixes build and few warnings when ATA_VERBOSE_DEBUG
> is defined:
>=20
>   CC      drivers/ata/sata_fsl.o
> drivers/ata/sata_fsl.c: In function =E2=80=98sata_fsl_fill_sg=E2=80=99=
:
> drivers/ata/sata_fsl.c:338: warning: format =E2=80=98%x=E2=80=99 expe=
cts type =E2=80=98unsigned int=E2=80=99, but argument 3 has type =E2=80=
=98void *=E2=80=99
> drivers/ata/sata_fsl.c:338: warning: format =E2=80=98%x=E2=80=99 expe=
cts type =E2=80=98unsigned int=E2=80=99, but argument 4 has type =E2=80=
=98struct prde *=E2=80=99
> drivers/ata/sata_fsl.c: In function =E2=80=98sata_fsl_qc_issue=E2=80=99=
:
> drivers/ata/sata_fsl.c:459: error: =E2=80=98csr_base=E2=80=99 undecla=
red (first use in this function)
> drivers/ata/sata_fsl.c:459: error: (Each undeclared identifier is rep=
orted only once
> drivers/ata/sata_fsl.c:459: error: for each function it appears in.)
> drivers/ata/sata_fsl.c: In function =E2=80=98sata_fsl_freeze=E2=80=99=
:
> drivers/ata/sata_fsl.c:525: error: =E2=80=98csr_base=E2=80=99 undecla=
red (first use in this function)
> make[2]: *** [drivers/ata/sata_fsl.o] Error 1
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/ata/sata_fsl.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

applied


