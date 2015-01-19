From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] libata: micro-optimize tag allocation
Date: Mon, 19 Jan 2015 09:14:48 -0500
Message-ID: <20150119141448.GC8140@htj.dyndns.org>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
 <20150116231307.18771.52330.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:60631 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbASOOz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2015 09:14:55 -0500
Received: by mail-qg0-f44.google.com with SMTP id l89so16388765qgf.3
        for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2015 06:14:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150116231307.18771.52330.stgit@viggo.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, Jens Axboe <axboe@fb.com>, Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@infradead.org>

On Fri, Jan 16, 2015 at 03:13:08PM -0800, Dan Williams wrote:
> Jens notes, "libata tag allocator sucks. Like seriously sucks, it's
> almost a worst case implementation."  Previously I thought SATA mmio
> latency dominated performance profiles, but as Tejun notes:
> 
>   "Hmmm... one problem with the existing tag allocator in ata is that
>    it's not very efficient which actually shows up in profile when libata
>    is used with a very zippy SSD.  Given that ata needs a different
>    allocation policies anyway maybe the right thing to do is making the
>    existing allocator suck less."
> 
> So replace it with a naive enhancement that also supports the existing
> quirks.  Hopefully, soon to be replaced by Shaohua's patches [1], but
> those do not yet support the quirk needed by sil24 (ATA_FLAG_LOWTAG)
> [2].
> 
> [1]: http://marc.info/?l=linux-ide&m=142137195324687&w=2
> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=87101
> 
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Shaohua Li <shli@fb.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hmmm... if libata using blk-tag isn't ugly, I think that prolly is the
better way to proceed.  Let's see how that develops.

Thanks.

-- 
tejun
