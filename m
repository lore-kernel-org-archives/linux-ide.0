From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 0/6] AHCI suspend/resume support --take3
Date: Wed, 5 Jul 2006 08:49:43 +0200
Message-ID: <20060705064943.GA14372@suse.de>
References: <1151569086.7132.220.camel@forrest26.sh.intel.com> <20060704124132.GB4075@suse.de> <1152067511.7132.233.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:10580 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751151AbWGEGrr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jul 2006 02:47:47 -0400
Content-Disposition: inline
In-Reply-To: <1152067511.7132.233.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, linux-ide@vger.kernel.org

On Wed, Jul 05 2006, zhao, forrest wrote:
> On Tue, 2006-07-04 at 14:41 +0200, Jens Axboe wrote:
> > It's not working for me, I get -EBUSY errors on resume from both
> > ahci_port_spinup() and ahci_start_engine() and things just hang from
> > there.
> 
> I know that it's not easy to capture dmesg log when SATA resume
> operation failed. So I posted the dmesg log during AHCI suspend/resume
> on my development machine to
> http://www.infradead.org/~forrest/suspend-resume-dmesg/dmesg
> 
> Would you please tell me the difference between your dmesg log and mine?
> That would be helpful for me to root-cause the bug.

I will try and dump the ahci/libata messages on resume, just by writing
them down (there aren't that many).

-- 
Jens Axboe

