From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Fri, 11 Jan 2008 16:54:12 -0500
Message-ID: <87f94c370801111354u17d216d0h9debfd7d5a7a335@mail.gmail.com>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
	 <20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111149x15afd429sf48ed7db5fff8fa1@mail.gmail.com>
	 <20080111195521.7e771e45@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111227x50c9ff31n1435d005e6b6b1f3@mail.gmail.com>
	 <20080111210557.390271a0@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111327m1363b681ree81fbc5f7f43848@mail.gmail.com>
	 <20080111213415.56d90f0d@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111349i2518924bj7bcfd7b5e9c604e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.248]:36025 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762722AbYAKVyN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 16:54:13 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1158312hsz.5
        for <linux-ide@vger.kernel.org>; Fri, 11 Jan 2008 13:54:12 -0800 (PST)
In-Reply-To: <7f68de3e0801111349i2518924bj7bcfd7b5e9c604e2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristin Vadas Marsicano <kristin.marsicano@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Jan 11, 2008 4:49 PM, Kristin Vadas Marsicano
<kristin.marsicano@gmail.com> wrote:
> On 1/11/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > My concern with disabling the new drivers is as follows: I use this
> > > linux kernel and config image to boot machines over PXE and call a
> > > shred program on each of the harddrives.  If I turn off CONFIG_ATA,
> > > will this limit my ability to support various new IDE and SATA drives
> > > for running shred?  So far, the configuration I have works well with
> >
> > Yes. In that case you can build without CONFIG_IDE_PIIX and with the
> > CONFIG_ATA_PIIX driver and you should be fine too (but your disk will
> > move to /dev/sda on that box). The PIIX is an awkward case as in some
> > modes it combines both the SATA and PATA onto one 'device'.
> >
>
> Can I set this option through make menuconfig, or do I need to take
> some other action?  I poked around the menu config a big and wasn't
> sure I found the properties you are refering to.
>
> Would all my disks then be listed as sd[a-z] on every machine?  Or just some?
>
> > > most of the machines I encounter  (and with both SATA and IDE drives),
> > > except for the Dell D610 and HP 7700 (small desktop pc).  The models I
> > > just mentioned run the shred really slow, which I believe is due to
> > > the DMA problem I was having (outlined in my previous emails).  Any
> > > thoughts?
> >
> > If your shred program is relying on DMA then you are using the wrong tool
> > for the job. The correct way to erase a disk is to send it a security
> > erase command. Rewriting over the data may not do what is wanted.
> >
>
> For now, my desired action is to overwrite the drives with random
> characters.  My understanding is that security erase commands are
> implemented in the firmware, and that it may be buggy.  Please correct
> me if my understanding is incorrect.  Also, is there a way to invoke
> the firmware security erase with a linux command?

Kristin, you can issue Security Erase via hdparm, but don't forget
that the Security Erase command is blocked by significant number of
BIOS implentations, so switching to it would be a fundamental change
to what you do now even if you had confidence that it did work 100% of
the time.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
