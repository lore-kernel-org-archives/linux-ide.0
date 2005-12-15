From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA feature list available
Date: Thu, 15 Dec 2005 22:16:59 +0000
Message-ID: <1134685019.20495.0.camel@localhost.localdomain>
References: <43A1A37E.4070806@pobox.com>
	 <1134669106.12421.67.camel@localhost.localdomain>
	 <43A1AEA7.60101@seanodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:28627 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750986AbVLOWRB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Dec 2005 17:17:01 -0500
In-Reply-To: <43A1AEA7.60101@seanodes.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Velu Erwan <erwan@seanodes.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Iau, 2005-12-15 at 18:57 +0100, Velu Erwan wrote:
> Alan Cox a =C3=A9crit :
>=20
> >ATIIXP
> > =20
> >
> Did your patch includes a patch for ATIIXP to solve the troubles we=20
> tried to fix with bruno ?

No. I'd actually expect libata to handle that internally as its drive
level, but I'm not sure it does. Added to the 'to investigate' list.

