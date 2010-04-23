From: Harry Zhang <harry.zhang@amd.com>
Subject: Re: [PATCH 1/2 v4] ahci add "em_buffer" attribute for AHCI hosts
Date: Fri, 23 Apr 2010 10:47:08 +0800
Message-ID: <1271990828.3821.16.camel@zm-desktop>
References: <1271931333.3745.7.camel@zm-desktop>
	 <4BD06C89.7060102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:57308 "EHLO
	TX2EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab0DWCrV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 22:47:21 -0400
In-Reply-To: <4BD06C89.7060102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, shane.Huang@amd.com

Hi Tejun,

On Thu, 2010-04-22 at 17:34 +0200, Tejun Heo wrote:
> Hello, Harry.
> 
> On 04/22/2010 12:15 PM, Harry Zhang wrote:
> > +	/* Since EM buffer is in ABAR, commonly, the buffer size should be
> > +	 * less than a page. Check buffer size against PAGE_SIZE in case of
> > +	 * some rare instance. Only transfer the first page in this case.
> > +	 */
> 
> Oh, the PAGE_SIZE limit comes from the way sysfs attributes are
> implemented.  The kernel buffer sysfs uses is PAGE_SIZE so
> reads/writes can't be larger than that.  If you write past PAGE_SIZE
> from show, you'll corrupt someone else's memory.
Yes, I know that. I just think the EM read buffer size should not larger
than the PAGE_SIZE in common, and thus, should not break the sysfs
attributes r/w buffer limitation. Anyway, I will shorten the comment.
> 
> > +	if (count > PAGE_SIZE) {
> > +		dev_printk(KERN_WARNING, dev, 
> > +			   "EM read buffer size %u is larger than %lu",
> > +			   hpriv->em_buf_sz, PAGE_SIZE);
> > +		count = PAGE_SIZE;
> > +	}
> 
> It probably would be better to use ata_port_printk() and
> printk_ratelimit() the message.
OK. I could not determine which is better. I think the EM buffer is
belong to the host rather than a port, so I chose the "dev_printk".
BTW, should this be a warning or an error?
> Thanks.
> 
Thanks,
Harry

