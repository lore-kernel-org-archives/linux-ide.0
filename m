From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] ahci: Use usleep_range() in ahci_start_port()
Date: Thu, 11 Jan 2018 20:22:02 +0200
Message-ID: <20180111182202.GS27654@lahna.fi.intel.com>
References: <20180111125551.61877-1-mika.westerberg@linux.intel.com>
 <20180111125551.61877-2-mika.westerberg@linux.intel.com>
 <20180111181117.GL3460072@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18306 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934462AbeAKSWF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 11 Jan 2018 13:22:05 -0500
Content-Disposition: inline
In-Reply-To: <20180111181117.GL3460072@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Thu, Jan 11, 2018 at 10:11:17AM -0800, Tejun Heo wrote:
> On Thu, Jan 11, 2018 at 03:55:51PM +0300, Mika Westerberg wrote:
> > Using msleep(1) may actually sleep much longer than 1 msecs (~20 msecs)
> > which unnecessarily slows down system startup. Avoid that and use
> > usleep_range() instead.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Heh, I'm not sure.  How big of a problem is this?

It's not a big problem so you may ignore the patch if you think it is
not needed. I just noticed the msleep(1) there and though we could do
better using usleep_range().
