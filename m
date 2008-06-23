From: Felix Miata <mrmazda@ij.net>
Subject: Re: [RFC] Separating out libata out of SCSI (finally)
Date: Mon, 23 Jun 2008 17:56:45 -0400
Message-ID: <48601C1D.1040508@ij.net>
References: <485B2CC6.6070201@kernel.org>	 <1213993737.3443.35.camel@localhost.localdomain>	 <485C31FE.8050408@garzik.org>	 <87f94c370806231404t13586777x7f7bee24ebe25ffc@mail.gmail.com> <1214255460.3310.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fall-lakeland.atl.sa.earthlink.net ([207.69.195.103]:45357 "EHLO
	fall-lakeland.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753332AbYFWWIS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 18:08:18 -0400
In-Reply-To: <1214255460.3310.27.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <jens.axboe@oracle.com>

On 2008/06/23 16:11 (GMT-0500) James Bottomley apparently typed:

> On Mon, 2008-06-23 at 17:04 -0400, Greg Freemyer wrote:

>> I've seen a lot of end user complaints about libata only supporting
>> 15(14?) partitions.  Will that limit be moved back to the traditional
>> drivers/ide limit as part of this?

> Number of partitions is directly related to number of minors, so it
> can't be changed without a change in the allocation of major/minor space
> in sd ... that could only be done compatibly by permuting the space.
> The only other way to do it is incompatibly by changing major (again).

I don't know what permuting the space means, but I do know libata affects me
in a very big way, being dependent on cross platform tools for partitioning,
backup, & restoration; and multibooting virtually every system I touch. LVM
is simply no option for these systems, and I have yet to determine whether
and how kpartx and device mapper might be used to mitigate the problems
caused by trying to work within libata's SCSI limit, a limit which is a major
reason why I ceased trying to use SCSI over 5 years ago when disks got too
big for few partitions. I've ceased trying to use Fedora & *buntu on more
than a cursory basis, using mostly SUSE and Mandriva because they still
provide the option to use legacy drivers in their default kernels.

Isn't libata at some point supposed to completely displace the legacy IDE
driver set? If so, at some point couldn't the IDE major be recycled for
libata use for devices >15, or even all of them, maybe in the interim via a
compile time choice between either legacy or major 3 but never both
simultaneously?
-- 
"Where were you when I laid the earth's
foundation?"		       Matthew 7:12 NIV

 Team OS/2 ** Reg. Linux User #211409

Felix Miata  ***  http://fm.no-ip.com/
