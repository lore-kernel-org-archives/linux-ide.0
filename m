From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_ali complains at boot
Date: Sat, 16 Dec 2006 22:19:07 +0000
Message-ID: <20061216221907.14096256@localhost.localdomain>
References: <20061216162216.GA28405@welho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49133 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422654AbWLPWKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 17:10:32 -0500
In-Reply-To: <20061216162216.GA28405@welho.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Taneli =?UTF-8?B?VsOkaMOka2FuZ2Fz?= <taneli.vahakangas@welho.com>
Cc: linux-ide@vger.kernel.org

On Sat, 16 Dec 2006 18:22:16 +0200
Taneli V=C3=A4h=C3=A4kangas  <taneli.vahakangas@welho.com> wrote:

> Hello,
>=20
> I'm using pata_ali with ULi M1697, which has this:
> 00:16.0 IDE interface [0101]: ALi Corporation M5229 IDE [10b9:5229] (=
rev c7)
>=20
>=20
> IDE works with either pata_ali or alim15x3, but pata_ali complains
> at boot like this:
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> ata2.00: (BMDMA stat 0x24)
> ata2.00: cmd c8/00:58:30:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4=
5056 in
>          res 51/84:00:87:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus =
error)
> ata2: soft resetting port
> ata2.00: configured for UDMA/100
> ata2: EH complete
>=20
> This is repeated a few times, only with different UDMA levels.
> Is this normal? Or at least not dangerous ...

What rate does it stop at ?

