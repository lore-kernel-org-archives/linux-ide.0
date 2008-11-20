From: Tejun Heo <tj@kernel.org>
Subject: Re: Port multiplier resets
Date: Thu, 20 Nov 2008 11:27:17 +0900
Message-ID: <4924CB05.9060100@kernel.org>
References: <490DC300.40703@seiner.com> <49194B20.8000209@kernel.org> <49242D9E.4050500@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46691 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbYKTC1X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 21:27:23 -0500
In-Reply-To: <49242D9E.4050500@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
> Sorry for the delayed response.  I've installed another controller based
> on the SiI 3132 chipset.  The esata array is the same; I've simply moved
> the esata cables to the new controller.  My observations:
> 
> 1.  The JMicron 20360/20363 AHCI Controller (rev 03) controller is far,
> far slower.  hdparm clocks it at 20 mb/sec and a raid check takes about
> 15 hours.

Hmm... That's probably due to lack of FIS based switching support.
The hardware (20360/3) can't do it and ahci doesn't support it yet
either.  So, only commands to one drive can be in flight at any given
moment which is usually pretty bad for RAID.

> 2. The JMicron controller experiences the above errors.

Have you tried forcing the link speed?

> 3.  The Sil 3132 controller is faster.  hdparm says 110 mb/sec and a
> raid check takes about 5 hours.  This is confirmed by usage - I can
> stream 2 videos, record 2 videos, and commercial flag a video in myth
> with no visible stuttering.  The JMicron controller stutters even with a
> single video streaming and recording.

As said above, if you're running RAID on top of it, command based
switching will hurt bad.  And 110Mb/s is about the limit of sil3132.

> 4.  The Sil 3132 controller doesn't have any errors even under high load.
> 
> Google says the rev 3 version of the JMicron controller has these
> issues, and to turn off NCQ on it.  It also indicates that these
> problems should have been resolved in my kernel - version 2.6.27.4 - but
> apparently not.  :-(

Nah.. I'm not aware of any such problem and it will work fine w/o PMP.
JMB ahci's are actually pretty good.  Lack of FIS switching support
hurts when you use PMP tho.

> Is there a way to turn off NCQ on that controller without impacting the
> Sil 3132 controller?  Any other things to try?

You can do that with libata.force param but if you wanna put parallel
high load to the drives connected through PMP, no matter what you do,
the performance is gonna be bad if FIS switching is not supported.

-- 
tejun
