From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook
 IDE controller
Date: Wed, 02 Dec 2009 08:27:56 +0900
Message-ID: <4B15A67C.2030102@kernel.org>
References: <20091201070834.6A840B7B63@ozlabs.org>	 <4B14CD22.4020806@kernel.org> <1259709552.2076.1053.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45685 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304AbZLAX0a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 18:26:30 -0500
In-Reply-To: <1259709552.2076.1053.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>, Holger Macht <hmacht@suse.de>

Hello,

On 12/02/2009 08:19 AM, Benjamin Herrenschmidt wrote:
>> I think you'll need an ata_port_freeze() or abort() here because at
>> this point the drive is already gone and all in-flight commands need
>> to be failed right away.  Holger, do you remember why
>> ata_acpi_detach_device() is using ata_port_schedule_eh() instead?  Was
>> it because ata_port_freeze() might end up poking registers after
>> hotunplug happened?  ISTR reports where accessing any register there
>> causing the whole system to lock up but then why can't it use
>> ata_port_abort() instead?
> 
> I'll try. Which one ? freeze or abort tho ?

Conceptually freeze would be more approriate but the side effect is
that the port is frozen and EH will try to thaw it by resetting it.
So, abort would work better.

Thanks.

-- 
tejun
