From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] libata: micro-optimize tag allocation
Date: Fri, 16 Jan 2015 15:19:41 -0800
Message-ID: <CAPcyv4hrWFVxb_R9wmRAgVKGgxvoJrB9mN9Vx_6M5EUEDFAA3A@mail.gmail.com>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
	<20150116231307.18771.52330.stgit@viggo.jf.intel.com>
	<54B99C01.2030507@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:41882 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbAPXTn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2015 18:19:43 -0500
Received: by mail-wi0-f182.google.com with SMTP id n3so5104141wiv.3
        for <linux-ide@vger.kernel.org>; Fri, 16 Jan 2015 15:19:42 -0800 (PST)
In-Reply-To: <54B99C01.2030507@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@fb.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@infradead.org>

On Fri, Jan 16, 2015 at 3:17 PM, Jens Axboe <axboe@fb.com> wrote:
> On 01/16/2015 04:13 PM, Dan Williams wrote:
>> Jens notes, "libata tag allocator sucks. Like seriously sucks, it's
>> almost a worst case implementation."  Previously I thought SATA mmio
>> latency dominated performance profiles, but as Tejun notes:
>>
>>   "Hmmm... one problem with the existing tag allocator in ata is that
>>    it's not very efficient which actually shows up in profile when libata
>>    is used with a very zippy SSD.  Given that ata needs a different
>>    allocation policies anyway maybe the right thing to do is making the
>>    existing allocator suck less."
>>
>> So replace it with a naive enhancement that also supports the existing
>> quirks.  Hopefully, soon to be replaced by Shaohua's patches [1], but
>> those do not yet support the quirk needed by sil24 (ATA_FLAG_LOWTAG)
>> [2].
>
> That's trivial to do, it's just always having '0' in the cache and
> that's where the search would start.
>

Cool.
