From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 2/2] libata: micro-optimize tag allocation
Date: Fri, 16 Jan 2015 16:17:21 -0700
Message-ID: <54B99C01.2030507@fb.com>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com> <20150116231307.18771.52330.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43615 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752089AbbAPXRf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2015 18:17:35 -0500
In-Reply-To: <20150116231307.18771.52330.stgit@viggo.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@infradead.org>

On 01/16/2015 04:13 PM, Dan Williams wrote:
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

That's trivial to do, it's just always having '0' in the cache and
that's where the search would start.

-- 
Jens Axboe

