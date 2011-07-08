From: Tim Small <tim@seoss.co.uk>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Fri, 08 Jul 2011 10:53:01 +0100
Message-ID: <4E16D37D.1030701@seoss.co.uk>
References: <4DEE6831.9020501@seoss.co.uk> <20110609143755.GA2615@htj.dyndns.org> <4DF136FF.2010404@seoss.co.uk> <20110610102403.GE15235@htj.dyndns.org> <4DF249BB.3040808@seoss.co.uk> <4E14C6ED.5040208@buttersideup.com> <4E15A2F1.7080106@seoss.co.uk> <4E15FB4A.809@buttersideup.com> <4E15FD43.6030701@seoss.co.uk> <B9B10C29375C5B40A2D240808654F60E5EE470A72D@SC-VEXCH2.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([78.47.234.210]:43395 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1GHJxH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2011 05:53:07 -0400
In-Reply-To: <B9B10C29375C5B40A2D240808654F60E5EE470A72D@SC-VEXCH2.marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hubert Bailey <hbailey@marvell.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Larry Li <lil@marvell.com>

On 08/07/11 05:42, Hubert Bailey wrote:
> Tim,
>
> The 9125 is a simple controller without a internal processor.  The 9123 contains an internal processor to enhance RAID 0/1 operations.  If you are testing in a JBOD configuration you will not take advantage of the 9123 internal processor.

OK, that's fine.  I have a nice fast CPU in the system which runs the
Linux md code (which I can debug if necessary) with very high
throughput, and it even works across controller cards.  A JBOD is what I
want.

>   The internal processor can result in lower performance than the 9125.

It shouldn't result it complete read failures though, should it?  That's
what we are seeing on both the 9123, and the 9125 (although the 9123
seems to be worse).

Also 130M per second total throughput on a device which should have
around 500M per second throughput seems like very low performance to
me.  If the processor is capable of handling 350M/second+ throughput,
then that looks more like a performance bug with the PMP support to me?

>   However if you configure the drives in a RAID configuration using the 9123 RAID  utility you should see better performance than with 9125.
>   

The drives in the machine are using Linux's software RAID6 (26 drives in
the machine in total - multiple controllers).  The 9123-based cards were
selected because they were more readily available and cheaper.  Just
straight AHCI passthrough is all I want to work here, and the firmware
version installed on the 9123 cards I have doesn't support RAID AFAIK,
it just does plain AHCI.

And going back to the 9125 - the performance with that is unreliable
unless you turn off NCQ, and more seriously, sometimes reads are failed
entirely.  These are the 88SE9125 results again with 2.6.38 and the
default Linux NCQ depth of 31, whilst reading a single drive at a time
from behind a 3726 PMP:

 Timing buffered disk reads: 386 MB in  3.00 seconds = 128.59 MB/sec
 Timing buffered disk reads:  38 MB in  7.01 seconds =   5.42 MB/sec
 Timing buffered disk reads: read(2097152) returned 823296 bytes
BLKFLSBUF failed: No such device

^^ i.e. a read failure, see the previous emails for the associated
kernel error messages

 Timing buffered disk reads: 328 MB in  3.55 seconds =  92.29 MB/sec
 Timing buffered disk reads: 204 MB in  5.30 seconds =  38.48 MB/sec
 Timing buffered disk reads: 376 MB in  3.01 seconds = 124.78 MB/sec
 Timing buffered disk reads: 200 MB in  3.01 seconds =  66.53 MB/sec
 Timing buffered disk reads: 276 MB in  3.01 seconds =  91.68 MB/sec
 Timing buffered disk reads: 154 MB in  3.36 seconds =  45.81 MB/sec
 Timing buffered disk reads: 384 MB in  3.01 seconds = 127.45 MB/sec
 Timing buffered disk reads: 358 MB in  3.01 seconds = 119.03 MB/sec
 Timing buffered disk reads: 392 MB in  3.00 seconds = 130.65 MB/sec
 Timing buffered disk reads: 364 MB in  4.33 seconds =  84.11 MB/sec
 Timing buffered disk reads: 188 MB in  3.01 seconds =  62.44 MB/sec
 Timing buffered disk reads: 342 MB in  3.01 seconds = 113.47 MB/sec
 Timing buffered disk reads: 392 MB in  3.01 seconds = 130.39 MB/sec
 Timing buffered disk reads: 394 MB in  3.01 seconds = 130.76 MB/sec
 Timing buffered disk reads: 274 MB in  3.91 seconds =  70.16 MB/sec
 Timing buffered disk reads: 392 MB in  3.00 seconds = 130.50 MB/sec


Please could you acknowledge that there is actually a problem here?  I
don't know whether it's with the 88SE91xx controllers, or with the Linux
AHCI driver (or Linux PMP support), but this is clearly not correct
behaviour.  This fault doesn't appear when using a SiI3132, or an
88SX7042.  I don't currently have a different AHCI+FBS capable
controller to double-check against, but may be able to check against an
Intel one in a couple of weeks time.

Thanks,

Tim.
