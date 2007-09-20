From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 2
Date: Thu, 20 Sep 2007 23:21:39 +0100
Message-ID: <20070920222138.GA3740@srcf.ucam.org>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org> <46F2EE66.9060207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:58666 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbXITWVt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 18:21:49 -0400
Content-Disposition: inline
In-Reply-To: <46F2EE66.9060207@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Sep 20, 2007 at 06:04:22PM -0400, Jeff Garzik wrote:

> the code looks correct.  I have one main reservation.
> 
> how can we be sure that this is active only where other hand-programmed 
> hotplug code is absent?

Yes, that's difficult. As Tejun pointed out, there's missing locking 
here at the moment - if I add that, am I right in thinking that the 
worst case scenario is that the hotplugging path will be called twice?

One option would be to limit this to PATA-style controllers - I'm not 
aware of any mobile hardware shipping with natively hotplug-capable 
controllers, so that would probably do for the moment. If (when) they 
move to AHCI, with luck the native hotplugging will work and we won't 
have to worry about this so much.

The alternative would be to add a flag to the ap structure indicating 
whether the hotplugging is handled by the firmware or not. If we find a 
reference to a controller or port in the firmware tables, it probably 
indicates that the hardware has opinions about how this should be 
handled. We might be safer leaving it to the firmware in those cases, 
and using that flag to skip the controller-specific hotplug code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
