From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata-dev git question:
Date: Sun, 02 Dec 2007 10:10:08 -0500
Message-ID: <4752CAD0.1040303@pobox.com>
References: <4752C70F.80506@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40626 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756116AbXLBPKO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 10:10:14 -0500
In-Reply-To: <4752C70F.80506@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> I am below "novice" when it comes to git:
> 
>> $ git-pull --update-head-ok --tags 
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>> Warning: No merge candidate found because value of config option
>>         "branch.master.merge" does not match any remote branch fetched.
>> No changes.
> ..
> 
> Is that "normal" ?

Yes.


> Is that even the correct command to update my entire local existing copy 
> of Jeff's git tree?

No.

Generally I would use

	cd $repo
	git-checkout master	# if not already there
	git pull		# fetches new objects, updates 'master'
	git-fetch -f $URL upstream:upstream	# fetch updated branch
	git-fetch -f $URL mv-ncq:mv-ncq
	git-fetch -f $URL upstream-fixes:upstream-fixes
	git-fetch -f $URL upstream:upstream
	... continue for each branch you like...

There is probably an easier way to get it to download all branches, even 
if they have been rebased.

	Jeff


