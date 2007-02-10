From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sat, 10 Feb 2007 17:03:37 +0100
Message-ID: <1171123417.31813.4.camel@localhost>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
	 <45CC3FE5.2010408@gmail.com> <1171035949.23440.4.camel@localhost>
	 <200702091841.45125.rootkit85@yahoo.it>
	 <1171102758.19041.5.camel@localhost>  <45CDC5DF.9060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:34836 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695AbXBJQDk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Feb 2007 11:03:40 -0500
In-Reply-To: <45CDC5DF.9060306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matteo Croce <rootkit85@yahoo.it>, linux-ide@vger.kernel.org

On Sat, 2007-02-10 at 08:17 -0500, Tejun Heo wrote:
> Soeren Sonnenburg wrote:
> > On Fri, 2007-02-09 at 18:41 +0100, Matteo Croce wrote:
> >> On Friday 09 February 2007 16:45:49 you wrote:
> >>> On Fri, 2007-02-09 at 04:33 -0500, Tejun Heo wrote:
> >>>> Root Kit wrote:
> >>> [...]
> >>> Hmmhh I cannot really reproduce this benchmark. Matteo, with which
> >>> benchmarking program did you produce this ?
> >>> [...]
> >> bonnie++ from ubuntu repos
> > 
> > OK, I reran bonnie++ -d /tmp/ on a unencrypted partition - results are
> > here http://nn7.de/bench/ahci.html . Looks like it is slightly faster
> > for sequential block write (2MB/s faster) and sequential read using
> > putc()  (1MB/s faster), though putc() is slowed down by 6MB/s.
> 
> I suspect the difference is caused by either the io scheduler in use or 
> disk drive itself.

well I am doing both benchmarks on a macbookpro1,1 -> 32bit mode (matteo
does it on a macbook pro2, sth so he has a c2d and does it in 64bit ->
amd64 mode).

So the io scheduler is the same or do you mean inside of ahci/piix ?

> > However what may make it worth is that I don't see any errors on
> > suspend/resume anymore...
> 
> Hmm... So, ata_piix fails to suspend/resume properly on your machine? 
> It should work.  Can you describe how it fails?

Well I keep seeing this:

ata3.01: revalidation failed (errno=-2)
ata3: failed to recover some devices, retrying in 5 secs
ATA: abnormal status 0x7F on port 0x40DF
ATA: abnormal status 0x7F on port 0x40DF
ata3.01: configured for UDMA/133

but I am still on 2.6.20-rc6 ... so sorry if this is now fixed in .20.

Soeren.
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
