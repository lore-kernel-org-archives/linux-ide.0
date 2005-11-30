From: Dominic Ijichi <dom@ijichi.org>
Subject: Re: sata suspend status?
Date: Wed, 30 Nov 2005 00:34:00 +0000
Message-ID: <1133310840.438cf3782abee@www.ijichi.org>
References: <1133020582.438885a6615dc@www.ijichi.org> <20051127205613.18f48772.rdunlap@xenotime.net> <1133169049.438ac999da2ab@www.ijichi.org> <Pine.LNX.4.58.0511281439300.13751@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from buffy.ijichi.org ([213.161.76.94]:14585 "EHLO buffy.ijichi.org")
	by vger.kernel.org with ESMTP id S1750706AbVK3AeJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2005 19:34:09 -0500
In-Reply-To: <Pine.LNX.4.58.0511281439300.13751@shark.he.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org

Quoting "Randy.Dunlap" <rdunlap@xenotime.net>:

> On Mon, 28 Nov 2005, Dominic Ijichi wrote:
> 
> > Quoting "Randy.Dunlap" <rdunlap@xenotime.net>:
> >
> > > On Sat, 26 Nov 2005 15:56:22 +0000 Dominic Ijichi wrote:
> > >
> > > > hello
> > > >
> > > > i've been trying to get my laptop s3 suspend working - its all working
> > > except I
> > > > believe for sata.  it resumes and you can do type in, interact with the
> > > kernel
> > > > but as soon as you do anything that requires disk access it hangs.
> sorry if
> > > this
> > > > isn't very technical description, i can provide anything if told
> roughly
> > > what to do!
> > > >
> > > > i've searched extensively for patches, tried all the various
> incantations,
> > > and
> > > > currently running 2.6.15-rc2 which is supposed to provide support for
> ata
> > > > passthrough and basic scsi suspend, but still same problem. i have:
> > > >
> > > > Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 04)
> > > >
> > > > /dev/sda = HITACHI_DK23FA-60
> > > >
> > > > hdparm -I /dev/sda works fine.love
> > > >
> > > > I note recent patches from randy dunlap from intel to do with this
> > > controller
> > > > and acpi but not sure what kernel this is against or whether it's
> relevent.
> > > >
> > > > i believe there are many people out there who would love to get sata
> > > > suspend/resume working, its a major problem for all recent laptops and
> us
> > > folks
> > > > who love running linux.  what's the current status please?
> > >
> > > Hi,
> > > It seems to work for some people.  I don't know if that's just
> > > good luck or that some controllers don't need the SATA ACPI methods
> > > that I am working on.  We should know more about that in the next
> > > few weeks, I hope.
> >
> > hiya
> > can't work out how to apply your patches, have tried against 2.6.15-rc2
> with
> > symlinked directories but everything rejects.  sorry for my ignorance,
> would
> > like to try these out!
> 
> Sorry about that.  I'll correct that and repost with exact
> info about correct kernel version to use.

hmm, i must have cut and paste them wrongly as i get failed hunks.  is there a
decent archive of the mailing list?  the MARC one pointed to from kernel.org
doesnt seem to update or have attachments.

> However, these current patches won't get you much additional help
> for SATA suspend/resume since they lack writing the taskfile data
> to the controller ports.

really look forward to it!

thanks for your work
dom
 
> --
> ~Randy


------------------------------------------
This message was penned by the hand of Dom
