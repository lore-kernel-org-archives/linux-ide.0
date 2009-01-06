From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Tue, 06 Jan 2009 15:58:37 +0300
Message-ID: <4963557D.1020504@ru.mvista.com>
References: <49615667.9020408@iwl.com> <20090105113642.19679726@lxorguk.ukuu.org.uk> <49629664.9050604@iwl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:21239 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751536AbZAFM6n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 07:58:43 -0500
In-Reply-To: <49629664.9050604@iwl.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karl Auerbach <karl@iwl.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, karl@cavebear.com

Hello.

Karl Auerbach wrote:

>>> 2. The cs5535 ide driver doesn't seem to be able to recognize the
>>> newer CS5536 controller for IDE.
>>
>> Switch to libata as most distributions have already done and enable the
>> pata_cs5536 driver, which is designed for this hardware.
>
> Thanks for the suggestion - It made a *big* difference.
>
> Here's a couple of timings (sequential reads from the CF) that show 
> the difference in performance.  I didn't do writes because I'm never 
> sure what various CF's do inside and don't have confidence that 
> seemingly similar CF writes have consistent times.
>
> Using the generic IDE driver:

   It was a total mistake from the very start that you used ide-generic 
driver and you should really have used ide-pci-generic.

> [root@board-1 /root]# time dd if=/dev/hda2 of=/dev/null bs=512
> 3572352+0 records in
> 3572352+0 records out
> real      16m 18.64s
> user      0m 0.76s
> sys       1m 28.08s
>
> Using the PATA CS5536 driver:
>
> [root@board-1 /root]# time dd if=/dev/sda2 of=/dev/null bs=512
> 3572352+0 records in
> 3572352+0 records out
> real    1m 11.41s
> user    0m 0.47s
> sys     0m 3.56s

   Hm, looks like your CF drive is rather advanced and might be 
supporting UltraDMA (and your CF slot supports DMA). Care to post the 
output of 'hdparm -i /dev/hda'?

> Do folks still want me to try that patch?  (Now that the problem I've 
> been having seems fixed, and being lazy by nature, I'll do it if it is 
> helpful but otherwise I'd prefer to skip it.)

   Of course, it'll be helpful.

> As for the question of why I have the SD driver - The ALIX2 boards 
> (which, by the way are Geode LX, not the older Geode)

   I didn't doubt it. CS5536 isn't used with LX it seems...

> has USB and I want to sometimes plug external USB drives into 'em.  I 
> thought that the SD driver is needed for that, am I in error?

   No. That explained it.

> By-the-way, I'm happy (modulo my previously mentioned lazy nature) to 
> run tests on ALIX2 and ALIX3 boards should anyone need it.

   Judging on what you have posted, IDE driver would not probably give 
any speed improvement, only soewhat lesser memory footprint...

MBR, Sergei


