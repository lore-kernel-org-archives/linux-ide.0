From: Jens Axboe <axboe@suse.de>
Subject: Re: rolled up patch for new Power Management for libata
Date: Mon, 19 Jun 2006 07:46:18 +0200
Message-ID: <20060619054618.GE3456@suse.de>
References: <11501274284082-git-send-email-htejun@gmail.com> <20060613090945.GA8931@htj.dyndns.org> <20060613103830.GG4420@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:6433 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750922AbWFSFpc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2006 01:45:32 -0400
Content-Disposition: inline
In-Reply-To: <20060613103830.GG4420@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Tue, Jun 13 2006, Jens Axboe wrote:
> On Tue, Jun 13 2006, Tejun Heo wrote:
> > This is a rolled up version of new-pm patchset for testing as
> > requested by Jens.
> 
> Patch works great for me. Only tested one resume cycle so far, but it
> worked and was much quicker than before.

Notebook hasn't been booted since, so I can confirm it's very reliable.
No issues seen so far, and I'm enjoying the snappier resume.

-- 
Jens Axboe

