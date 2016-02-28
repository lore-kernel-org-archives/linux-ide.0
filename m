From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] AHCI: Remove obsolete Intel Lewisburg SATA RAID device
 IDs
Date: Sun, 28 Feb 2016 08:16:46 -0500
Message-ID: <20160228131646.GK3965@htj.duckdns.org>
References: <1456510192-27184-1-git-send-email-scott.lawson@intel.com>
 <20160227085154.GB26010@infradead.org>
 <20160227111855.GW3965@htj.duckdns.org>
 <20160228131003.GA21800@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34643 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757071AbcB1NQs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2016 08:16:48 -0500
Content-Disposition: inline
In-Reply-To: <20160228131003.GA21800@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: scott.lawson@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 28, 2016 at 05:10:03AM -0800, Christoph Hellwig wrote:
> On Sat, Feb 27, 2016 at 06:18:55AM -0500, Tejun Heo wrote:
> > On Sat, Feb 27, 2016 at 12:51:54AM -0800, Christoph Hellwig wrote:
> > > On Fri, Feb 26, 2016 at 10:09:52AM -0800, scott.lawson@intel.com wrote:
> > > > From: Scott Lawson <scott.lawson@intel.com>
> > > > 
> > > > These PCI device IDs have been removed from the Intel Lewisburg design
> > > > specification. They are no longer needed.
> > > 
> > > Let's keep them just in case..
> > 
> > Out of curiosity, any specific reasons to do so?
> 
> If it's been added to the driver I'd expect at least prototype hardware
> to already be out there.

I see.  Scott, can you please clarify the situation?

Thanks.

-- 
tejun
