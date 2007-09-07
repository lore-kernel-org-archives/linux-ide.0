From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT][PATCH v7] sata_mv: convert to new EH
Date: Fri, 07 Sep 2007 18:44:15 -0400
Message-ID: <46E1D43F.5020202@garzik.org>
References: <20070711200538.GA7374@havoc.gtf.org> <Pine.LNX.4.64.0707120212210.25837@twinlark.arctic.org> <46960225.5000502@garzik.org> <Pine.LNX.4.64.0707121140560.29365@twinlark.arctic.org> <loom.20070713T053938-434@post.gmane.org> <Pine.LNX.4.64.0709060858030.19388@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43036 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbXIGWoU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Sep 2007 18:44:20 -0400
In-Reply-To: <Pine.LNX.4.64.0709060858030.19388@twinlark.arctic.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dean gaudet <dean@arctic.org>
Cc: greg <greg-dated-1184731565.7e0579@lucidsolutions.co.nz>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

dean gaudet wrote:
> On Fri, 13 Jul 2007, greg wrote:
> 
>> dean gaudet <dean <at> arctic.org> writes:
>>> if you've got any other workload you'd like me to throw at it, 
>>> let me know.  
>> I've had a few problems with the driver in 2.6.20 (fc6xen x86_64). The machine 
>> tended to lock up after a random period of time (from a few minutes upwards), 
>> without any messages. Performing a smartctl on all the disks, or leaving smartd 
>> running, seemed to speed up the rate at which the crash occurred. What I found 
>> was that by moving the sata_mv device onto it's own bus (or a bus with two 
>> sata_mv devices), the crashes went away. Are you doing tests with the 
>> controller sharing a bus with other devices?
>>
>> Is there an merit to my observation that it might be an issue with devices 
>> sharing a PCI-X bus?
>>
>> Cards: Supermicro 5081 (SAT-MV8), Supermicro 6081 (SAT2-MV8), Highpoint 5081 
>> (RocketRaid 1820A v1.1). Motherboards: Tyan S2882, AMD 8131 chipset; IBM x206, 
>> Intel 6300ESB.
> 
> hmm!  i don't seem to have replied to this.
> 
> you know, i've seen this problem.  the first time it happened was with a 
> promise ultra tx/100 or tx/133 (on a dual k7 box, two controllers on the 
> same bus certainly)... a 5 minute cronjob logging HD temperatures via 
> smart would occasionally cause one of the disks to just disappear, return 
> errors on every request, and required a reboot to rediscover it.  
> eliminating the cronjob stopped the problem.

Promise cards, in particular, snoop the ATA commands and occasionally 
update registers and do other internal magic based upon those commands.

It is possible that SMART commands have the same requirements as SET 
FEATURES - XFER MODE: namely, all ports must be idle when the command is 
issued, not just the port in question.

	Jeff


