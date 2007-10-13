From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream 2/2] libata: track SLEEP state and issue SRST
 to wake it up
Date: Sat, 13 Oct 2007 22:55:36 +0900
Message-ID: <4710CE58.9060903@gmail.com>
References: <20071012115631.GA11510@htj.dyndns.org>	 <20071012115657.GB11510@htj.dyndns.org> <76366b180710122157s506fd467m10181ceca7badf6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:21417 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbXJMNzm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 09:55:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1328026wah
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 06:55:42 -0700 (PDT)
In-Reply-To: <76366b180710122157s506fd467m10181ceca7badf6f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Andrew Paprocki wrote:
> Tejun,
> 
> I'm able to break my system using this patch. I had a hunch this might
> be possible.. :) In short, if you issue a sleep command while the
> drive is already sleeping, it puts libata into an infinite loop
> resetting the port. I've illustrated the working test and the evil
> hunch below. The sleep command itself will need a short-circuit out of
> this logic in order to prevent this loop.

Heh... I guess you're much better a software engineer than I am.  Thanks
for finding it out.  It was stupid of me.  :-)

> Also, in the working case below the hddtemp command actually blocked
> until the drive was spun up before returning a valid temp. While
> testing, I was able to get hddtemp to trigger the drive wake-up when
> it was sleeping, but hddtemp then returned stating the drive was
> sleeping. Re-running hddtemp until the drive was fully spun up
> (another 5 seconds) kept returning that it was sleeping. I'll see if I
> can reproduce this reliably. Am I correct in assuming the process
> which triggers the wake-up should block?

Yeah, it should.  I'll test with hddtemp myself.

Jeff, please forget about this patchset.  I'll re-post updated version.

-- 
tejun
