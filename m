From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: updated new EH and hotplug support are about to be posted...
Date: Fri, 14 Apr 2006 10:46:35 +0800
Message-ID: <1144982795.19687.35.camel@localhost.localdomain>
References: <20060411130849.GA25147@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23069 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751222AbWDNC4n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Apr 2006 22:56:43 -0400
In-Reply-To: <20060411130849.GA25147@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, axboe@htj.dyndns.org, Albert Lee <albertcc@tw.ibm.com>, Lukasz Kosewski <lkosewsk@gmail.com>, linux-ide@vger.kernel.org

On Tue, 2006-04-11 at 22:08 +0900, Tejun Heo wrote:
> Hello, people.
> 
> It's been another looooooong week.  Build number of my ATA work tree,
> which was created at the end of Feburary, is now over 1040 and all my
> SATA plugs are worn and unplug easily.  But, hey, hotplug works now.
> 
> I'm about to post the following 9 patchsets composed of 97 patches.
> The first two patchsets have been posted previously but I'll repost
> them for simplicity's sake.
> 
> 1. misc-reset-updates			: repost (3 patches)
> 2. implement-and-use-ata_wait_register	: repost (5 patches)
> 3. misc-ata_bus_probe-updates		: take 1 (3 patches)
> 4. fixes-errata-workaround-and-reset-updates : take 3 (13 patches)
> 5. new-EH-framework			: take 2 (16 patches)
> 6. new-EH-implementation		: take 2 (14 patches)
> 7. add-NCQ-support			: take 3 (15 patches)
> 8. prep-for-hotplug-support		: take 1 (15 patches)
> 9. add-hotplug-support			: take 1 (13 patches)
> 

Tejun,

Where can I find your git tree, which includes all the above
patch sets? We're preparing to test SATA hotplug in our lab.

BTW. Is there a way to check whether SATA controller support
hotplug, such as a capability bit in certain register?
Or we have to first enable PHY status changed interrupt, then
hotplug the SATA disk, then to check if the interrupt is triggered,
and PHY RDY status changes?

I read AHCI 1.1 spec, and didn't find such capability bit.

Thanks,
Forrest
