From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH alt4 v3] libata resume fixes
Date: Mon, 29 May 2006 11:53:13 +0800
Message-ID: <1148874794.2310.21.camel@forrest26.sh.intel.com>
References: <20060527195847.GA28334@havoc.gtf.org>
	 <20060527205213.GA30686@havoc.gtf.org> <4478BD18.6010908@rtr.ca>
	 <4478C0A1.4050003@rtr.ca>  <4478C2C9.3030703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28702 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751160AbWE2EEs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 00:04:48 -0400
In-Reply-To: <4478C2C9.3030703@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, torvalds@osdl.org

On Sat, 2006-05-27 at 17:21 -0400, Jeff Garzik wrote:
> o_simple_cmd: ata command failed: 4
> 
> 0xE1 is IDLE IMMEDIATE, so it looks like it is making progress.
> 
> This makes me realize that ata_bus_probe() won't get the job done
> alone, 
> we must do:
> 
> * host init
> * phy init
> * idle immediate
> * the rest of bus probe
> 
> Good, good data points here...

Jeff,

This observation is very valuable. I'll write the patch for this
together with the AHCI suspend/resume support for 2.6.1[8/9] soon.

BTW. Have we achieved consensus that the bus resume operation should be
done in [s/p]ata_pci_device_resume() in 2.6.1[8/9]?

Thanks,
Forrest
