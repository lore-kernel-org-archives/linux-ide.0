From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 16:54:40 +0800
Message-ID: <1150188880.7132.44.camel@forrest26.sh.intel.com>
References: <11501274293403-git-send-email-htejun@gmail.com>
	 <1150186634.7132.34.camel@forrest26.sh.intel.com>
	 <448E7EA3.8070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51851 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750807AbWFMJGu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 05:06:50 -0400
In-Reply-To: <448E7EA3.8070707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Tue, 2006-06-13 at 18:00 +0900, Tejun Heo wrote:
> If ata_pci_device_suspend/resume() do things incorrect for a 
> controller(), export ata_host_set_suspend/resume() and call those from 
> LLD's suspend/resume() routines.
> 

OK. I'll export them in the upcoming AHCI suspend/resume patches.

Thanks,
Forrest
