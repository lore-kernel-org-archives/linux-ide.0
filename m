From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 10:20:19 -0500
Message-ID: <4D52B0B3.40900@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:58405 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab1BIPUW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 10:20:22 -0500
In-Reply-To: <20110209085935.GE6558@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/9/2011 3:59 AM, Tejun Heo wrote:
> Fakeraids, awesome as always.  So, they fail if the member disks are
> unlocked?  Aiee...

Since the metadata is stored relative to the end of the disk, yes,
unlocking it causes its position to change.  The same problem should
apply to mdadm, though the odds are much higher that when mdadm created
the array, it was also running on a kernel that unlocked the HPA.

> The decision to unlock native capacity is made at the block layer
> where the native capacity is unknown and then when the driver method
> is called it doesn't know how long the partition table wants.  Of
> course, we can change things such that the length partition table
> wants is propagated downwards but I don't know.  How big a problem is
> it?  Does the problem happen with a lot of fakeraids?  Maybe a better
> way is to export BIOS size and let fakeraid use it?

It is a big problem for anyone using fakeraid ( which is quite popular
these days ) and has a bios that enables the HPA.  I think this is a
better solution because aside from the problems it causes to fakeraid,
unlocking the HPA defies the relevant standards and will trash whatever
data the bios is storing there, which is not good either.  Hence why I
am in favor of the idea of only unlocking the HPA if it is clear that
the disk was partitioned with a previously broken kernel and so it must
be unlocked to access existing user data.  That is why I like this
commit, but it misses the mark in raid situations where the MBR is
visible on the raw disk, but really is supposed to apply to the whole raid.

