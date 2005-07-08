From: Jens Axboe <axboe@suse.de>
Subject: Re: Readahead with softraid1
Date: Fri, 8 Jul 2005 14:05:39 +0200
Message-ID: <20050708120538.GH7050@suse.de>
References: <1120824029.23681.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:18565 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262494AbVGHMED (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2005 08:04:03 -0400
Content-Disposition: inline
In-Reply-To: <1120824029.23681.18.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

On Fri, Jul 08 2005, Erik Slagter wrote:
> Hi,
> 
> I am using softraid 1 on two sata disks and I'm trying to get the best
> possible performance. IMHO read actions (if properly addressed) should
> be split over the two drivers and performed independently. However, I
> don't notice anything to back this up. The read performance (with the
> dreaded hdparm) shows read performance on sda,sdb and md0 exactly the
> same.
> 
> I've been playing a bit with readahead and it does matter a bit in that
> if I disable readahead for sda/sdb completely, the read rate for these
> goes completely down (to be expected) whilst the read rate on md0 stays
> the same (also a bit to be expected). Other combinations do not show any
> significant impact.
> 
> I also played with the i/o scheduler and nr_requests (as from previous
> messages here).
> 
> What am I doing wrong here???

raid1 doesn't split reads, currently you need more than one process
doing io to get a performance increase.

-- 
Jens Axboe

