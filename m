From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 9 Feb 2011 09:59:35 +0100
Message-ID: <20110209085935.GE6558@htj.dyndns.org>
References: <4D51A648.20707@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53733 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1BII7l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 03:59:41 -0500
Received: by bwz15 with SMTP id 15so715097bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2011 00:59:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D51A648.20707@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

On Tue, Feb 08, 2011 at 03:23:36PM -0500, Phillip Susi wrote:
> It still causes problems with fakeraid striped arrays however, because
> it detects the partition table on the primary disk, sees partitions
> beyond the end, and chooses to unlock the HPA to attempt to access those
> partitions.  This breaks the fakeraid array since the raid metadata left
> by the bios uses the HPA geometry, which becomes incorrect when the HPA
> is unlocked.

Fakeraids, awesome as always.  So, they fail if the member disks are
unlocked?  Aiee...

> I propose a slight refinement of the method introduced in this patch.
> Rather than unlock the HPA if a partition goes beyond the end of the
> current disk, it should check to make sure that doing so will actually
> make that partition fully accessible, and don't bother unlocking if it
> won't.

The decision to unlock native capacity is made at the block layer
where the native capacity is unknown and then when the driver method
is called it doesn't know how long the partition table wants.  Of
course, we can change things such that the length partition table
wants is propagated downwards but I don't know.  How big a problem is
it?  Does the problem happen with a lot of fakeraids?  Maybe a better
way is to export BIOS size and let fakeraid use it?

Thanks.

-- 
tejun
