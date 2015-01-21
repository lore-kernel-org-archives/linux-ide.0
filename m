From: Gene Heskett <gheskett@wdtv.com>
Subject: Re: 64 bit kernel won't mount /
Date: Wed, 21 Jan 2015 14:21:35 -0500
Message-ID: <201501211421.35532.gheskett@wdtv.com>
References: <201501191145.41492.gheskett@wdtv.com> <20150121172326.040dd702@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wdtv.com ([66.118.69.84]:34092 "EHLO mail.wdtv.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbbAUTVh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jan 2015 14:21:37 -0500
In-Reply-To: <20150121172326.040dd702@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Wednesday 21 January 2015 12:23:26 One Thousand Gnomes did opine
And Gene did reply:
> On Mon, 19 Jan 2015 11:45:41 -0500
> 
> Gene Heskett <gheskett@wdtv.com> wrote:
> > Greetings;
> > 
> > Amd Phenom, 8Gb of dram on an Asus M2N-SLI Deluxe board.  So old USB3
> > isn't.
> > 
> > Ubuntu 10.04.4 LTS 32 bit server install here.  A recent experiment
> > with a
> 
> Then you want to ask Ubuntu lists, nobody here can remember that far
> back 8) or did you mean 14.04 ?

Nope, stuck on the 10.04.4 release as yet as we haven't managed to 
successfully build an RTAI enabled kernel for wheezy or any of the other 
LTS distros like Mint 17.

We are running computer numerically controlled software, known as LinuxCNC 
on these machines as they demand an IRQ latency of less than 20 
microseconds when you are generating the step and dir pulses with 
software.  Even a 20% wobble in this timing destroys the stay locked 
torque of a stepper motor.

> > I have been reading up on man fstab, but it has not solved my problem
> > of the boot waiting, sometimes for 30 seconds, for the drive to be
> > mounted at / to appear.  There is no disk activity during this wait
> > period, and it does not always do it when booting a 32 bit PAE
> > kernel.
> 
> 30 seconds is about the timeout for the case when there appears to be a
> drive but probing it gets no results.

I've waited 10 minutes or more.  No biscuit.

I am convinced ATM that this boot stall is an artifact of the fact that 
none of the linux installers used, knows a thing about 4k/sector disks, 
and that somehow in my configuring a .config, I have crippled the kernels 
ability to deal with a miss-aligned disk partition, and none of the 
installers is smart enough to align its partitions.  The net results of 
course are 15M/sec write speeds on a disk that can do 120M/sec when it 
does work. But first, it has to boot.
 
> > Fdisk complains that there are 3503 unallocated 512 byte sectors
> > after partition 1 on the disk, but its been doing that for 3 or 4
> > years.
> 
> Doesn't matter.

I didn't think so.  But fdisk still complains about the miss-alignment if 
it exists. This disk is pure 512 byte sectors=no problem.

> Alan

Thanks Alan.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
US V Castleman, SCOTUS, Mar 2014 is grounds for Impeaching SCOTUS
