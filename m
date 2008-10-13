From: Stan Cunningham <stan.cunningham@yahoo.com>
Subject: Porting old hardware from ide to libata (was [PATCH 0/7] ide: locking improvements)
Date: Mon, 13 Oct 2008 12:46:03 -0700 (PDT)
Message-ID: <678468.92529.qm@web57414.mail.re1.yahoo.com>
Reply-To: stan.cunningham@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from n1.bullet.mail.re3.yahoo.com ([68.142.237.108]:24285 "HELO
	n1.bullet.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751798AbYJMTvo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 15:51:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> > the IDE code today, when we have libata around which is a much better 
> > code base to work from? I'm afraid it still escapes me. I don't mean to 
> 
> Simply:
> 
> * Not all hardware is supported by libata.

Then it would be best to port that hardware from ide to libata. Make a page on http://ata.wiki.kernel.org listing every single functionality that is present in ide but missing from libata, and then start tackling the points one by one. A lot of these points were discussed in this thread:

http://marc.info/?t=121777915500001&r=1&w=2

Go through the ide drivers with a fine tooth comb and make sure all the quirks and PCI IDs are transfered to the corresponding libata driver.

It seems that Bart, Boris and the other recent ide contributors care a lot about old hardware, which is great because the corporate-sponsored libata developers are paid to focus on new hardware. You should in theory complement each other well, but please work on the same codebase so that the optimizations one group makes to the framework help everybody.

> * Today's IDE code is not so different from libata's.

All the more reason porting missing functionality to libata should be easier.

> * I'm much more familiar with IDE's code than libata's. :)

Sorry, but that's a bad excuse. If you want your work to reach and help the greatest number of people, you should work on improving libata because that  is what the vast majority of developers are working to optimize. Porting old hardware to libata will allow that old hardware to take advantage of many of optimizations and new features that the libata framework already provides! 

I know many distros still use ide for CD drives, but that *sucks* for users because the two driver frameworks loaded simultaneously waste memory and step on each other's toes. Plus, obscure fixes to one framework will not help the other, so users have to stumble on the same bug *twice* before it's fixed for good. But most likely it will get fixed in one framework and overlooked in the other.

So please, take the time to overcome the libata learning curve and start systematically porting support for the remaining old hardware to libata.

Stan


      

