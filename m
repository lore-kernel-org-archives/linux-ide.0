From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Porting old hardware from ide to libata (was [PATCH 0/7] ide: locking improvements)
Date: Mon, 13 Oct 2008 23:45:51 +0200
Message-ID: <200810132345.51836.bzolnier@gmail.com>
References: <678468.92529.qm@web57414.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:49264 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbYJMVsJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 17:48:09 -0400
Received: by gv-out-0910.google.com with SMTP id e6so428248gvc.37
        for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 14:48:08 -0700 (PDT)
In-Reply-To: <678468.92529.qm@web57414.mail.re1.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stan.cunningham@yahoo.com
Cc: linux-ide@vger.kernel.org

On Monday 13 October 2008, Stan Cunningham wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > > the IDE code today, when we have libata around which is a much better 
> > > code base to work from? I'm afraid it still escapes me. I don't mean to 
> > 
> > Simply:
> > 
> > * Not all hardware is supported by libata.
> 
> Then it would be best to port that hardware from ide to libata. Make a page on http://ata.wiki.kernel.org listing every single functionality that is present in ide but missing from libata, and then start tackling the points one by one. A lot of these points were discussed in this thread:
> 
> http://marc.info/?t=121777915500001&r=1&w=2
> 
> Go through the ide drivers with a fine tooth comb and make sure all the quirks and PCI IDs are transfered to the corresponding libata driver.
> 
> It seems that Bart, Boris and the other recent ide contributors care a lot about old hardware, which is great because the corporate-sponsored libata developers are paid to focus on new hardware. You should in theory complement each other well, but please work on the same codebase so that the optimizations one group makes to the framework help everybody.
> 
> > * Today's IDE code is not so different from libata's.
> 
> All the more reason porting missing functionality to libata should be easier.
> 
> > * I'm much more familiar with IDE's code than libata's. :)
> 
> Sorry, but that's a bad excuse. If you want your work to reach and help the greatest number of people, you should work on improving libata because that  is what the vast majority of developers are working to optimize. Porting old hardware to libata will allow that old hardware to take advantage of many of optimizations and new features that the libata framework already provides! 
> 
> I know many distros still use ide for CD drives, but that *sucks* for users because the two driver frameworks loaded simultaneously waste memory and step on each other's toes. Plus, obscure fixes to one framework will not help the other, so users have to stumble on the same bug *twice* before it's fixed for good. But most likely it will get fixed in one framework and overlooked in the other.

It is not mine fault.  Please complain to the right people.

You may want to dig into archives and learn about history of libata.
Especially under what conditions it has been ACK-ed and merged _five_
years ago.  Just to quickly recall, there were two such conditions:

* PATA support would be moved from IDE to libata in an evolutionary way.

  Didn't happen.  Instead we had code split, loss of git history, user
  confusion and unimaginable waste of time/resources (quick stunt trick
  and more then three long years of rediscovering the wheel...).

* It would be moved out of SCSI in the long-term.

  Didn't happen.  Five years is more than enough time for that.

> So please, take the time to overcome the libata learning curve and start systematically porting support for the remaining old hardware to libata.

I don't mind somebody doing it.

I just have zero motivation to do it myself in my private time.

PS It is not like I don't know the libata's code completely... ;)
