From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: updated new EH and hotplug support are about to be posted...
Date: Thu, 13 Apr 2006 23:30:56 -0400
Message-ID: <443F1770.1040403@pobox.com>
References: <20060411130849.GA25147@htj.dyndns.org> <1144982795.19687.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43231 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751242AbWDNDbF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 23:31:05 -0400
In-Reply-To: <1144982795.19687.35.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, axboe@htj.dyndns.org, Albert Lee <albertcc@tw.ibm.com>, Lukasz Kosewski <lkosewsk@gmail.com>, linux-ide@vger.kernel.org

zhao, forrest wrote:
> BTW. Is there a way to check whether SATA controller support
> hotplug, such as a capability bit in certain register?

For AHCI, all controllers support hotplug.

Most SATA controllers support hotplug, across all vendors.

If you're lucky, silicon has a phy interrupt.  If you're somewhat lucky, 
silicon has a PhyRdy state interrupt.  If you're stuck with a BMDMA 
interface with bolted-on SATA PHY registers, hotplug will -probably- work.


> Or we have to first enable PHY status changed interrupt, then
> hotplug the SATA disk, then to check if the interrupt is triggered,
> and PHY RDY status changes?

The interrupt is quite helpful, but ultimately optional.

	Jeff


