From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Which SATA Combos To Consider?
Date: Thu, 17 Feb 2005 15:55:21 -0500
Message-ID: <421504B9.5000202@pobox.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au>	 <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au>	 <20050216154033.I10699@florence.linkmargin.com>	 <4213CD9E.9040703@pobox.com>	 <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com>	 <20050216182040.L10699@florence.linkmargin.com>	 <421426DB.2000308@pobox.com>	 <20050217085934.M10699@florence.linkmargin.com>	 <4214ECE9.7070502@pobox.com> <1108669364.3604.80.camel@vom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51657 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262294AbVBQUzi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 15:55:38 -0500
In-Reply-To: <1108669364.3604.80.camel@vom>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Danny Cox <Danny.Cox@ECWeb.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Linux IDE List <linux-ide@vger.kernel.org>

Danny Cox wrote:
> 	I've been mostly lurking here for awhile now, just seeing how things
> are going.  I've seen various drives on a blacklist, and various
> controllers that do this or that well, but have problems doing foo.
> There also seem to have been a Strange Interaction as well, but that's a
> fuzzy memory at best.
> 
> 	So, my question is: if YOU were to purchase an SATA setup brand new,
> what would you specify?  Which drives, motherboards, and PCI cards would
> you recommend that just work?
> 
> 	I don't even mean "work like a Mercedes", by which I mean almost
> perfection.  I mean like a Chevy.  I don't mind a little tinkering to
> get it right, but I want my disk subsystem to be solid thereafter!  I've
> got important stuff here!  Like my wife's backup; NEVER lose your wife's
> backup (shudder)!
> 
> 	If SATA isn't ready for consumerdom, I'd like to know that too.  This
> just isn't for Jeff and Bart either.  I'd like to hear success stories
> from those whose systems just hum along all the time!

In terms of hardware, AHCI (from Intel/SiS/ULi/others) and Silicon Image 
3124 are the best of the current generation of "FIS-based" SATA-II 
controllers.  With these controllers, ATA controllers are __finally__ as 
efficient as SCSI controllers have been for years.

For SATA-I controllers, I tend to feel that the Promise SATA cards 
driven by the sata_promise driver are decent.

The rest of the SATA-I controllers all pretty much look the same, 
hardware-wise:  Decade-old PATA controller interface with PCI 
extensions, with further SATA extensions (SATA phy registers).

Of these, the only thing that really distinguishes the controllers are 
(a) MMIO register access, or not, and (b) SATA phy access.  Silicon 
Image 311x, nVidia, ServerWorks non-QDMA, and Vitesse chips do MMIO and 
offer sata phy access.

The only real combination to avoid is Silicon Image 311x + Seagate. 
311x is fine with other drives, and Seagate drives are fine with other 
controllers.

	Jeff


