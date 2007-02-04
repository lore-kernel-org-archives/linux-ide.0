From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Sat, 3 Feb 2007 18:46:58 -0800 (PST)
Message-ID: <752079.2468.qm@web801.biz.mail.mud.yahoo.com>
References: <45C54692.3070809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web801.biz.mail.mud.yahoo.com ([209.191.90.74]:21913 "HELO
	web801.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751967AbXBDCq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 21:46:59 -0500
In-Reply-To: <45C54692.3070809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:

> [this thread is regarding sata_inic162x, misplaced reply]
> 
> Bob Stewart wrote:
> > There is still something else bad going on in your driver.  I've tried
> > everything I can think of (timing changes, flushes, and whatnot)
> > but I still get random timeouts and random results from md5sum
> > on large files.  Even in the case where I don't get a timeout on a large
> > iso file, the md5sum is still random.  Strangely enough, though, 
> > the files may be good on-disk, since totem seems to play the DVD.iso
> > that I'm testing with without a problem.  I'm using debian with a 2.6.19.2
> > kernel.
> 
> Yeap, I'm aware of the problem.  That's why the driver is marked HIGHLY
> EXPERIMENTAL.  Maybe I should change it to broken.  :-(  Anyways, one of
> the known problems is mishandling of LBA48 commands which is cause of
> timeouts and wrong md5sums on large disks.  I just couldn't find any
> time to work on it in recent weeks.  Please be patient a bit.  I'll get
> back to sata_ini162x in a few days.
> 
> -- 
> tejun
> 

Thanks Tejun,

I'm trying to use this as a learning tool, so I'm not putting pressure on you
to fix it.  Well, at least I've learned a bit about libata etc while digging
through 
this, even if I wasn't able to figure out what the problem was.  :)  By the
way, 
the drive I'm using to play with this now is only an 80GB drive.

Bob
