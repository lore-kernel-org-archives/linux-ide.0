From: Tejun Heo <htejun@gmail.com>
Subject: Re: Recent kernel hosing partition
Date: Wed, 12 Dec 2007 17:07:40 +0900
Message-ID: <475F96CC.6040300@gmail.com>
References: <14119388.post@talk.nabble.com> <475CEFF8.5050707@gmail.com>	 <f68177890712100208o27d71584l685520d2e9ecf5bd@mail.gmail.com>	 <475D11A1.1070700@gmail.com>	 <f68177890712100347i3a03df38n36cffd00c8603ae1@mail.gmail.com>	 <475D41AA.2060205@gmail.com> <1197308981.1873.75.camel@genius.chateau.dec>	 <475DEC37.1020404@gmail.com> <1197368344.1830.67.camel@genius.chateau.dec>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:11317 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbXLLIHt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 03:07:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so238867wah.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 00:07:48 -0800 (PST)
In-Reply-To: <1197368344.1830.67.camel@genius.chateau.dec>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: For Junk Mail <junk_mail@irishbroadband.net>
Cc: linux-ide@vger.kernel.org

Hello,

For Junk Mail wrote:
>>From previous incarnations of the via chipset I've had errors on dma,
> drive 'ringing' (where access/copying to hdb wakes up hda which says
> "What's going on?" and confuses everything) from Seagate drives. One M/B
> sat down and refused to work with 2 hard disks on the same ribbon. Maybe
> I'm just one disenchanted luser but I had the logs to prove it in the
> crashtesting days and they were examined by Mandrake's guys.

I see.  Please report to kernel bugzilla (bugzilla.kernel.org) or this
mailing list if you see anything like this the next time.  Even if we
can't fix it right away, it will be useful for future references or when
pattern of similar problems emerges.

>>>> 1. So, the IDE driver suffers from error conditions too?  Do you have
>>>> logs around?
>>>>
>> I meant the old driver/ide/* drivers.
>>
> /checks every distro
> YES! I have logs of errors with the old ide driver. When Fedora 7 went
> out to lunch, I was embarassed for a kernel for my (previous) fedora 5,
> and ended up using e2fsck from a uClibc based experimental distro from
>  
> http://kevux.org/
> 
> It has e2fsck-1.40.2, and some weird alternative log system. I'll send
> the appropriate log privately as well as Fedora's log. Logs are dated.
> The last errors in Kevux will correspond to a time shortly
> after /usr/lib/firefox went missing in Fedora 7, as I went from one to
> the other to sort the disk out. Do you understand me? 
> 
> I should be very clear. These errors occurred using the old driver on
> hda3(sda3) while dealing with errors _caused_ by what you are trying to
> investigate. Fedora 7 also had /dev/sda5 mounted as /home, and /dev/sda1
> as /boot and not one error occurred on either of those. I checked the
> whole disk with e2fsck at some points, and everything was fine.
> Filesystems were modified, but nothing came to lost+found, or nothing
> was corrupted to my knowledge except on sda3.

This bit is very interesting, so you're saying that the ide driver also
showed IO errors while trying to repair the filesystem damaged while
using libata driver.

If that's the case, it strongly points to harddrive malfunction.
Different driver seeing the same problems after rebooting and those
errors going away after re-installing or fsck'ing strongly indicates
that those errors were caused by defects on the media.

> What upset me personally, btw, is that nobody in RedHat/Fedora gave an
> <expletive deleted>. When you're finished, Slackware is going in
> there :-D

I myself also work for a distro and my buglist is always accumulating.
I guess RH has a handful too.  With recent transition to libata and its
rapid development, there are a lot of issues to be dealt with and ppl
working on libata are heavily loaded these days.  I hope you could cut
us some slack.  :-)

>>> If we can provoke the error, I feel the way to trap it is
>>> 1. make intelligent recoverable changes to ide partition /dev/sda3 on
>>> firefox files.
>>> 2. Directly or indirectly, Mount my 1 gig usb disk on /var/log :-D.
>>> Would that get around the Catch-22? I can stick in another (old) disk if
>>> needed, but I only have ide, and we freeze, so that will hardly be much
>>> good.
>> Usually the best way is serial or net console.
> 
> Have you a reference, or a doc on doing that? I'll set it up.

It's included in the kernel source tree under Documentation/.
serial-console.txt and networking/netconsole.txt.

>> There are other reports of sata_via freezing up after transport errors
>> and sadly there isn't too much to do about it.  The controller hangs
>> while holding the PCI bus and no software can recover from that.  I'm
>> currently not sure whether the controller locks up on transmission
>> errors or as a response to libata's error handling sequence.  If latter,
>> we may be able to avoid it by changing EH sequence but unfortunately I
>> don't have access to affected hardware or time at the moment.
> 
> Here Via has one step up (or down) from everybody because PCI and IDE
> are split in the Southbridge, and the 2 are not linked. I have the
> datasheet to prove it. So it's freezing further back. I've worked in
> electronic hardware and I see 2 problems

It doesn't matter where the controller is.  If a controller dies while
holding PCI bus or while the CPU is performing IO cycle on it, the
machine is locked up completely unless it has hardware mechanism to get
out of such lockup (PCI bridges on fancy servers have mechanisms to
detect such condition and abort the hung transaction).

> 2. The soft reset libata provides doesn't sort things out. The drive
> reset provided by the old ide driver seemed to sort it out. 
>> What worries me is that your case actually resulted in data corruption.
>>  libata's EH is safe.  Another possibility is that your filesystem got
>> corrupted while going through several lockup - reboot sequences in which
>> case data sure is lost.  But still journaling and barrier should be able
>> to avoid filesystem corruption.  You have barrier enabled, right?
> 
> I really don't know if barrier is enabled. If you tell me how I can
> check it. journalling is on the same partition, but as we froze, and
> apparently did more damage as things went on, I was quick to reset. That
> effectively reduces it to ext2. But I was also quick to check the whole
> partition (Because I couldn't boot otherwise).

mount will show barrier=1 if you have it enabled.

-- 
tejun
