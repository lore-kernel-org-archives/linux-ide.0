From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_via oops on copying files?
Date: Wed, 20 May 2009 01:04:44 +0100
Message-ID: <20090520010444.4f6f378a@lxorguk.ukuu.org.uk>
References: <20090519091655.c0bed8b1fc13fcbc567bd8d4c339afd4.8d107e4704.wbe@email.secureserver.net>
	<20090519211052.55d01236@lxorguk.ukuu.org.uk>
	<200905192235.56916.albert@miraveo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54054 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754026AbZETADz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 20:03:55 -0400
In-Reply-To: <200905192235.56916.albert@miraveo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Astals Cid <albert@miraveo.com>
Cc: linux-ide@vger.kernel.org

> If i don't use the Compact Flash attached to the miniPCI->IDE->CF adapter it 
> works like a charm, it's only when i start writting (reading seems to work 
> fine) from the CF card that the kernel oopses, that's why i thought it might 
> be IDE/sata_via related.

Not unreasonable as an assumption - and it may be. It doesn't look like a
typical ATA bug, but its often hard to tell some hardware and software
bugs apart. Do you have any other DMA using miniPCI devices you could try
with the board (eg network devices) to see if it stays stable, or other
cards you could test the CF with ?
 
> Is it possible to work around IRQ problems? If so I guess this is not the 

irqpoll is there for that reason

> correct mailing list for that question anymore, so can you suggest a better 
> one? And if it's not possible i guess all i have left is bugging my hardware 
> manufacturer.

