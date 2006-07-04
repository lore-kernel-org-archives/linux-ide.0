From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 0/6] AHCI suspend/resume support --take3
Date: Tue, 4 Jul 2006 14:41:33 +0200
Message-ID: <20060704124132.GB4075@suse.de>
References: <1151569086.7132.220.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:29724 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932246AbWGDMj0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jul 2006 08:39:26 -0400
Content-Disposition: inline
In-Reply-To: <1151569086.7132.220.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, linux-ide@vger.kernel.org

On Thu, Jun 29 2006, zhao, forrest wrote:
> Hi, all
> 
> This is the take 3 of AHCI suspend/resume patches.
> 
> The patch is against #upstream[
> 2154cfa6ba560401d25f6cc083fe3fb996cbb571] + Tejun's Power Management
> patch(available at
> http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=new-pm).
> 
> Although Tejun's PM patch may change as he mentioned in another mail,
> such change is minor and will not impact the logic of AHCI suspend/
> resume. So I re-send the patch in order to get test feedback and review
> comments earlier.
> 
> Compared with last version, all the changes are in [PATCH 6/6]. In
> particular, I made changes to the sixth patch to integrate it with
> Tejun's PM patch.

It's not working for me, I get -EBUSY errors on resume from both
ahci_port_spinup() and ahci_start_engine() and things just hang from
there.

-- 
Jens Axboe

