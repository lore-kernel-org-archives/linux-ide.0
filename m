From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Implementing NVMHCI...
Date: Thu, 30 Apr 2009 19:36:38 -0400
Message-ID: <49FA3606.50808@garzik.org>
References: <20090412091228.GA29937@elte.hu> <Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net> <alpine.LFD.2.00.0904120820410.4583@localhost.localdomain> <6934efce0904141052j3d4f87cey9fc4b802303aa73b@mail.gmail.com> <1239777470.3390.164.camel@localhost.localdomain> <20090430225153.GA14784@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754609AbZD3XiI@vger.kernel.org>
In-Reply-To: <20090430225153.GA14784@logfs.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@logfs.org>
Cc: Artem Bityutskiy <dedekind@infradead.org>, Jared Hulbert <jaredeh@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Szabolcs Szakacsits <szaka@ntfs-3g.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-ide@vger.kernel.org

J=C3=B6rn Engel wrote:
> But like it or not, the market seems to be moving in that direction.
> Which means we will have "block devices" that have all the interfaces=
 of
> disks and behave much like flash - modulo the crap FTL.


One driving goal behind NVMHCI was to avoid disk-originated interfaces,=
=20
because they are not as well suited to flash storage.

The NVMHCI command set (distinguished from NVMHCI, the silicon) is=20
specifically targetted towards flash.

	Jeff
