From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.25: sata_sil freezes, hard resets port.
Date: Mon, 29 Sep 2008 11:59:38 +0900
Message-ID: <48E0449A.3040300@kernel.org>
References: <3ECBDC05781B3D48ABD520A01ABF2F9B20BA45E73B@SE-EX008.groupinfra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57999 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbYI2DBO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Sep 2008 23:01:14 -0400
In-Reply-To: <3ECBDC05781B3D48ABD520A01ABF2F9B20BA45E73B@SE-EX008.groupinfra.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Henry, Andrew" <andrew.henry@logica.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Henry.

Sorry about the late reply.  I was traveling for quite some time.

Henry, Andrew wrote:
> I tried the patch wd.debug.  I am sorry that it took so long.  I
> assume that this was to help the wake-up problem with the MyBook
> drives ( I have many problems).  I added this patch to 2.6.25.9 and
> ran the kernel and then started up my raid-1 array and did not use
> any cron scripts to keep the drives awake.  I left the drives
> inactive for 30 minutes and then tried to access them.  It seems ok.
> If this is what the patch was meant to fix, then it does seem to
> work.  I have only tested this one time though.

Can you please post kernel log with and without the patch?

> I have so many other issues that I have gone back over to USB2
> instead of using the sata_sil 3512 CardBus controller, because it
> seems to stink badly.
> 
> Other issues with 3512 controller:
> 
> 1. When I write to the array, the activity lights show burst
> activity, i.e. the LEDs are not on constantly, but burst visibly
> with gaps inbetween where there is no activity.  They burst many
> times a second, but it's enough to see that its not going at max
> throughput.  If I read from the disk, then *sometimes* they light up
> constantly without going off.  Does this indicate in some way, that
> the controller is not being utilized to it's maximum capability?
> Seems like the controller is capable of higher throughput, but
> something in the way IO happens is hindering it.

Well, the only way you can tell is by actually measuring the
throughput.  How fast does it actually transfer?

> 2. A shutdown/startup or a reboot can kill the array, and then when
> it comes back up, only one disk is in the array and I have to re-add
> the other one causing a re-sync.  This never happens on USB2, only
> when using 3512 and sata_sil on CardBus controller.  One thing I
> notice is that when shutting down, after the the final KILL
> processes, I see a message saying something like "md is still
> active" right before the PC shuts down.  Is this why I am losing a
> disk, because md is not being shut down properly before a
> reset/poweroff?

Hmmm... I can't tell without looking at the log.  Can you please
attach log for the case where it loses one disk?

> 3. When the drives have gone to sleep and I try to access the
> mounted filesystem, or if I type "fdisk -l" after 10 minutes of not
> accessing the array, then the activity light on the CardBus
> controller lights up and does not go out for 1 minute.  Fdisk -l
> does not report back until after the activity light has gone off.
> The same thing happens when udev starts when booting the system.

Does the kernel complains about anything during that 1 minute?  Sounds
like there are command timeouts there.

> 4. If I eject the CardBus controller, after havin unmounted the raid
> filesystem and having stopped md, then I get a console message
> saying something along the lines of: **DANGER** power could not be
> stopped [when ejecting the controller card].  Sounds serious.
> Possible that I am damaging the controller when I do this.

I don't have much idea about that.  Can you please report this to
linux-pcmcia@lists.infradead.org and cc linux-ide and me?

> 5. IO times are very poor using eSATA CardBus 3512.  I get 15MB/s vs
> 35MB/s on USB2 (reads using /usr/bin/time and dd where if is the
> device and of is /dev/null.  Seems like either the 3512 controller
> card I have is just crap, and/or there are serious problems with the
> sata_sil driver when used in combination with a CardBus controller
> (anyone else out there with a CardBus?)  Maybe the issues do not
> manifest themselves as much on PCI controllers?  I am trying to
> source a CardBus controller at the moment that uses sata_sil24
> instead.

Hmmm...  I also have a 3512 cardbus controller and it works just fine.
Again, does the kernel complain about anything?  15MB/s is way too
slow.  What does "hdparm -t" on the drive report?

Thanks.

-- 
tejun
