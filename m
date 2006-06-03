From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/6] The definition of ahci_start_fis_rx() and ahci_stop_fis_rx()
Date: Sat, 3 Jun 2006 15:10:09 -0400
Message-ID: <20060603191009.GA27742@havoc.gtf.org>
References: <1149234295.13451.54.camel@forrest26.sh.intel.com> <20060603125120.GB25958@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:15813 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751773AbWFCTQ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jun 2006 15:16:56 -0400
Content-Disposition: inline
In-Reply-To: <20060603125120.GB25958@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, hare@suse.de, axboe@suse.de, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Sat, Jun 03, 2006 at 09:51:20PM +0900, Tejun Heo wrote:
> Please convert to ata_wait_register().  Also, I share Jens' opinion.
> The way I read the spec is that the timeout should be at least 500ms
> not that we have to wait 500ms before polling for !FIS_ON.

Correct.

	Jeff


P.S. FWIW I'm still travelling.  Have email, but no merges until June 8.
