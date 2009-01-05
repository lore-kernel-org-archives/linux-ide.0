From: Karl Auerbach <karl@iwl.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 05 Jan 2009 15:23:16 -0800
Message-ID: <49629664.9050604@iwl.com>
References: <49615667.9020408@iwl.com> <20090105113642.19679726@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from puck.iwl.com ([64.62.206.91]:45449 "EHLO puck.iwl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbZAEXX0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2009 18:23:26 -0500
In-Reply-To: <20090105113642.19679726@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, karl@cavebear.com

Alan Cox wrote:
>> 2. The cs5535 ide driver doesn't seem to be able to recognize the
>> newer CS5536 controller for IDE.
> 
> Switch to libata as most distributions have already done and enable the
> pata_cs5536 driver, which is designed for this hardware.

Thanks for the suggestion - It made a *big* difference.

Here's a couple of timings (sequential reads from the CF) that show the difference in 
performance.  I didn't do writes because I'm never sure what various CF's do inside and 
don't have confidence that seemingly similar CF writes have consistent times.

Using the generic IDE driver:

[root@board-1 /root]# time dd if=/dev/hda2 of=/dev/null bs=512
3572352+0 records in
3572352+0 records out
real      16m 18.64s
user      0m 0.76s
sys       1m 28.08s

Using the PATA CS5536 driver:

[root@board-1 /root]# time dd if=/dev/sda2 of=/dev/null bs=512
3572352+0 records in
3572352+0 records out
real    1m 11.41s
user    0m 0.47s
sys     0m 3.56s

In other words, on sequential reads, I'm seeing a roughly 13x fold improvement in clock 
time and an 11x improvement in sys+user cpu.

[It also seemed to fix another weird thing that started with 2.6.28, the disappearance of 
the stdout from linuxrc and rc.sysinit - the kernel messages still hit the console but the 
stuff from those two startup scripts went into never never land (even though, as apparent 
from their side effects, they still executed properly.)]

I guess I now need to go through my system and make sure that any hard coded "hda" are 
changed to "sda".

As for the other issues mentioned during this very helpful discussion, of which I 
comprehended about 50%:

Do folks still want me to try that patch?  (Now that the problem I've been having seems 
fixed, and being lazy by nature, I'll do it if it is helpful but otherwise I'd prefer to 
skip it.)

As for the question of why I have the SD driver - The ALIX2 boards (which, by the way are 
Geode LX, not the older Geode) has USB and I want to sometimes plug external USB drives 
into 'em.  I thought that the SD driver is needed for that, am I in error?

By-the-way, I'm happy (modulo my previously mentioned lazy nature) to run tests on ALIX2 
and ALIX3 boards should anyone need it.

	Thanks,
		--karl--
		Karl Auerbach
		Santa Cruz, CA
		http://www.cavebear.com/




