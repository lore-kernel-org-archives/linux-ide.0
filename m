From: "Gutko" <gutko@poczta.onet.pl>
Subject: Re: Still no DMA on boot on S-ATA (Asus A7N8X-deluxe)
Date: Mon, 26 May 2003 14:22:37 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <00f001c32381$7eaf5900$928afea9@hal>
References: <Pine.LNX.4.44.0305251900170.1211-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.poczta.onet.pl ([213.180.130.30]:25499 "EHLO
	smtp2.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S264358AbTEZMJc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 May 2003 08:09:32 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Mark Hahn" <hahn@physics.mcmaster.ca>
To: "Gutko" <gutko@poczta.onet.pl>
Sent: Monday, May 26, 2003 1:02 AM
Subject: Re: Still no DMA on boot on S-ATA (Asus A7N8X-deluxe)


> > Why my hdd is always detected as PIO?
>
> I looked briefly at the driver a couple weeks ago -
> it appears to be deliberate, perhaps an attempt at conservativism.
>
> > I can enable udma5 using hdparm, later in rc.local but why it is not
working
> > on boot?
>
> does it work well?  I'm trying to evaluate a system with a SiI3112
> card and two seagate native-sata 120's.  things work OK under very
> light use, but quickly degenerate into the classic 'lost interrupt'...
>
yes i works good but i have onboard SIL3112A chipset. Im using it on udma5
about
3 months without any data corruption or errors (linux and windows).
but I have only one drive connected to sata. I've  heard people running raid
had
problems undrer windows too


