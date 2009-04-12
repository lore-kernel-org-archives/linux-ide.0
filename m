From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 21:59:00 -0400
Message-ID: <49E14AE4.7010505@garzik.org>
References: <49E0D47B.9070205@garzik.org> <20090411203246.513a0892@lxorguk.ukuu.org.uk> <alpine.LFD.2.00.0904111250370.4583@localhost.localdomain> <da824cf30904111449y5cb7c178ldf5291506ad6b393@mail.gmail.com> <20090412002527.631a5a89@lxorguk.ukuu.org.uk> <49E12D03.5070906@garzik.org> <alpine.LFD.2.00.0904111725570.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35160 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756878AbZDLB7O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Apr 2009 21:59:14 -0400
In-Reply-To: <alpine.LFD.2.00.0904111725570.4583@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>

Linus Torvalds wrote:
> And maybe I'm wrong, and NTFS works fine as-is with sectors >4kB. But let 
> me doubt that.

FWIW...  No clue about sector size, but NTFS cluster size (i.e. block 
size) goes up to 64k.  Compression is disabled after 4k.

	Jeff



