From: Tejun Heo <htejun@gmail.com>
Subject: Re: Recent kernel hosing partition
Date: Tue, 11 Dec 2007 10:47:35 +0900
Message-ID: <475DEC37.1020404@gmail.com>
References: <14119388.post@talk.nabble.com> <475CEFF8.5050707@gmail.com>	 <f68177890712100208o27d71584l685520d2e9ecf5bd@mail.gmail.com>	 <475D11A1.1070700@gmail.com>	 <f68177890712100347i3a03df38n36cffd00c8603ae1@mail.gmail.com>	 <475D41AA.2060205@gmail.com> <1197308981.1873.75.camel@genius.chateau.dec>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:23791 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbXLKBrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 20:47:45 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1839443rvb
        for <linux-ide@vger.kernel.org>; Mon, 10 Dec 2007 17:47:42 -0800 (PST)
In-Reply-To: <1197308981.1873.75.camel@genius.chateau.dec>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: For Junk Mail <junk_mail@irishbroadband.net>
Cc: linux-ide@vger.kernel.org

Hello,

For Junk Mail wrote:
>> I'm not aware of any specific issues with via + Segate drives.  Have
>> pointers?
> 
> Remember the infamous via 'hardware error' which via insist is a
> configuration error from the MPV3 chipset? This 8235 southbridge is the
> same southbridge basically, shrunk down and sped up. They never liked
> Seagate drives, which seem to use non standard dma - fine with a windows
> driver, but dodgy in linux. I did some crashtesting for mandrake on disk
> optimizing scripts in times (far) past. They built a database of drives
> and how fast they could set safely them, and Seagate never got past PIO
> 4. So I never bought Seagate.

AFAIK, there currently isn't any known problem specific to VIA - Seagate
combination.  sata_via surely has some issues on error conditions tho.

>>> Another issue here is that the old ide driver could get through the
>>> mess, whereas the newer one cannot. I get "Drive reset: success" and the
>>> old ide driver recovers, whereas the new one goes out to lunch. The log
>>> snippets show a 60 seconds gap between errors. That's a 60 second freeze.
>> Hmmm...
>>
>> 1. So, the IDE driver suffers from error conditions too?  Do you have
>> logs around?
>>
> There is only IDE. No SATA. 80 ribbon cable. But Fedora only uses ATA
> driver so it's sda, and not hda as per normal. Sorry for the confusion.
> This is not a new box (2004/2005)

I meant the old driver/ide/* drivers.

>> 2. Do you have logs of libata driver goes out to lunch?
>>
> Catch 22. Did you see the film? I've only one hard disk. Reset to get
> out of trouble, so how does it log the disk going out to lunch?. Where
> would I log it to?

Ah.. Catch 22 is name of a film.  I knew what it meant but never knew
where the expression came from.  Anyways, in such cases, log is usually
collected via serial or net console, usb or other storage if you have
quasi working userland or digital cameras as a last resort.

> https://bugzilla.redhat.com/attachment.cgi?id=281341 is the output of 
> grep -C10 frozen /var/log/messages > errors.out which gives context. I
> have the whole /var/log/messages. The recorded errors are mainly in the
> bootup phase, as sda3 was unmountable every time there after an
> 'out-to-lunch' episode.
> 
> Typically, in an 'out to lunch' period, the line beginning 'exception
> Emask' down as far as 'DPO or FUA' would repeat on stdout. Some disk
> error would precede it, e.g. '/usr/lib/something.so: no such file or
> directory'. That file would probably migrate to lost+found on the next
> e2fsck pass and when I went to check it 2 reboots later it was indeed
> missing. Then we got to the stage where the
> entire /usr/lib/firefox<version>/  directory migrated and we departed
> from reality at that point.

Ah... I'd really like to see the log.

> If we can provoke the error, I feel the way to trap it is
> 1. make intelligent recoverable changes to ide partition /dev/sda3 on
> firefox files.
> 2. Directly or indirectly, Mount my 1 gig usb disk on /var/log :-D.
> Would that get around the Catch-22? I can stick in another (old) disk if
> needed, but I only have ide, and we freeze, so that will hardly be much
> good.

Usually the best way is serial or net console.

> 3. Go browsing and hope that trouble starts. 
> 
> Looking at the lost+found files in detail, I was struck by the #numbers.
> There are a number of strings there: At least 3 from Firefox; at least
> one each from openoffice, /etc/rc.d, and one I think from Evolution. 

There are other reports of sata_via freezing up after transport errors
and sadly there isn't too much to do about it.  The controller hangs
while holding the PCI bus and no software can recover from that.  I'm
currently not sure whether the controller locks up on transmission
errors or as a response to libata's error handling sequence.  If latter,
we may be able to avoid it by changing EH sequence but unfortunately I
don't have access to affected hardware or time at the moment.

What worries me is that your case actually resulted in data corruption.
 libata's EH is safe.  Another possibility is that your filesystem got
corrupted while going through several lockup - reboot sequences in which
case data sure is lost.  But still journaling and barrier should be able
to avoid filesystem corruption.  You have barrier enabled, right?

-- 
tejun
