From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Sun, 22 Apr 2007 01:20:06 +0200
Message-ID: <1177197606.7316.44.camel@twins>
References: <88SeR-5Sf-15@gated-at.bofh.it> <46265307.7060405@rtr.ca>
	 <46265966.1040102@redhat.com> <200704182322.20514.bzolnier@gmail.com>
	 <46268D27.9070809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751003AbXDUXUM@vger.kernel.org>
In-Reply-To: <46268D27.9070809@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, Stephen.Clark@seclark.us, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Wed, 2007-04-18 at 17:27 -0400, Chuck Ebbert wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 18 April 2007, Chuck Ebbert wrote:
> >> Mark Lord wrote:
> >>> Mark Lord wrote:
> >>>> With the patch applied, I don't see *any* new activity in those
> >>>> S.M.A.R.T.
> >>>> attributes over multiple hibernates (Linux "suspend-to-disk").
> >>> Scratch that -- operator failure.  ;)
> >>> The patch makes no difference over hibernates in the SMART logs.
> >>>
> >>> It's still logging extra Power-Off_Retract_Count pegs,
> >>> which it DID NOT USED TO DO not so long ago.
> >>>
> >> Just to add to the fun, my problems are happening with the "old"
> >> IDE drivers...
> > 
> > The issue you are experiencing results in the same problem (disk doing
> > power off retract) but it has a totally different root cause - your notebook
> > loses power on reboot.  It is actually a hardware problem and as you have
> > reported the same problem is present when using "the other" OS.
> > 
> 
> My "power off retract count" increases whether I do a halt/poweroff or
> a reboot. The only difference is the volume of the noise.
> 
> And I just noticed my "seek error rate" is increasing.
> 
> /me plans purchase of another drive, definitely not Seagate...
> 
> > I think that the issue needs to be fixed (by detecting affected notebook(s)
> > using DMI?) in Linux PM handling and not in IDE subsystem because:
> >
> > * there may be some other hardware devices affected by the power loss
> >   (== they require shutdown sequence)
> >
> > * the same problem will bite if somebody decides to use libata (FC7?)
> 
> Yeah, this needs fixing too. I've been playing with another notebook and
> the power does stay on during reboot, so I wonder how widespread the problem is?

/me too

Thinkpad T23, with a ST980815A

Ticks ever few seconds, but seems to mostly go away with 
  hdparm -B255 /dev/sda1

but I have an increasing seek error rate as well. I got the ST disk
because thinkwiki suggested it.

I suspect this problem killed the previous disk in this laptop.
