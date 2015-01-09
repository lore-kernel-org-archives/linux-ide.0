From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Fri, 9 Jan 2015 16:43:07 -0500
Message-ID: <20150109214307.GE2785@htj.dyndns.org>
References: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
 <546516bb62c91671b1464e6a7c68eebc8422efe5.1418928090.git.shli@fb.com>
 <20150109181529.GA1301458@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:63274 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbbAIVnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2015 16:43:10 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so11198395qcq.11
        for <linux-ide@vger.kernel.org>; Fri, 09 Jan 2015 13:43:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150109181529.GA1301458@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: linux-ide@vger.kernel.org, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>

On Fri, Jan 09, 2015 at 10:15:29AM -0800, Shaohua Li wrote:
> Ping!

I like the idea but it bothers me that we end up with two separate
ways of allocating command tags.  Any chance the old one can be
removed?

Thanks.

-- 
tejun
