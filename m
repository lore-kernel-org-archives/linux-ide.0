From: Ryan Bourgeois <rgb005@latech.edu>
Subject: Re: Which SATA Combos To Consider?
Date: Thu, 17 Feb 2005 18:25:26 -0600
Message-ID: <421535F6.80609@latech.edu>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au>	 <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au>	 <20050216154033.I10699@florence.linkmargin.com>	 <4213CD9E.9040703@pobox.com>	 <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com>	 <20050216182040.L10699@florence.linkmargin.com>	 <421426DB.2000308@pobox.com>	 <20050217085934.M10699@florence.linkmargin.com>	 <4214ECE9.7070502@pobox.com> <1108669364.3604.80.camel@vom>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from selene.LaTech.edu ([138.47.18.25]:24782 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S261261AbVBRA33 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2005 19:29:29 -0500
In-Reply-To: <1108669364.3604.80.camel@vom>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Danny Cox <Danny.Cox@ECWeb.com>
Cc: Linux IDE List <linux-ide@vger.kernel.org>

Danny Cox wrote:

>	I've been mostly lurking here for awhile now, just seeing how things
>are going.  I've seen various drives on a blacklist, and various
>controllers that do this or that well, but have problems doing foo.
>There also seem to have been a Strange Interaction as well, but that's a
>fuzzy memory at best.
>
>	So, my question is: if YOU were to purchase an SATA setup brand new,
>what would you specify?  Which drives, motherboards, and PCI cards would
>you recommend that just work?
>
>	I don't even mean "work like a Mercedes", by which I mean almost
>perfection.  I mean like a Chevy.  I don't mind a little tinkering to
>get it right, but I want my disk subsystem to be solid thereafter!  I've
>got important stuff here!  Like my wife's backup; NEVER lose your wife's
>backup (shudder)!
>
>	If SATA isn't ready for consumerdom, I'd like to know that too.  This
>just isn't for Jeff and Bart either.  I'd like to hear success stories
>from those whose systems just hum along all the time!
>
>	Thanks in advance!
>
>  
>
On my file server I run the Highpoint RocketRAID 1640.  It's a software 
RAID five card.  Basically it's just a PCI card with two HPT374 chips 
each with two SATA plugs (a total of four plugs).  So it's a no frills 
PATA card with SATA converters onboard.  I run three Western Digital 
120gb SATA drives on it with a Linux Software RAID 5 array on them.  
Aside from the fact that it's a PATA card at heart (so it doesn't use 
libata), my only complaint is that it's slow.  It's stable as a rock, 
though, I've had no problems with the card or drives.

I have a Promise SX4 that I tried.  I had those same three drives 
connected to it, but I was having some problems with the array when I 
was using it.  It had a tendency to corrupt the filesystem, for some 
reason.  I was having other problems at the time, though, so it could be 
unrelated to the card I was using.  If I get time and money I may try 
and set up an array on the card for testing.

Anyways, out of personal preference, I go with Western Digital hard 
drives.  For SATA cards, the Promise TX cards seem pretty reliable.  I 
have an onboard TX2 on my main machine running a WD Raptor.  I've had 
absolutely no problems with it and libata.  Or in Windows, for that matter.

I haven't used any other cards or drives, so I cannot offer anything in 
that direction.

-Ryan Bourgeois


