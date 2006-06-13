From: Jens Axboe <axboe@suse.de>
Subject: Re: rolled up patch for new Power Management for libata
Date: Tue, 13 Jun 2006 12:38:30 +0200
Message-ID: <20060613103830.GG4420@suse.de>
References: <11501274284082-git-send-email-htejun@gmail.com> <20060613090945.GA8931@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:62471 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750847AbWFMKiK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2006 06:38:10 -0400
Content-Disposition: inline
In-Reply-To: <20060613090945.GA8931@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Tue, Jun 13 2006, Tejun Heo wrote:
> This is a rolled up version of new-pm patchset for testing as
> requested by Jens.

Patch works great for me. Only tested one resume cycle so far, but it
worked and was much quicker than before.

-- 
Jens Axboe

