From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Questions about SATA hotplug in linux 2.6
Date: Thu, 25 Oct 2007 22:41:23 -0400
Message-ID: <472153D3.2020102@garzik.org>
References: <20071025.011445.80152909.davem@davemloft.net> <472052C1.2050302@garzik.org> <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55837 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846AbXJZClZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 22:41:25 -0400
In-Reply-To: <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <Shane.Huang@amd.com>
Cc: linux-ide@vger.kernel.org

Shane Huang wrote:
> 1. If users unplug one SATA HDD(no-root partition) or SATA ODD when
> the system is running, then plug it back to the same SATA port,
> Should the system and SATA HDD/ODD still work well?

Yes.

> 2. How about users plug the SATA HDD/ODD in a different SATA port?
> Should it still work?

Yes.

For all hotplug-aware libata drivers, you should be able to unplug a 
SATA device _while_ it is actively reading or writing data, with no ill 
effects to the kernel.

You might lose cached and in-flight data of course, and userspace 
applications may or may not handle the disappearance of their underlying 
filesystem with grace and aplomb :)

But device hotplug should be reliable from a kernel standpoint [assuming 
driver support].


> These questions come up when our QA test our SB700 SATA drivers,
> but I don't know the SATA hotplug support in linux 2.6.
> Is there any guy who can give some official confirmation? :-)

The main thing of note with regards to hotplug is that the associated 
device (/dev/sdb, /dev/scd0, etc.) may change between plug and unplug. 
For example, if you unplug a SATA HDD then plug it back in, the user 
might see /dev/sdb disappear, and /dev/sdd appear -- even if it is the 
exact same HDD, on the exact same port.

	Jeff


