From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 2
Date: Fri, 21 Sep 2007 03:42:15 +0100
Message-ID: <20070921024214.GA6317@srcf.ucam.org>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org> <46F2EE66.9060207@garzik.org> <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:49930 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbXIUCm1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 22:42:27 -0400
Content-Disposition: inline
In-Reply-To: <46F32DD9.7010509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Sep 21, 2007 at 11:35:05AM +0900, Tejun Heo wrote:
> Matthew Garrett wrote:
> > The alternative would be to add a flag to the ap structure indicating 
> > whether the hotplugging is handled by the firmware or not. If we find a 
> > reference to a controller or port in the firmware tables, it probably 
> > indicates that the hardware has opinions about how this should be 
> > handled. We might be safer leaving it to the firmware in those cases, 
> > and using that flag to skip the controller-specific hotplug code.
> 
> I was thinking the other way around.  I'd rather depend on hardware
> provided events than firmware provided ones.  How about flagging drivers
> which can do native hoplugging and using ACPI hotplugging only if the
> driver can't do it natively?

If the manufacturers have added firmware-level hotswap interrupts, then 
there's all sorts of insane ways they might have wired the bay up. I 
don't really trust them to have managed to do so without breaking native 
hotplug :) It doesn't really matter at the moment, though, since I 
haven't actually seen any examples of hardware using anything that can 
manage native hotplug. If anyone out there does have one, it would be 
nice to get some feedback about what it does.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
