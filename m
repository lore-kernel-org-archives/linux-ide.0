From: Nikanth Karthikesan <knikanth@suse.de>
Subject: Re: ATA 4 KiB sector issues.
Date: Thu, 11 Mar 2010 19:27:24 +0530
Message-ID: <201003111927.24829.knikanth@suse.de>
References: <4B947393.2050002@kernel.org> <4B97C6A5.4010209@tvk.rwth-aachen.de> <17BB1CC0-9B13-401D-B6AA-90365208A042@mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60833 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755867Ab0CKN4M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Mar 2010 08:56:12 -0500
In-Reply-To: <17BB1CC0-9B13-401D-B6AA-90365208A042@mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Damian Lukowski <damian@tvk.rwth-aachen.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Matthew Wilcox <matthew@wil.cx>, "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Mark Lord <kernel@teksavvy.com>, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, aschnell@suse.de, jdelvare@suse.de

On Thursday 11 March 2010 18:34:56 Theodore Tso wrote:
> On Mar 10, 2010, at 11:19 AM, Damian Lukowski wrote:
> > I have practically no knowledge of Linux' block device drivers,
> > but is this really a partitioning issue? I think the problem is
> > with the filesystems when clustering multiple blocks without
> > knowledge of the sector alignment and sector size of the underlying
> > block device. Maybe it is a better solution to adapt the filesystem
> > buffer routine which reads/writes data from/to the block device?
> 
> No, it's really a partitioning issue.   If the paging subsystem wants a 4k
>  block to fill a particular page, we need to read that 4k block into
>  memory.  If we need to swap out that 4k block, we need to write that 4k
>  block to swap space, or to the memory segment's backing store.   If the
>  partition is misaligned by 512 bytes, this is simply not possible.   The
>  file system has to do what is requested of it by its users, and the
>  reality is that we need to do 4k aligned reads and writes with respect to
>  the beginning of the partition, far more often than not.
> 
> Hence, if we want the best performance on 4k sector drives, the partition
>  needs to be aligned with respect to what is most desirable for the device
>  in question.
> 

I guess, what he meant was, to keep filesystem blocks aligned, even if the 
partition is not. Say if the partition is mis-aligned by 512-bytes, let the 
filesystem waste 4k-512bytes and keep it's blocks aligned. But it might be a 
case of over-engineering, possibly requiring disk format change.

Thanks
Nikanth
