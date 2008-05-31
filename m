From: Mark Lord <liml@rtr.ca>
Subject: Re: Correct partition table geometry?(Story included)
Date: Sat, 31 May 2008 08:39:11 -0400
Message-ID: <484146EF.7090302@rtr.ca>
References: <200805310238.m4V2chKZ034543@himinbjorg.tucs-beachin-obx-house.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4160 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbYEaMjO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 May 2008 08:39:14 -0400
In-Reply-To: <200805310238.m4V2chKZ034543@himinbjorg.tucs-beachin-obx-house.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Tuc at T-B-O-H.NET" <ml@t-b-o-h.net>
Cc: linux-ide@vger.kernel.org

Tuc at T-B-O-H.NET wrote:
>
> Disk /dev/hdb: 500.1 GB, 500107862016 bytes
> 255 heads, 63 sectors/track, 60801 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/hda1   *           1         127     1020096   83  Linux
> /dev/hda2             128         185      465885   82  Linux swap
> /dev/hda3             186         312     1020127+  83  Linux
> /dev/hda4             313        9729    75642052+   5  Extended
> /dev/hda5             313         439     1020096   83  Linux
> /dev/hda6             440        1714    10241406   83  Linux
..

You could fire up fdisk, delete hda6, hda5, hda4,
then recreate hda4 extending over the entire free space,
then recreate hda5, hda6 *exactly* as before (above),
and then hda7 with the remaining free space.
And only *then* commit the changes to disk.

No need to reformat hda5,hda6 this way, their contents will
survive the repartitioning if they are recreated exactly
as before.

Done.  Entire disk now accessible.

But personally, I wouldn't do this.  I'd just create a new
partition scheme that makes more sense, and then file-copy
everything over from the old 80GB drive to the new scheme,
re-run grub-install on the new drive, and be done with it.

Cheers

