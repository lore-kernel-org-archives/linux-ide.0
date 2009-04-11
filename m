From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Implementing NVMHCI...
Date: Sun, 12 Apr 2009 00:25:27 +0100
Message-ID: <20090412002527.631a5a89@lxorguk.ukuu.org.uk>
References: <49E0D47B.9070205@garzik.org>
	<20090411203246.513a0892@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.00.0904111250370.4583@localhost.localdomain>
	<da824cf30904111449y5cb7c178ldf5291506ad6b393@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58217 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757997AbZDKX0Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Apr 2009 19:26:25 -0400
In-Reply-To: <da824cf30904111449y5cb7c178ldf5291506ad6b393@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>

> We've abstract the DMA mapping/SG list handling enough that the
> block size should make no more difference than it does for the
> MTU size of a network.

You need to start managing groups of pages in the vm and keeping them
together and writing them out together and paging them together even if
one of them is dirty and the other isn't. You have to deal with cases
where a process forks and the two pages are dirtied one in each but still
have to be written together.

Alternatively you go for read-modify-write (nasty performance hit
especially for RAID or a log structured fs).

Yes you can do it but it sure won't be pretty with a conventional fs.
Some of the log structured file systems have no problems with this and
some kinds of journalling can help but for a typical block file system
it'll suck.
