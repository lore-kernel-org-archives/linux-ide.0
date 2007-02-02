From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 2 Feb 2007 15:39:29 +0000
Message-ID: <20070202153929.33f4a806@localhost.localdomain>
References: <20070202063748.GC1625@htj.dyndns.org>
	<45C33BCF.2040506@emc.com>
	<45C354CF.1020500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53873 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945911AbXBBP1K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 10:27:10 -0500
In-Reply-To: <45C354CF.1020500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> Hmm... I'm hearing different stories here.  Some say 7sec is good enough
> and the supporting argument that the other os is using 7 sec timeout is
> pretty convincing.

Firstly what is your goal ?

> 
> After command timeout, EH will kick in, reset and revalidate then return
> the control to SCSI HLD, sd in this case which will retry the command
> several times.  Would the reset make the drive to exit recovery mode
> such that it has to start all over again when the command is retried?
> Or does the drive stop responding to resets while in recovery mode?  The
> latter would be fine.  libata gives and will continue to give more than
> 30 secs for drive to respond to reset.
> 
> Ideas?

Some thinking based on discussion so far:

Give it 7 seconds for a command to complete. At that point you need to
have a chat with the drive since its probably gone AWOL. If you get an
error within 7 seconds then its different.

For a reported error within 7 seconds (CRC excepted)
	 do fast error cleanup (not a reset) when we can
	 if need be reset

On the first media error/timeout , retry the command but with the segment
list inverted
On the second reset retry each block individually

User specified time (allowing for recovery/queueing time) later, if we
haven't got the drive back running then give up on those blocks.

The reason I suggest issuing the segment list inverted is that its
statistically likely we only hit one bad area. It's also likey that bad
area is adjacent blocks (it might not be for some failures I grant). So
if we retry from the other end of the list we have a good chance that a
typical list of blocks (say 1-4, 300-305, 380-383, 440-456, 511, 535)
that blows up in the middle somewhere is going to run through the other
good segments and get them on disk or off disk and stuff up and going
again before stalling at the other end of the faulty area.

Alan
