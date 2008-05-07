From: "Grant Grundler" <grundler@google.com>
Subject: Re: sata_mv errata function
Date: Wed, 7 May 2008 09:02:23 -0700
Message-ID: <da824cf30805070902p24aa2551ke998c9a38fcc963e@mail.gmail.com>
References: <3908ea640804210542s4e1e8403tfec4a99816b5d148@mail.gmail.com>
	 <BD261180E6D35F4D9D32F3E44FD3D9010CA88A84@EMPBEDEX.empirix.com>
	 <480C999D.9040202@rtr.ca>
	 <BD261180E6D35F4D9D32F3E44FD3D9010CA88B2A@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:40775 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbYEGQCd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 12:02:33 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id m47G2PSO022992
	for <linux-ide@vger.kernel.org>; Wed, 7 May 2008 17:02:26 +0100
Received: from wf-out-1314.google.com (wfd26.prod.google.com [10.142.4.26])
	by zps36.corp.google.com with ESMTP id m47G2OHf019650
	for <linux-ide@vger.kernel.org>; Wed, 7 May 2008 09:02:25 -0700
Received: by wf-out-1314.google.com with SMTP id 26so330662wfd.26
        for <linux-ide@vger.kernel.org>; Wed, 07 May 2008 09:02:24 -0700 (PDT)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010CA88B2A@EMPBEDEX.empirix.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Mon, Apr 21, 2008 at 6:51 AM, Morrison, Tom <tmorrison@empirix.com> wrote:
> Understood Mark - I wasn't expecting that this was complete! I think
>  we'll all clap very hard when you say - DONE!
>
>  Also, I've got to say, that you've been so helpful with my problems
>  with this chip in the past, I've really appreciated all your help!
>
>  As you saw in my post - we have a vibration problem - that seems to
>  cause some type of performance problem without any errors occurring.
>
>  Very weird! IFF we completely isolate the disk from the chassis -
>  the write performances goes up to what we expect ~75Mbs - but with it
>  in the box - based upon how much vibration (directly related to
>  heat - you can figure out what is causing vibration)

heat and vibration are separate issues. Please don't confuse them.
Each vendor responds to "overtemp" differently but they all result
in some sort of performance degradation since they (a) attempt
to validate data and (b) conserve power.

Drives report their internal temp via SMART data. See "ID" 194 as
documented in wikipedia:
    http://en.wikipedia.org/wiki/Self-Monitoring,_Analysis,_and_Reporting_Technology

Use smartctl (part of smartmontools package) to read that data.

> - the performance
>  goes down to the tube. We see NO errors at the sata level - and
>  using SMART/smartctl we do not seem to see any errors that point to
>  something we can fix easily...

 AFAIK, there is no access to the
accelerometers that are built in to "near line" and "enterprise"
disk drives.  SMART data _might_ tell you why. Check "reallocated
sectors count" and "Seek Error Count"  before and after your test runs.
They might correlate slightly with vibration but I've not heard any
vendor confirm that.

>  Our hardware engineer is looking into the affect of changing these
>  values:
>
>    SQ (squelch detector threshold) in PHY Mode 3 register.
>    TxPRE (transmitter pre-emphasis) in PHY Mode 2 register.
>    TXAmp (transmitter differential Amplitude) in PHY mode 2 register.

These have nothing to do with vibration.
This has to do with TX signal strength and RX filtering.
If the drives perform fine outside the disk enclosure while
sitting on foam, then this isn't the problem.

grant

>
>  I believe he has gotten some suggestions from the disk manufacturer and
>  Marvell - so we shall see what comes of it!
>
>  I'll keep you all updated...
>
>  Tom
>
>  Ps: this is also related to the Western Digital Green thread...:-)...
>
>
>
>
>  -----Original Message-----
>  From: Mark Lord [mailto:liml@rtr.ca]
>  Sent: Monday, April 21, 2008 9:42 AM
>  To: Morrison, Tom
>  Cc: Sylver Bruneau; linux-ide@vger.kernel.org; jeff@garzik.org
>  Subject: Re: sata_mv errata function
>
>  Morrison, Tom wrote:
>  > Interesting - I was just looking at this code this morning - and
>  > comparing with the reference driver Marvell has given us - this was
>  > one of the differences I was looking at because with this new driver
>  > and the old reference driver we were having performance problems
>  > due to vibrations or something that is causing the disk write
>  > performance
>  > to go very low (<5Mbytes/second)...
>  >
>  > I'd be very interested what Mark has to say about this - he just
>  > made some update to the driver - perhaps he has updated these
>  values...
>  ..
>
>  I've replied separately to Sylver's original post,
>  but just to keep me on all branches of this thread I'm
>  replying again now to you.  :)
>
>  Most errata fixes are on my menu here for the next few weeks,
>  so the ones pointed out by Sylver will get fixed as part of that.
>
>  As to the current state of sata_mv, it is *still* deservedly marked
>  as "HIGHLY EXPERIMENTAL".  I would not trust my own data to it yet.
>
>  In practice, I believe it is actually working well now,
>  on non-PCIX systems at least.
>
>  But, as you see, there are still missing workarounds for various errata,
>  and I am not yet totally finished with the error-handling logic.
>  That still needs just a little more TLC to be reliable/correct with NCQ.
>
>  So the "HIGHLY EXPERIMENTAL" label remains, for now, but I do plan to
>  strip it away entirely within a few weeks of now.
>
>  Cheers
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
