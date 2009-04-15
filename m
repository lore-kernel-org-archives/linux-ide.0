From: Artem Bityutskiy <dedekind@infradead.org>
Subject: Re: Implementing NVMHCI...
Date: Wed, 15 Apr 2009 09:37:50 +0300
Message-ID: <1239777470.3390.164.camel@localhost.localdomain>
References: <20090412091228.GA29937@elte.hu>
	 <Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net>
	 <alpine.LFD.2.00.0904120820410.4583@localhost.localdomain>
	 <6934efce0904141052j3d4f87cey9fc4b802303aa73b@mail.gmail.com>
Reply-To: dedekind@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23495 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZDOGjf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Apr 2009 02:39:35 -0400
In-Reply-To: <6934efce0904141052j3d4f87cey9fc4b802303aa73b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jared Hulbert <jaredeh@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Szabolcs Szakacsits <szaka@ntfs-3g.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>, David Woodhouse <dwmw2@infradead.org>, =?ISO-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>

On Tue, 2009-04-14 at 10:52 -0700, Jared Hulbert wrote:
>         It really isn't worth it. It's much better for everybody to
>         just be aware
>         of the incredible level of pure suckage of a general-purpose
>         disk that has
>         hardware sectors >4kB. Just educate people that it's not good=
=2E
>         Avoid the
>         whole insane suckage early, rather than be disappointed in
>         hardware that
>         is total and utter CRAP and just causes untold problems.
>=20
> I don't disagree that >4KB DISKS are a bad idea. But I don't think
> that's what's going on here.  As I read it, NVMHCI would plug into th=
e
> MTD subsystem, not the block subsystem.
>=20
>=20
> NVMHCI, as far as I understand the spec, is not trying to be a
> general-purpose disk, it's for exposing more or less the raw NAND.  A=
s
> far as I can tell it's a DMA engine spec for large arrays of NAND.
> BTW, anybody actually seen a NVMHCI device or plan on making one?

I briefly glanced at the doc, and it does not look like this is an
interface to expose raw NAND. E.g., I could not find "erase" operation.
I could not find information about bad eraseblocks.

It looks like it is not about raw NANDs. May be about "managed" NANDs.

Also, the following sentences from the "Outside of Scope" sub-section
suggest I'm right:
"NVMHCI is also specified above any non-volatile memory management, lik=
e
wear leveling. Erases and other management tasks for NVM technologies
like NAND are abstracted.".

So it says NVMHCI is _above_ wear levelling, which means FTL would be
_inside_ the NVMHCI device, which is not about raw NAND.

But I may be wrong, I spent less than 10 minutes looking at the doc,
sorry.

--=20
Best regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

