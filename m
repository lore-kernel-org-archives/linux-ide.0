From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Thu, 15 Mar 2007 22:53:35 -0700 (PDT)
Message-ID: <20070316055335.51776.qmail@web811.biz.mail.mud.yahoo.com>
References: <45FA286D.8050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web811.biz.mail.mud.yahoo.com ([209.191.90.84]:33627 "HELO
	web811.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753417AbXCPFxg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 01:53:36 -0400
In-Reply-To: <45FA286D.8050705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:

> Bob Stewart wrote:
> > --- Tejun Heo <htejun@gmail.com> wrote:
> > 
> >> The driver is seriously broken regarding LBA48 support.  The timeout
> >> goes away if max_sectors is decreased to ATA_MAX_SECTORS - 1, doh.  But
> >> both the reading and writing are seriously broken.  I can't tell whether
> >> they end up in the wrong sectors or garbage is transferred to/from the
> >> right sectors.
> > 
> > I couldn't figure it out, either.  There were some times early on that I
> > failed it all the way down to PIO4 and it worked just fine.  But, with DMA
> > forget it.  
> 
> Hmmm... I played a bit with POLLING LBA48 but no luck.  I always got HSM
> violation.

I spoke with imprecision.  What I meant was that I was able to get error-free
operation with PIO4 in LBA28, not with LBA48.  I have been testing using
md5sum on a 7+GB DVD ISO.  I have never gotten the same result twice 
using DMA.  I was able to get proper md5 sums with PIO, though I didn't
mess with that for too long.  The test drive was an 80GB WD800JB that
I've since moved to my "good" system.  I went ahead and ordered another
one to play with this some more.  It should be in in about 2 weeks.

BTW, did you want me to load a 2.4 kernel to test the sunix driver, or did you
have something else in mind?  I wasn't quite clear on what I was agreeing
to.  :)  I'm OK either way.  I've got a spare PATA drive to put the 2.4 kernel
on if necessary, and can test with the new WD800 on the INIC162x.  I've also
got a 200GB drive that I can do read testing with if it comes to an LBA48
issue.

(Steelhead are a species of rainbow trout.)

Bob
