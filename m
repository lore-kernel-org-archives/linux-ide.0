From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 15:21:37 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406733D1.2060009@pobox.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <20040328140807.GD24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5600 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262441AbUC1UVx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 15:21:53 -0500
In-Reply-To: <20040328140807.GD24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> So you could change ->max_sectors to be 'max allowable io, hardware
> limitation' and add ->optimal_sectors to be 'best sized io'. I don't see
> tha it buys you anything, since you'd be going for optimal_sectors all
> the time anyways.


In terms of implementation, I imagine we would add a ->max_hw_sectors, 
once the IO scheduler and VM (or userland?) are smart enough to tune 
->max_sectors dynamically.

	Jeff



