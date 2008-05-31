From: "Tuc at T-B-O-H.NET" <ml@t-b-o-h.net>
Subject: Re: Correct partition table geometry?(Story included)
Date: Sat, 31 May 2008 17:28:46 -0400 (EDT)
Message-ID: <200805312128.m4VLSkwi047400@himinbjorg.tucs-beachin-obx-house.com>
References: <484146EF.7090302@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vjofn.tucs-beachin-obx-house.com ([204.107.90.128]:2466 "EHLO
	vjofn.tucs-beachin-obx-house.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751812AbYEaVbh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 May 2008 17:31:37 -0400
In-Reply-To: <484146EF.7090302@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Tuc at T-B-O-H.NET" <ml@t-b-o-h.net>, linux-ide@vger.kernel.org

> 
> Tuc at T-B-O-H.NET wrote:
> >
> > Disk /dev/hdb: 500.1 GB, 500107862016 bytes
> > 255 heads, 63 sectors/track, 60801 cylinders
> > Units = cylinders of 16065 * 512 = 8225280 bytes
> > 
> >    Device Boot      Start         End      Blocks   Id  System
> > /dev/hda1   *           1         127     1020096   83  Linux
> > /dev/hda2             128         185      465885   82  Linux swap
> > /dev/hda3             186         312     1020127+  83  Linux
> > /dev/hda4             313        9729    75642052+   5  Extended
> > /dev/hda5             313         439     1020096   83  Linux
> > /dev/hda6             440        1714    10241406   83  Linux
> ..
> 
> You could fire up fdisk, delete hda6, hda5, hda4,
> then recreate hda4 extending over the entire free space,
> then recreate hda5, hda6 *exactly* as before (above),
> and then hda7 with the remaining free space.
> And only *then* commit the changes to disk.
> 
> No need to reformat hda5,hda6 this way, their contents will
> survive the repartitioning if they are recreated exactly
> as before.
> 
> Done.  Entire disk now accessible.
> 
> But personally, I wouldn't do this.  I'd just create a new
> partition scheme that makes more sense, and then file-copy
> everything over from the old 80GB drive to the new scheme,
> re-run grub-install on the new drive, and be done with it.
> 
Hi,

	Thanks for the reply. Yea, I thought later I could
look at it just fdisking in memory. Turns out it did open up
once I deleted the extended. I'm a bit leary about placing 
the 5+6 back where they were. Since the disk partition table
was DD'd, not fdisk'd, I'd be concerned the boundary would
be the EXACT same place. I actually ended up deleting the
whole table up until hdb1, and recreating swap down. mkswap
and "mk2fs -t ext3" and copied everything over. 

	In effect I pretty much did that, leaving only the
hdb1 intact (And the partition table). I'm going to run
some more copies and then we'll swap it over to the primary
and go from there.

	Thanks!

		Tuc
