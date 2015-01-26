From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: make sata_sil24 use fifo tag allocator
Date: Mon, 26 Jan 2015 11:14:28 -0500
Message-ID: <20150126161428.GB21242@htj.dyndns.org>
References: <e836211c9bce48b23ddf37a4d8832e1b2fbd893c.1422072962.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:64416 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbbAZQOc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2015 11:14:32 -0500
Received: by mail-qa0-f53.google.com with SMTP id n4so7358443qaq.12
        for <linux-ide@vger.kernel.org>; Mon, 26 Jan 2015 08:14:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e836211c9bce48b23ddf37a4d8832e1b2fbd893c.1422072962.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: linux-ide@vger.kernel.org, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>

On Fri, Jan 23, 2015 at 08:17:59PM -0800, Shaohua Li wrote:
> libata starts using block tag now, we can use BLK_TAG_ALLOC_FIFO to
> solve the sata_sil24 tag bug.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=87101
> 
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Shaohua Li <shli@fb.com>

I suppose this should go through the block tree too?  Please feel free
to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
