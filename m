From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM II
Date: Tue, 20 Nov 2007 20:07:02 +0100
Message-ID: <20071120190702.GB6586@kernel.dk>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <47423245.1050109@gmail.com> <alpine.LFD.0.9999.0711201559520.25057@localhost.localdomain> <200711201736.02957.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:8771 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757482AbXKTTHI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Nov 2007 14:07:08 -0500
Content-Disposition: inline
In-Reply-To: <200711201736.02957.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>, Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org

On Tue, Nov 20 2007, Andi Kleen wrote:
> 
> > Which in turn enables the iommu_merge functionality in gart_map_sg().
> 
> > 	for_each_sg(sg, s, nents, i) {
> 
> Hmm, another thought. Maybe this code just has trouble with the new 
> linked SG lists and it's not really a SB600 problem?
> 
> I did a quick test on two ATI machines with older chipset and
> iommu=force,merge and it didn't show a problem though.

chained sg lists aren't enabled on libata, so it should not affect
libata drivers.

-- 
Jens Axboe

