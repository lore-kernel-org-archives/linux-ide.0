From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] sata_sx4: speed up ECC initialization
Date: Wed, 15 Apr 2009 10:02:46 +0200
Message-ID: <18917.38054.452176.604309@pilspetsen.it.uu.se>
References: <1239675982-32584-1-git-send-email-a.beregalov@gmail.com>
	<49E47A45.60902@garzik.org>
	<20090414200054.GB17134@orion>
	<49E4F047.3030500@garzik.org>
	<a4423d670904141351o72c4c0acka87a00360f1a53eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:33428 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbZDOIDz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Apr 2009 04:03:55 -0400
In-Reply-To: <a4423d670904141351o72c4c0acka87a00360f1a53eb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alexander Beregalov writes:
 > >> From: Alexander Beregalov <a.beregalov@gmail.com>
 > >> Date: Tue, 14 Apr 2009 23:55:52 +0400
 > >> Subject: [PATCH v2] sata_sx4: speed up ECC initialization
 > >>
 > >> ECC initialization takes too long. It writes zeroes by portions
 > >> of 4 byte, it takes more than 6 minutes on my machine to initiali=
ze
 > >> 512Mb ECC DIMM module. Change portion to 128Kb - it significantly
 > >> reduces initialization time.
 > >>
 > >> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
 > >> ---
 > >> =C2=A0drivers/ata/sata_sx4.c | =C2=A0 11 +++++++----
 > >> =C2=A01 files changed, 7 insertions(+), 4 deletions(-)
 > >
 > >
 > > Applied, to libata-dev.git#upstream
 > >
 > > Thanks!
 > >
 > > So... =C2=A0 the $64,000 question: =C2=A0does sata_sx4 work for yo=
u?
 >=20
 > No, not yet! :)
 > It works without disks ;)
 > It has found disks, but got timeout from them.
 > Some specific functions should be added to ops structure.
 >=20
 > At first I am trying to understand how to detect cable type.
 > I have two examples: from Promise partial source code and from FreeB=
SD.
 >=20
 > But PGuide says the chip automatically detects cable type.
 > Does it mean the driver should not do anything with it? - I will try=
 it.

No, it means you query the chip and report what it detected
to libata. The cable type affects speed settings.
