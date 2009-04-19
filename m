From: Tejun Heo <tj@kernel.org>
Subject: Re: PMPs
Date: Sun, 19 Apr 2009 18:01:53 +0900
Message-ID: <49EAE881.9060901@kernel.org>
References: <alpine.DEB.1.10.0904012109180.28814@uplift.swm.pp.se> <49D4073C.4010101@kernel.org> <alpine.DEB.1.10.0904081958100.29570@uplift.swm.pp.se> <49E46997.2060302@kernel.org> <alpine.DEB.1.10.0904171929050.29570@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54452 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755568AbZDSJCA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Apr 2009 05:02:00 -0400
In-Reply-To: <alpine.DEB.1.10.0904171929050.29570@uplift.swm.pp.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: linux-ide@vger.kernel.org

Hello,

Mikael Abrahamsson wrote:
> I have posted a boot time dmesg at <http://swm.pp.se/dmesg090416.txt>
> 
> Executive summary of everything that follows below (my opinion of what
> is happening):
> 
> If a drive isn't present at boot time in a slot, it's somehow
> "uninitialised". Inserting a drive into a slot not populated before,
> doesn't get detected. If I leave the "undetected" drive, and unplug slot
> 0 drive and insert it again, it's now detected and hotplugging of that
> drive works again. I verified this behaviour with slot 2, 3 and 4 below:
> 
> So, summary of events (first references the above dmesg file):
> 
> At 54s I unplug port1, at 65s I unplug port0, at ~90s I insert same disk
> in port0, at around 120s I insert port1, nothing happens, I then remove
> port0 again, and re-insert it at ~150 or so.
> 
> Since I am a bit uncertain about the times above, I'll do it one more
> time and mark each event. State when beginning, both drives are seen.

You need to keep port0 occupied all the time and even then hotplug
sometimes doesn't work.  The firmware on those PMPs are quite flaky.
If cold plug works, it would probably be best to just leave it at
that.

Thanks.

-- 
tejun
