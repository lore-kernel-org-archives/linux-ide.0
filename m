From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] SATA NCQ #4
Date: Wed, 8 Jun 2005 13:41:51 +0200
Message-ID: <20050608114150.GE18490@suse.de>
References: <20050608102857.GC18490@suse.de> <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:49367 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262186AbVFHLn7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2005 07:43:59 -0400
Content-Disposition: inline
In-Reply-To: <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

On Wed, Jun 08 2005, Grant Coady wrote:
> Hi Jens,
> On Wed, 8 Jun 2005 12:28:59 +0200, Jens Axboe <axboe@suse.de> wrote:
> >
> >This should be pretty final, at least only minor stuff left. Changes:
> 
> Fell over here, on http://scatter.mine.nu/test/boxen/sempro/
> 
> No logged info, just scrolling heaps junk on screen --> libata 
> I could see and I think 8 digit hex in [] on left.  
> 
> Hit RESET to reboot, no apparent filesystem damage :)  Sorry so 
> little info.  patched 2.6.12-rc6 cleanly  seemed to go stupid 
> during mount reiserfs partitions, about that stage of boot.

Interesting, looking at your boot log from 2.6.12-rc6 your controller is
a via and thus doesn't support NCQ at all so the patch should do nothing
for you.

I'll try and disable ahci on one box here to see if it catches anything,
if not I'll probably ask you for more details.

-- 
Jens Axboe

