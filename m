From: Christoph Hellwig <hch@lst.de>
Subject: Re: raid5-cache I/O path improvements
Date: Tue, 8 Sep 2015 17:40:06 +0200
Message-ID: <20150908154006.GA2795@lst.de>
References: <1441603250-5119-1-git-send-email-hch@lst.de> <20150908002840.GA3196542@devbig257.prn2.facebook.com> <20150908061215.GA23833@lst.de> <20150908152546.GB13749@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34454 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740AbbIHPkI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Sep 2015 11:40:08 -0400
Content-Disposition: inline
In-Reply-To: <20150908152546.GB13749@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shli@fb.com>, neilb@suse.de, linux-raid@vger.kernel.org, Kernel-team@fb.com, dan.j.williams@intel.com, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

On Tue, Sep 08, 2015 at 11:25:46AM -0400, Tejun Heo wrote:
> IIRC, some controllers and/or controllers were choking on it and it
> didn't make any noticeable difference on rotating disks.  Maybe we can
> try again with controller white list and enabling by default on SSds.

I guess we could start with AHCI only as a good approximation for a not
too crappy controller and driver.
