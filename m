From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Allow per driver taskfile filters
Date: Fri, 05 Nov 2004 23:45:33 +0000
Message-ID: <1099698331.5567.90.camel@localhost.localdomain>
References: <1099672568.5564.49.camel@localhost.localdomain>
	 <200411052311.45231.bzolnier@elka.pw.edu.pl>
	 <1099697126.5630.71.camel@localhost.localdomain>
	 <200411060142.02146.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:39109 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261295AbUKFAsZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:48:25 -0500
In-Reply-To: <200411060142.02146.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Sad, 2004-11-06 at 00:42, Bartlomiej Zolnierkiewicz wrote:
> * ATAPI is done and working (both PIO and DMA)
> * half of the blacklists is a crap (but I don't know which half :( )
> 
> BTW this is a _new_ driver so it is much easier to move

Its not on my schedule. Someone else can do it, but I'd suggest instead
that they spend their time helping Jeff get stuff like the Marvell
driver up and running first. Good to hear ATAPI now works with the SATA
stuff.

Alan

