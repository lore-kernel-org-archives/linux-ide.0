From: Luke Ross <luke@lukeross.name>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement
	ATAPI_HORKAGE_NOPIO and apply it to GGW-H10N
Date: Tue, 17 Jun 2008 05:54:39 -0400
Message-ID: <20080617095439.GA9359@lukeross.name>
References: <4857313A.1000405@kernel.org> <48573174.9050103@kernel.org> <20080617094354.338e186b@lxorguk.ukuu.org.uk> <48578080.5030605@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ziller.vpsland.com ([64.22.91.115]:37896 "EHLO
	ziller.vpsland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbYFQK3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2008 06:29:33 -0400
In-Reply-To: <48578080.5030605@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

On Tue, Jun 17, 2008 at 06:14:40PM +0900, Tejun Heo wrote:
> Alan Cox wrote:
> > On Tue, 17 Jun 2008 12:37:24 +0900
> > Tejun Heo <tj@kernel.org> wrote:
> > 
> >> LG blueray drive GGW-H10N can't do ATAPI PIO.  Implement
> >> ATAPI_HORKAGE_NOPIO and apply it to the drive.  If the horkage is
> >> active, atapi_check_dma() always returns 0 and warns if the controller
> >> needs ATAPI PIO for certain commands.
> > 
> > This all seems wildly improbable as a drive with such a bug would not
> > appear to be going to work in Windows. I'd like to know more and see more
> > than one bug report for that drive before it goes in
> > 
> > You might even be looking at a single drive with a one off wiring flaw or
> > chip fault at this point.
> 
> I thought it was improbable too but it's a brand new relatively cheap
> blueray writer so it's quite possible that they screwed up the firmware
> on this one as are often the cases for first gen devices.
> 
> Relatively cheap it may be, it's still around $300, so I don't think
> I'll get one for testing.  The high price could probably explain low
> error report rate.
> 
> Luke, what happens if you use the drive on windows?  Does it just work?

Sorry, I've a Windows-free household and the machines a self-build so 
doesn't come with a license. I'll see if I can find a solution but it 
may take a little while.

It could be a drive fault or it could be a funky issue with the
drive/controller combination. nvidia claimed they weren't aware of any
problems with the device on the nForce chipset (LG didn't bother
responding to my email). It is LG's first Blu-Ray/HD-DVD combo drive and
I did buy it shortly after UK release so it could be an early build.
I've run it with firmwares 1.01 to 1.04.

Originally the drive was bought for a different PC with a Silicon Image
3114 controller. The drive worked fine with this (sata_sil). Then I
changed to the nForce motherboard and it never worked with the mobo
(AHCI driver/AHCI mode in BIOS). However it does work on a Silicon Image
3512 PCI card (sata_sil again) in the same machine, and a Lite-On DVD
rewriter works on the nForce SATA just fine (ahci).

To muddy the waters further the LG drive on the nForce motherboard works
fine for reading. It'll even write a Blu-Ray disc happily*. It just
won't accept commands like "wodim -toc", "wodim <filename>", "growisofs
-Z" without Tejun's patch.

Luke

* I use the term loosely, it's a bit sulky about BD-R media.
-- 
``Doing linear scans over an associative array is like trying to club
  someone to death with a loaded Uzi.'' -- Larry Wall
