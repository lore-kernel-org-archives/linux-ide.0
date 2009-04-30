From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: Implementing NVMHCI...
Date: Fri, 1 May 2009 00:51:53 +0200
Message-ID: <20090430225153.GA14784@logfs.org>
References: <20090412091228.GA29937@elte.hu> <Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net> <alpine.LFD.2.00.0904120820410.4583@localhost.localdomain> <6934efce0904141052j3d4f87cey9fc4b802303aa73b@mail.gmail.com> <1239777470.3390.164.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932135AbZD3Ww2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1239777470.3390.164.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Bityutskiy <dedekind@infradead.org>
Cc: Jared Hulbert <jaredeh@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Szabolcs Szakacsits <szaka@ntfs-3g.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-ide@vger.kernel.org

On Wed, 15 April 2009 09:37:50 +0300, Artem Bityutskiy wrote:
>=20
> I briefly glanced at the doc, and it does not look like this is an
> interface to expose raw NAND. E.g., I could not find "erase" operatio=
n.
> I could not find information about bad eraseblocks.
>=20
> It looks like it is not about raw NANDs. May be about "managed" NANDs=
=2E

I'm not sure whether your distinction is exactly valid anymore.  "raw
NAND" used to mean two things.  1) A single chip of silicon without
additional hardware.  2) NAND without FTL.

Traditionally the FTL was implemented either in software or in a
constroller chip.  So you could not get "cooked" flash as in FTL withou=
t
"cooked" flash as in extra hardware.  Today you can, which makes "raw
NAND" a less useful term.

And I'm not sure what to think about flash chips with the (likely
crappy) FTL inside either.  Not having to deal with bad blocks anymore
is a bliss.  Not having to deal with wear leveling anymore is a lie.
Not knowing whether errors occurred and whether uncorrected data was
left on the device or replaced with corrected data is a pain.

But like it or not, the market seems to be moving in that direction.
Which means we will have "block devices" that have all the interfaces o=
f
disks and behave much like flash - modulo the crap FTL.

J=C3=B6rn

--=20
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
