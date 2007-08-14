From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Still having problems with sata_promise on all late kernels -
 shutdown too
Date: Tue, 14 Aug 2007 08:37:03 +0400
Message-ID: <46C1316F.4010906@wasp.net.au>
References: <46C11BBE.6010802@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:38430 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396AbXHNEhL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Aug 2007 00:37:11 -0400
In-Reply-To: <46C11BBE.6010802@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Brad Campbell wrote:
> G'day all,
> 
> This has been happening on a lightly loaded box for a while now. I have 
> posted about it before.
> The issue is now I've upgraded 3 drives from 250GB Maxtors to 750GB 
> WD's, it's just getting worse, particularly when the drives are loaded. 
>

Oh, I forgot, I still have the problem where I can't shut the box down. The SCSI layer tries to sync 
cache on the drives, the 1st one errors out, and when the controller tries a hard reset on the port 
the box locks hard requiring a hard poweroff or a hard reset. (No serial console, sysrq, NMI oopser 
or anything else works)

I have 2 boxes with sata_promise controllers and they both do this. Not surprising given they are 
both running late kernels (> 2.6.20) and both have almost exactly the same hardware in them.

http://www.fnarfbargle.com/CIMG1029.JPG (I have posted this screen shot previously. It's still doing 
exactly the same thing on both boxes).

I've played with options to halt and all the other things I can think of. I just can't get it to 
shut down cleanly and all 15 drives go *clunk* when I have to hard power off the box. Normally this 
is not an issue as it happens once or twice a year at most, but recently I've been doing some server 
room reconfiguration and have had to do a number of power cycles. Nothing like 30 drives across 2 
machines going *clunk* to make your stomach turn.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
