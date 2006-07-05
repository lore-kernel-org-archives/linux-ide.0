From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 0/6] AHCI suspend/resume support --take3
Date: Wed, 05 Jul 2006 10:45:11 +0800
Message-ID: <1152067511.7132.233.camel@forrest26.sh.intel.com>
References: <1151569086.7132.220.camel@forrest26.sh.intel.com>
	 <20060704124132.GB4075@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41996 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932349AbWGEC7K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 22:59:10 -0400
In-Reply-To: <20060704124132.GB4075@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: jgarzik@pobox.com, htejun@gmail.com, hare@suse.de, linux-ide@vger.kernel.org

On Tue, 2006-07-04 at 14:41 +0200, Jens Axboe wrote:
> It's not working for me, I get -EBUSY errors on resume from both
> ahci_port_spinup() and ahci_start_engine() and things just hang from
> there.

I know that it's not easy to capture dmesg log when SATA resume
operation failed. So I posted the dmesg log during AHCI suspend/resume
on my development machine to
http://www.infradead.org/~forrest/suspend-resume-dmesg/dmesg

Would you please tell me the difference between your dmesg log and mine?
That would be helpful for me to root-cause the bug.

Thanks,
Forrest
