From: For Junk Mail <junk_mail@irishbroadband.net>
Subject: Re: Recent kernel hosing partition
Date: Wed, 12 Dec 2007 12:08:57 +0000
Message-ID: <1197461337.3532.92.camel@dhcppc1>
References: <14119388.post@talk.nabble.com> <475CEFF8.5050707@gmail.com>
	 <f68177890712100208o27d71584l685520d2e9ecf5bd@mail.gmail.com>
	 <475D11A1.1070700@gmail.com>
	 <f68177890712100347i3a03df38n36cffd00c8603ae1@mail.gmail.com>
	 <475D41AA.2060205@gmail.com> <1197308981.1873.75.camel@genius.chateau.dec>
	 <475DEC37.1020404@gmail.com> <1197368344.1830.67.camel@genius.chateau.dec>
	 <475F96CC.6040300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3.irishbroadband.ie ([62.231.32.16]:59923 "EHLO
	smtp3.irishbroadband.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbXLLNPF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 08:15:05 -0500
In-Reply-To: <475F96CC.6040300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

On Wed, 2007-12-12 at 17:07 +0900, Tejun Heo wrote:
> Hello,
> 
> For Junk Mail wrote:
> >>From previous incarnations of the via chipset I've had 
[snip tale of woe]
> 
> I see.  Please report to kernel bugzilla (bugzilla.kernel.org) or this
> mailing list if you see anything like this the next time.  Even if we
> can't fix it right away, it will be useful for future references or when
> pattern of similar problems emerges.
OK. Personally, I felt it was Fedora who should have done that. This is
Fedora's kernel with megabytes of patches. The first logical question
would be "does it happen on a stock kernel?"

> 
> >>>> 1. So, the IDE driver suffers from error conditions too?  Do you have
> >>>> logs around?

> > /checks every distro
> > YES! [snip]

> > 
> > I should be very clear. These errors occurred using the old driver on
> > hda3(sda3) while dealing with errors _caused_ by what you are trying to
> > investigate. Fedora 7 also had /dev/sda5 mounted as /home, and /dev/sda1
> > as /boot and not one error occurred on either of those. I checked the
> > whole disk with e2fsck at some points, and everything was fine.
> > Filesystems were modified, but nothing came to lost+found, or nothing
> > was corrupted to my knowledge except on sda3.
> 
> This bit is very interesting, so you're saying that the ide driver also
> showed IO errors while trying to repair the filesystem damaged while
> using libata driver.

I believe so. Cross checking the times on the logs I sent would confirm
it. I didn't examine them in detail - what's the point of me doing it?
> 
> If that's the case, it strongly points to harddrive malfunction.
> Different driver seeing the same problems after rebooting and those
> errors going away after re-installing or fsck'ing strongly indicates
> that those errors were caused by defects on the media.

Nearly Right. There's no media defects, and you've verified that
yourself. The hardware guy in me says it could be a motherboard
'disagreeing' with the hard drive. This boils down to poor control of
logic levels, non standard implications, poor adherence to standards.
I've had a genuine amd 'i586, amd k6-2, amd k6-3 and now athlon over the
years. The AMD motherboards over here come with  Via chipsets, which do
not do dma satisfactorily with Seagate drives. Back in the 90s I was
told Seagate's approach dma was non standard. Via's ide may not be
actually the worst out there (SiS 5513 for that honour?) but it is
certainly not brilliant.

> > What upset me personally, btw, is that nobody in RedHat/Fedora gave an
> > <expletive deleted>. When you're finished, Slackware is going in
> > there :-D
> 
> I myself also work for a distro and my buglist is always accumulating.
> I guess RH has a handful too.  With recent transition to libata and its
> rapid development, there are a lot of issues to be dealt with and ppl
> working on libata are heavily loaded these days.  I hope you could cut
> us some slack.  :-)

There's more than libata involved. sda1 - sda9 and only sda3  (/) has
errors. Only programs run under X have errors, on files they are
reading, not writing. Everything else works faultlessly. That's fairly
specific pointing at something. I use runlevel 3 here. Some stuff
(compiles, etc)is run in Alt_Fx consoles, but X is used as well.  I
dislike xterms, That's an unusual way to behave, but it begs the
question: What does X do to libata? Massive copies/deletions/compiles go
on OK on consoles, but a lightly loaded x screws up.

> >>> If we can provoke the error, I feel the way to trap it is
> >>> 1. make intelligent recoverable changes to ide partition /dev/sda3 on
> >>> firefox files.
> >>> 2. Directly or indirectly, Mount my 1 gig usb disk on /var/log :-D.
> >>> Would that get around the Catch-22? I can stick in another (old) disk if
> >>> needed, but I only have ide, and we freeze, so that will hardly be much
> >>> good.
> >> Usually the best way is serial or net console.
> > 
> > Have you a reference, or a doc on doing that? I'll set it up.
> 
> It's included in the kernel source tree under Documentation/.
> serial-console.txt and networking/netconsole.txt.

Right. I'll check it out.

> >> There are other reports of sata_via freezing up after transport errors
> >> and sadly there isn't too much to do about it.  The controller hangs
> >> while holding the PCI bus and no software can recover from that.  I'm
> >> currently not sure whether the controller locks up on transmission
> >> errors or as a response to libata's error handling sequence.  If latter,
> >> we may be able to avoid it by changing EH sequence but unfortunately I
> >> don't have access to affected hardware or time at the moment.
> > 
> > Here Via has one step up (or down) from everybody because PCI and IDE
> > are split in the Southbridge, and the 2 are not linked. I have the
> > datasheet to prove it. So it's freezing further back. I've worked in
> > electronic hardware and I see 2 problems
> 
> It doesn't matter where the controller is.  If a controller dies while
> holding PCI bus or while the CPU is performing IO cycle on it, the
> machine is locked up completely unless it has hardware mechanism to get
> out of such lockup (PCI bridges on fancy servers have mechanisms to
> detect such condition and abort the hung transaction).

I dunno if I buy that. I've sat there with these errors rolling up the
screen at 6 lines per minute. If it's talking to STDOUT, well the
Southbridge isn't locked, is it? I've seen what you describe, and the
box freees - the 'bluescreen effect' we get from m$ windoze. A reset is
the only thing. The only thing that's actually locked up here is the ide
controller, or the ide drive.

/looks at those logs I sent

The old driver notices trouble on dma timeouts, throws  'ide0 drive
reset' and drops dma. It survives. The libata driver hits trouble,
throws a soft reset to the port and throttles back dma, doesn't reset
the drive, and hell breaks loose. Next reboot I cannot mount that drive
as root - that's pretty fundamental damage. The system doesn't run
e2fsck - the boot freezes. Luckily I have a few distro options here.
Why not set up the new driver to do what the old one did? There's a lot
of dodgy hardware out there and you're trying to drag it all into the
21st century.

> 
> > 2. The soft reset libata provides doesn't sort things out. The drive
> > reset provided by the old ide driver seemed to sort it out. 
> >> What worries me is that your case actually resulted in data corruption.
> >>  libata's EH is safe.  Another possibility is that your filesystem got
> >> corrupted while going through several lockup - reboot sequences in which
> >> case data sure is lost.  But still journaling and barrier should be able
> >> to avoid filesystem corruption.  You have barrier enabled, right?

Just thinking about this, each instance I observed of this (usually by
hitting Ctrl_Alt_F1 while X was misbehaving) showed a filesystem error
at the beginning. During the X session that /usr/lib/firefox<version>/
went missing, I had been _running_ firefox. Some problems appeared. I
dropped from X, which restored sanity, and restarted X & yum update
(which  screwed up the rpm database, btw) and /usr/lib/firefox was awol.
Looking for it got me into more trouble, and a reboot was called for.

In short, the corruption is nearly always on READS.  Everything
corrupted was being READ. nothing corrupted was ever written. And it's
related to or caused by X, Firefox, Evolution or possibly openoffice,
because only programs read under X were damaged. Meanwhile all the
console based stuff, other partitions and toolchain behave as if nothing
was wrong. /home and /boot are fine. This is not _only_ a libata bug. 
> > 
> > I really don't know if barrier is enabled. If you tell me how I can
> > check it. 
> mount will show barrier=1 if you have it enabled.

I guess it isn't.  From dmesg|tail :

kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

greps of the log for barrier don't show it.
You can take it barrier is not enabled by default. How is it done?
An /etc/fstab option?

BTW, in the past few days, I've lived in my Fedora 5 distro, and spent
no more than 2 hours in Fedora 7. I went off and checked the partitions
today in another distro

High usage FC5 was 0.2% non contiguous (old ide driver)
Low usage Fedora 7 was 7% non contiguous(libata driver)

-- 
For Junk Mail <junk_mail@irishbroadband.net>

