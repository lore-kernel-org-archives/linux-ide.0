From: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the
 IRQ context
Date: Fri, 07 Aug 2009 09:01:58 -0700 (PDT)
Message-ID: <20090807.090158.45976865.davem@davemloft.net>
References: <200907011835.27586.bzolnier@gmail.com>
	<20090701.134729.13610576.davem@davemloft.net>
	<200908071355.21648.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753792AbZHGQBu@vger.kernel.org>
In-Reply-To: <200908071355.21648.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Fri, 7 Aug 2009 13:55:21 +0200

> On Wednesday 01 July 2009 22:47:29 David Miller wrote:
>> Will get to it before the end of the weekend.
>> 
>> If I fail or abort, I'll integrate your version of the fix Bart, don't
>> worry :)
> 
> Not that I'm worried but just out of curiosity..
> 
> Could you please tell me which week/month/year are we talking about here?

I became busier than I expected here in New York :-)

Actually both patches #4 and #5 are in my ide-next-2.6 tree, I just
need to publish it out to kernel.org and update the patchwork status
on these patches.
