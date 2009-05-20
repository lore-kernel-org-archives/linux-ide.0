From: "Albert Astals Cid" <albert@miraveo.com>
Subject: RE: =?UTF-8?Q?sata=5Fvia=20oops=20on=20copying=20files=3F?=
Date: Wed, 20 May 2009 03:00:45 -0700
Message-ID: <20090520030045.c0bed8b1fc13fcbc567bd8d4c339afd4.81d58aec96.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpoutwbe06.prod.mesa1.secureserver.net ([208.109.78.208]:58387
	"HELO smtpoutwbe06.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753760AbZETKAp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 06:00:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

> > If i don't use the Compact Flash attached to the miniPCI->IDE->CF adapter it 
> > works like a charm, it's only when i start writting (reading seems to work 
> > fine) from the CF card that the kernel oopses, that's why i thought it might 
> > be IDE/sata_via related.
> 
> Not unreasonable as an assumption - and it may be. It doesn't look like a
> typical ATA bug, but its often hard to tell some hardware and software
> bugs apart. Do you have any other DMA using miniPCI devices you could try
> with the board (eg network devices) to see if it stays stable, or other
> cards you could test the CF with ?

I have a miniPCI wireless card and it works ok, in the sense that i can
run a looped wget someUrl -O /dev/null for hours and no crash happens.

I've tested the CF card on a USB CF card reader and works too (other
computer though as the crashing one doesn't have USB ports).

Sadly i don't have more CF cards to test in the miniPCI->CF adapter.


>  
> > Is it possible to work around IRQ problems? If so I guess this is not the 
> 
> irqpoll is there for that reason

oh :-/

> 
> > correct mailing list for that question anymore, so can you suggest a better 
> > one? And if it's not possible i guess all i have left is bugging my hardware 
> > manufacturer.
 

Thanks,
  Albert


