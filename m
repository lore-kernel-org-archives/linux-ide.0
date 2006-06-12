From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Maybe a corrupted BIOS?
Date: Mon, 12 Jun 2006 02:58:56 -0400
Message-ID: <448D10B0.5000703@garzik.org>
References: <1150087543.5721.49.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:23943 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751030AbWFLG67 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 02:58:59 -0400
In-Reply-To: <1150087543.5721.49.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hi, Jeff
> 
> I encountered a tricky problem. Let me described it from start.
> 
> This morning I applied the "AHCI suspend/resume" patch against latest
> #upstream without much modification, then after a round of suspend/
> resume, then system can't boot from AHCI mode, also can't boot from
> "enhanced mode with AHCI disabled". But it can boot from "compatible
> mode" with ata_piix driver to drive the hardware.
> 
> So now I'm totally clueless about how to make AHCI mode come back to
> life. It seems that I need to trigger a low-level re-initialization of
> SATA controller. Have you ever met such weird behavior before?

I've seen things like this...

* sometimes testing can lead to a loss of BIOS NVRAM.  Running BIOS's 
'restore to defaults' usually fixes this.

* sometimes testing can fry your BIOS battery, or the battery may just 
die.  get a new battery.

* sometimes the hardware just "needs a breather", like Tejun described. 
  Power off the machine, unplug it, unplug the ethernet cable, and let 
it sit for a little while.


