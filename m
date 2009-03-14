From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: Re: [PATCH 20/73] pata_efar: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:48:41 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142045250.61753@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142014190.59456@anduin.net> <20090314194522.2e8bbaa1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60681 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbZCNTso convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:48:44 -0400
In-Reply-To: <20090314194522.2e8bbaa1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Sat, 14 Mar 2009, Alan Cox wrote:
> On Sat, 14 Mar 2009 20:14:34 +0100 (CET)
> Erik Inge Bols=C3=B8 <knan-lkml@anduin.net> wrote:
>=20
> > No functional changes in this patch.
> > (Looks like it could use one, though.)
>=20
> Yep - wrong comment. The EFAR is a sort of clone of the PIIX and I co=
pied
> the comment while EFAR don't appear to have copied the limitation

Most suspicious thing I noted here was 0x0F =3D UDMA3, though. You prob=
ably=20
meant UDMA4?

Will send bugfix patches after I redo the pure conversion in two patche=
s,=20
like Jeff says.

--
-erik	http://useofwords.blogspot.com/
