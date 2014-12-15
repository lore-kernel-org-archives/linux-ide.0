From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] block: support different tag allocation policy
Date: Mon, 15 Dec 2014 08:57:12 -0800
Message-ID: <20141215165712.GA27010@infradead.org>
References: <e0ea802ef0d4170ad409e5dbf814c28581c091ac.1418613253.git.shli@fb.com>
 <20141215080813.GA3982@infradead.org>
 <20141215162443.GA3147371@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48107 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaLOQ5M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Dec 2014 11:57:12 -0500
Content-Disposition: inline
In-Reply-To: <20141215162443.GA3147371@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>

On Mon, Dec 15, 2014 at 08:24:43AM -0800, Shaohua Li wrote:
> The policy for blkmq will be added later.

It doesn't make sense to move libata to block layer tagging before this
has been sorted out.
