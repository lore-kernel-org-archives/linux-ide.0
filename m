From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Sat, 03 Feb 2007 13:31:20 +0900
Message-ID: <45C41018.1010509@gmail.com>
References: <20070202063748.GC1625@htj.dyndns.org>	<45C33BCF.2040506@emc.com>	<45C354CF.1020500@gmail.com> <20070202153929.33f4a806@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:38637 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946305AbXBCEb0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 23:31:26 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1037828wxd
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 20:31:25 -0800 (PST)
In-Reply-To: <20070202153929.33f4a806@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

Alan wrote:
>> Hmm... I'm hearing different stories here.  Some say 7sec is good enough
>> and the supporting argument that the other os is using 7 sec timeout is
>> pretty convincing.
> 
> Firstly what is your goal ?

Reducing timeout.  Timeouts occur much more frequently with SATA than
PATA.  Reducing timeout generally helps making the system more usable
and it also helps a lot if PMP is attached.  Many drives share a port
and certain PHY events make PMP lock up (at least current generation of
them).  This affects all devices attached to the PMP and with all the
extra links PHY events are much more likely, so it's pretty important to
be able to recover fast.

>> After command timeout, EH will kick in, reset and revalidate then return
>> the control to SCSI HLD, sd in this case which will retry the command
>> several times.  Would the reset make the drive to exit recovery mode
>> such that it has to start all over again when the command is retried?
>> Or does the drive stop responding to resets while in recovery mode?  The
>> latter would be fine.  libata gives and will continue to give more than
>> 30 secs for drive to respond to reset.
>>
>> Ideas?
> 
> Some thinking based on discussion so far:
> 
> Give it 7 seconds for a command to complete. At that point you need to
> have a chat with the drive since its probably gone AWOL. If you get an
> error within 7 seconds then its different.
> 
> For a reported error within 7 seconds (CRC excepted)
> 	 do fast error cleanup (not a reset) when we can
> 	 if need be reset

We're already doing the above.  On device errors, we just revalidate the
device.

> On the first media error/timeout , retry the command but with the segment
> list inverted

That certainly sounds interesting.

> On the second reset retry each block individually
>
> User specified time (allowing for recovery/queueing time) later, if we
> haven't got the drive back running then give up on those blocks.
> 
> The reason I suggest issuing the segment list inverted is that its
> statistically likely we only hit one bad area. It's also likey that bad
> area is adjacent blocks (it might not be for some failures I grant). So
> if we retry from the other end of the list we have a good chance that a
> typical list of blocks (say 1-4, 300-305, 380-383, 440-456, 511, 535)
> that blows up in the middle somewhere is going to run through the other
> good segments and get them on disk or off disk and stuff up and going
> again before stalling at the other end of the faulty area.

Yeap, that makes a lot of sense.  I think we need to trade off here.
How much recovery time and code are we gonna spend on recovering media
errors?  After certain point, it doesn't make sense.  Stalling disk
access for minutes to single out a few bad blocks in 4.7G dvd iso
doesn't really do any good.

Another thing to consider is that, IIRC, blk layer handles errors
bio-by-bio basis.  It doesn't matter whether one block failed or all of
them failed, any failure in a bio makes the whole bio marked bad, so
investing a lot of effort at SCSI/libata layer to find out exactly which
blocks fail is rather fruitless.

So, I agree with Mark here.  We should retry and fail bio-by-bio.  The
end effect wouldn't be much worse than block-by-block while taking much
less time.

-- 
tejun
