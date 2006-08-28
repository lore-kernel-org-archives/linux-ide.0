From: Jim Paris <jim@jtan.com>
Subject: Re: Port multiplier
Date: Mon, 28 Aug 2006 11:35:54 -0400
Message-ID: <20060828153554.GA4471@jim.sh>
References: <44F2984F.6030100@clear.net.nz> <44F2EA27.9090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:29411 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S1750719AbWH1PgF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2006 11:36:05 -0400
Content-Disposition: inline
In-Reply-To: <44F2EA27.9090603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Richard Scobie wrote:
>
> >Can I unmount the connected and mounted array and just unplug the array
> >with no further concern?
> 
> The machine will survive and detach the device correctly but 
> yet-unwritten data will be lost.

He said he'll unmount it first, so presumably that should avoid most
data loss?  I suppose if you're in the middle of a RAID resync, or
just ran fdisk or fsck or similar, you could still have unflushed
data.  Does that mean that hot-unplug is not recommended, and one
should always do warm-unplug instead?

-jim
