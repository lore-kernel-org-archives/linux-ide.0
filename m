From: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk
Date: Fri, 18 Jan 2008 12:41:08 -0600
Message-ID: <1200681668.25782.9.camel@cinder.waste.org>
References: <1200445210549-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:56676 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759676AbYARSmi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jan 2008 13:42:38 -0500
In-Reply-To: <1200445210549-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, daniel.ritz-ml@swissonline.ch, randy.dunlap@oracle.com, jeff@garzik.org, linux-ide@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>


On Wed, 2008-01-16 at 10:00 +0900, Tejun Heo wrote:
> And mprintk the following.
> 
>  code:
>   DEFINE_MPRINTK(mp, 2 * 80);
> 
>   mprintk_set_header(&mp, KERN_INFO "ata%u.%2u: ", 1, 0);
>   mprintk_push(&mp, "ATA %d", 7);
>   mprintk_push(&mp, ", %u sectors\n", 1024);
>   mprintk(&mp, "everything seems dandy\n");

I prefer Matthew Wilcox's stringbuf approach which does proper memory
management and isn't specific to printk:

http://www.ussg.iu.edu/hypermail/linux/kernel/0710.3/0517.html

-- 
Mathematics is the supreme nostalgia of our time.

