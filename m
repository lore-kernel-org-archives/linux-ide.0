From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 10:18:05 +0100
Message-ID: <20060126091805.GO4212@suse.de>
References: <20060126055050.GA4737@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:7515 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932130AbWAZJTU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 04:19:20 -0500
Content-Disposition: inline
In-Reply-To: <20060126055050.GA4737@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Nicolas.Mailhot@LaPoste.net, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Thu, Jan 26 2006, Tejun Heo wrote:
> Hello, Nicolas.  Hello, all.
> 
> Nicolas, I'm probably the guy who broke your filesystem.  :-p This FUA
> (forced-unit-access)thing made into the mainline lately, and it seems
> that your drive is reporting FUA support but doesn't really do it
> properly when it's asked to.

It's strange. I have 3 out of 4 drives in a box here reporting FUA
capability, and I have now tested all three of them both with plain FUA
writes and NCQ FUA tagged writes. I used data integrity verifying
writes, and the data is sound as well. fs likewise, I used ext3 mounted
with barriers enabled.

What exact model drive is this? It could also be a raid funny. Tejuns
proposal with testing the drive alone with ext3+barriers is a good one.

-- 
Jens Axboe

