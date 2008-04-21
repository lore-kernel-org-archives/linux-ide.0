From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: sata_mv errata function
Date: Mon, 21 Apr 2008 09:51:39 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010CA88B2A@EMPBEDEX.empirix.com>
References: <3908ea640804210542s4e1e8403tfec4a99816b5d148@mail.gmail.com> <BD261180E6D35F4D9D32F3E44FD3D9010CA88A84@EMPBEDEX.empirix.com> <480C999D.9040202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:5230 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbYDUNvq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Apr 2008 09:51:46 -0400
Content-class: urn:content-classes:message
In-Reply-To: <480C999D.9040202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Understood Mark - I wasn't expecting that this was complete! I think
we'll all clap very hard when you say - DONE!

Also, I've got to say, that you've been so helpful with my problems
with this chip in the past, I've really appreciated all your help!

As you saw in my post - we have a vibration problem - that seems to
cause some type of performance problem without any errors occurring.

Very weird! IFF we completely isolate the disk from the chassis - 
the write performances goes up to what we expect ~75Mbs - but with it
in the box - based upon how much vibration (directly related to 
heat - you can figure out what is causing vibration) - the performance
goes down to the tube. We see NO errors at the sata level - and
using SMART/smartctl we do not seem to see any errors that point to
something we can fix easily...

Our hardware engineer is looking into the affect of changing these
values:

   SQ (squelch detector threshold) in PHY Mode 3 register.
   TxPRE (transmitter pre-emphasis) in PHY Mode 2 register.
   TXAmp (transmitter differential Amplitude) in PHY mode 2 register.

I believe he has gotten some suggestions from the disk manufacturer and
Marvell - so we shall see what comes of it!

I'll keep you all updated...

Tom

Ps: this is also related to the Western Digital Green thread...:-)...


-----Original Message-----
From: Mark Lord [mailto:liml@rtr.ca] 
Sent: Monday, April 21, 2008 9:42 AM
To: Morrison, Tom
Cc: Sylver Bruneau; linux-ide@vger.kernel.org; jeff@garzik.org
Subject: Re: sata_mv errata function

Morrison, Tom wrote:
> Interesting - I was just looking at this code this morning - and
> comparing with the reference driver Marvell has given us - this was
> one of the differences I was looking at because with this new driver
> and the old reference driver we were having performance problems
> due to vibrations or something that is causing the disk write
> performance
> to go very low (<5Mbytes/second)...
> 
> I'd be very interested what Mark has to say about this - he just 
> made some update to the driver - perhaps he has updated these
values...
..

I've replied separately to Sylver's original post,
but just to keep me on all branches of this thread I'm
replying again now to you.  :)

Most errata fixes are on my menu here for the next few weeks,
so the ones pointed out by Sylver will get fixed as part of that.

As to the current state of sata_mv, it is *still* deservedly marked
as "HIGHLY EXPERIMENTAL".  I would not trust my own data to it yet.

In practice, I believe it is actually working well now,
on non-PCIX systems at least.

But, as you see, there are still missing workarounds for various errata,
and I am not yet totally finished with the error-handling logic.
That still needs just a little more TLC to be reliable/correct with NCQ.

So the "HIGHLY EXPERIMENTAL" label remains, for now, but I do plan to 
strip it away entirely within a few weeks of now.

Cheers
