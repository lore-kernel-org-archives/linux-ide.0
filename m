From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] ahci: add support for VIA VT8251
Date: Tue, 11 Apr 2006 18:16:04 -0400
Message-ID: <443C2AA4.7090303@garzik.org>
References: <200604111915.45564.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39572 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751155AbWDKWQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 18:16:07 -0400
In-Reply-To: <200604111915.45564.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: linux-ide@vger.kernel.org

Bastiaan Jacques wrote:
> This patch adds AHCI support for the VIA VT8251 chipset. The patch does so by:
> 	1) Adding the PCI device ID.
> 	2) Adding a workaround in ahci_probe_reset() for a VIA hardware bug.
> 
> Signed-off-by: Bastiaan Jacques <b.jacques@planet.nl>
> ---
> 
> The patch is based upon the patch[1] provided by VIA. With the softreset and 
> probing work that has been merged, this patch has become much simpler.
> 
> I am happy to report that without the workaround in ahci_probe_reset(), the 
> chipset works quite well; both my SATA drives are recognised. However, 
> softreset does not work (but hardreset does), and ata_std_probeinit delays, 
> for my primary SATA drive/port,  due to the "busy" bug. A Command List 
> Override will unbusy the drive/port.
> 
> Since the CLO sequence also appears in ahci_softreset(), I have moved that 
> code into a new ahci_clo() function.
> 
> This patch is against 2.6.17-rc1 (and -mm2).
> 
> This patch has only been tested by yours truly. Whilst I am waiting for 
> feedback from other people, I am sending this patch to solicit comments.

Thanks for doing this.  VIA AHCI support was indeed waiting on Tejun's 
EH work.

Would you please resubmit the latest version of your patch including a 
Signed-off-by line, per guidelines at 
http://linux.yyz.us/patch-format.html ?

	Jeff


