From: For Junk Mail <junk_mail@irishbroadband.net>
Subject: Re: Recent kernel hosing partition
Date: Tue, 11 Dec 2007 10:19:04 +0000
Message-ID: <1197368344.1830.67.camel@genius.chateau.dec>
References: <14119388.post@talk.nabble.com> <475CEFF8.5050707@gmail.com>
	 <f68177890712100208o27d71584l685520d2e9ecf5bd@mail.gmail.com>
	 <475D11A1.1070700@gmail.com>
	 <f68177890712100347i3a03df38n36cffd00c8603ae1@mail.gmail.com>
	 <475D41AA.2060205@gmail.com> <1197308981.1873.75.camel@genius.chateau.dec>
	 <475DEC37.1020404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.irishbroadband.ie ([62.231.32.12]:55242 "EHLO
	smtp1.irishbroadband.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbXLKKTO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 05:19:14 -0500
In-Reply-To: <475DEC37.1020404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, 2007-12-11 at 10:47 +0900, Tejun Heo wrote:
> Hello,
> 
[snip]
> 
> AFAIK, there currently isn't any known problem specific to VIA - Seagate
> combination.  sata_via surely has some issues on error conditions tho.

>From previous incarnations of the via chipset I've had errors on dma,
drive 'ringing' (where access/copying to hdb wakes up hda which says
"What's going on?" and confuses everything) from Seagate drives. One M/B
sat down and refused to work with 2 hard disks on the same ribbon. Maybe
I'm just one disenchanted luser but I had the logs to prove it in the
crashtesting days and they were examined by Mandrake's guys.
> 
> >>> Another issue here is that the old ide driver could get through the
> >>> mess, whereas the newer one cannot. I get "Drive reset: success" and the
> >>> old ide driver recovers, whereas the new one goes out to lunch. The log
> >>> snippets show a 60 seconds gap between errors. That's a 60 second freeze.
> >> Hmmm...
> >>
> >> 1. So, the IDE driver suffers from error conditions too?  Do you have
> >> logs around?
> >>
> 
> I meant the old driver/ide/* drivers.
> 
/checks every distro
YES! I have logs of errors with the old ide driver. When Fedora 7 went
out to lunch, I was embarassed for a kernel for my (previous) fedora 5,
and ended up using e2fsck from a uClibc based experimental distro from
 
http://kevux.org/

It has e2fsck-1.40.2, and some weird alternative log system. I'll send
the appropriate log privately as well as Fedora's log. Logs are dated.
The last errors in Kevux will correspond to a time shortly
after /usr/lib/firefox went missing in Fedora 7, as I went from one to
the other to sort the disk out. Do you understand me? 

I should be very clear. These errors occurred using the old driver on
hda3(sda3) while dealing with errors _caused_ by what you are trying to
investigate. Fedora 7 also had /dev/sda5 mounted as /home, and /dev/sda1
as /boot and not one error occurred on either of those. I checked the
whole disk with e2fsck at some points, and everything was fine.
Filesystems were modified, but nothing came to lost+found, or nothing
was corrupted to my knowledge except on sda3.

What upset me personally, btw, is that nobody in RedHat/Fedora gave an
<expletive deleted>. When you're finished, Slackware is going in
there :-D

> >> 2. Do you have logs of libata driver goes out to lunch?
> >>
> > Catch 22. Did you see the film? I've only one hard disk. Reset to get
> > out of trouble, so how does it log the disk going out to lunch?. Where
> > would I log it to?
> 
> Ah.. Catch 22 is name of a film.  I knew what it meant but never knew
> where the expression came from.  Anyways, in such cases, log is usually
> collected via serial or net console, usb or other storage if you have
> quasi working userland or digital cameras as a last resort.

Have you a doc on setting up such a log somewhere? I'll set one up. As
long as it doesn't queue in the ide cache. BTW, Catch-22 was also a
book, which I read. It was full of army tales. You didn't miss much,
imho. Knowing what it means is enough.
> 
[snip]
> > Typically, in an 'out to lunch' period, the line beginning 'exception
> > Emask' down as far as 'DPO or FUA' would repeat on stdout. Some disk
> > error would precede it, e.g. '/usr/lib/something.so: no such file or
> > directory'. That file would probably migrate to lost+found on the next
> > e2fsck pass and when I went to check it 2 reboots later it was indeed
> > missing. Then we got to the stage where the
> > entire /usr/lib/firefox<version>/  directory migrated and we departed
> > from reality at that point.
> 
> Ah... I'd really like to see the log.

Sadly, there wasn't one. The box froze in X. I hit Ctrl_Alt_F1. I saw
/usr/lib/firefox-2.0.0.9/firefox-bin: No such file or directory
Followed by the error (Emask ... --> DPO or FUA)
e2fsck found illegal inodes, loose inodes, inodes claimed by 2 programs,
counts all over the place. It restarted itself after stage 2, and I
nearly blew a gasket because stage1 had the badblocks option set :-(. I
saw A, B, & C to some of these 5 stages that I never saw before. I'll
privately send you the /var/log/messages in it's entirety, which is all
the Fedora 7 recorded data. I know linux-ide will bounce it. The _last_
set of errors in the file will be that time
when /usr/lib/firefox-2.0.0.9/ went awol.


Subsequent to that outage I compiled binutils, uClibc, installed linux
headers, and finally crashed out on a repeatable error in compiling gcc
using somebody's scripts in Fedora 7. But I couldn't run X, because
gnome and every X program was borked by this error. I'd get X (the grey
screen) and then things went sadly wrong in gnome.

> 
> > If we can provoke the error, I feel the way to trap it is
> > 1. make intelligent recoverable changes to ide partition /dev/sda3 on
> > firefox files.
> > 2. Directly or indirectly, Mount my 1 gig usb disk on /var/log :-D.
> > Would that get around the Catch-22? I can stick in another (old) disk if
> > needed, but I only have ide, and we freeze, so that will hardly be much
> > good.
> 
> Usually the best way is serial or net console.

Have you a reference, or a doc on doing that? I'll set it up.


> 
> There are other reports of sata_via freezing up after transport errors
> and sadly there isn't too much to do about it.  The controller hangs
> while holding the PCI bus and no software can recover from that.  I'm
> currently not sure whether the controller locks up on transmission
> errors or as a response to libata's error handling sequence.  If latter,
> we may be able to avoid it by changing EH sequence but unfortunately I
> don't have access to affected hardware or time at the moment.

Here Via has one step up (or down) from everybody because PCI and IDE
are split in the Southbridge, and the 2 are not linked. I have the
datasheet to prove it. So it's freezing further back. I've worked in
electronic hardware and I see 2 problems

1. The error condition reading the filesystem for whatever reason (In my
case, linked to some X program). 
2. The soft reset libata provides doesn't sort things out. The drive
reset provided by the old ide driver seemed to sort it out. 
> 
> What worries me is that your case actually resulted in data corruption.
>  libata's EH is safe.  Another possibility is that your filesystem got
> corrupted while going through several lockup - reboot sequences in which
> case data sure is lost.  But still journaling and barrier should be able
> to avoid filesystem corruption.  You have barrier enabled, right?

I really don't know if barrier is enabled. If you tell me how I can
check it. journalling is on the same partition, but as we froze, and
apparently did more damage as things went on, I was quick to reset. That
effectively reduces it to ext2. But I was also quick to check the whole
partition (Because I couldn't boot otherwise).

-- 
For Junk Mail <junk_mail@irishbroadband.net>

