From: Nikanth Karthikesan <knikanth@suse.de>
Subject: Re: ATA 4 KiB sector issues.
Date: Thu, 11 Mar 2010 20:30:44 +0530
Message-ID: <201003112030.44605.knikanth@suse.de>
References: <4B947393.2050002@kernel.org> <201003111927.24829.knikanth@suse.de> <472A4C80-30CE-4875-8073-F7E61659B6F0@mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35641 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932424Ab0CKO7a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Mar 2010 09:59:30 -0500
In-Reply-To: <472A4C80-30CE-4875-8073-F7E61659B6F0@mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Damian Lukowski <damian@tvk.rwth-aachen.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Matthew Wilcox <matthew@wil.cx>, "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Mark Lord <kernel@teksavvy.com>, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, aschnell@suse.de, jdelvare@suse.de

On Thursday 11 March 2010 19:58:11 Theodore Tso wrote:
> On Mar 11, 2010, at 8:57 AM, Nikanth Karthikesan wrote:
> > I guess, what he meant was, to keep filesystem blocks aligned, even if
> > the partition is not. Say if the partition is mis-aligned by 512-bytes,
> > let the filesystem waste 4k-512bytes and keep it's blocks aligned. But it
> > might be a case of over-engineering, possibly requiring disk format
> > change.
> 
> Ah, yes, I agree with you; that's probably what he meant.
> 
> Sure, that's theoretically possible, but it would mean changing every
>  single filesystem, and it would require a file system format change --- or
>  at least a file system format extension.
> 
> It would seem to be way easier to simply fix the partitioning tools to do
>  the right thing, though.
> 

Yes. May be, just a simple but transparent device-mapper like mapping on top 
of the mis-aligned partition, to do the alignment. Then the file-system code 
need not change much.

But Linux already has device-mapper and Linux will not be affected with mis-
aligned partitions, when we use LVM.

But the actual problem here is that partitioning tools might create partitions 
that wont allow other operating-systems to boot. So it might be enough, if the 
partitioning tools just create partitions with (mis-)alignment requirement for 
Windows.

Thanks
Nikanth
