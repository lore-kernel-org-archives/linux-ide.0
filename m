From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Tue, 8 May 2007 15:51:19 +0100
Message-ID: <20070508155119.4207bbc6@the-village.bc.nu>
References: <46362672.7080103@gmx.net>
	<4636DCA9.9050803@gmail.com>
	<4636FBB7.3030605@gmx.net>
	<463AE631.9030701@gmail.com>
	<463B7903.4070206@gmx.net>
	<463EE239.8060709@gmail.com>
	<463F634E.2070103@gmx.net>
	<46408C4B.8020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56219 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S968087AbXEHOrK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 10:47:10 -0400
In-Reply-To: <46408C4B.8020401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Daniel Beichl <daniel_beichl@gmx.net>, linux-ide@vger.kernel.org

> > A thing that crossed my mind was a timing issue. Perhaps the dmaing of <
> > 60 bytes is that
> > fast that the interrupt that causes it is not yet handled correctly. But
> > this is just a very wild guess.
> 
> I don't think that can happen.  Controllers are required to queue
> interrupt till FIFO is flushed.  Can you post dmesg after such errors?

Random finger in the air guess - the FIFO on the SIL DMA engine is 64
bytes long ? Perhaps this is something Jeff can query with his contacts
at Silicon Image ?

Alan
