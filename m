From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 19:51:31 -0400
Message-ID: <49E12D03.5070906@garzik.org>
References: <49E0D47B.9070205@garzik.org>	<20090411203246.513a0892@lxorguk.ukuu.org.uk>	<alpine.LFD.2.00.0904111250370.4583@localhost.localdomain>	<da824cf30904111449y5cb7c178ldf5291506ad6b393@mail.gmail.com> <20090412002527.631a5a89@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43590 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbZDKXvo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Apr 2009 19:51:44 -0400
In-Reply-To: <20090412002527.631a5a89@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Grundler <grundler@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>

Alan Cox wrote:
>> We've abstract the DMA mapping/SG list handling enough that the
>> block size should make no more difference than it does for the
>> MTU size of a network.
> 
> You need to start managing groups of pages in the vm and keeping them
> together and writing them out together and paging them together even if
> one of them is dirty and the other isn't. You have to deal with cases
> where a process forks and the two pages are dirtied one in each but still
> have to be written together.
> 
> Alternatively you go for read-modify-write (nasty performance hit
> especially for RAID or a log structured fs).

Or just ignore the extra length, thereby excising the 'read-modify' 
step...  Total storage is halved or worse, but you don't take as much of 
a performance hit.

	Jeff



