From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 13:41:47 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040329124147.GC4984@mail.shareable.org>
References: <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> <20040329080943.GR24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.shareable.org ([81.29.64.88]:23443 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262909AbUC2MmO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Mar 2004 07:42:14 -0500
Content-Disposition: inline
In-Reply-To: <20040329080943.GR24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> Could be used to limit tcq depth, not just request sizes solving two
> problems at once. I already have a tiny bit of keeping this
> accounting to do proper unplugs (right now it just looks at missing
> requests from the pool, doesn't work on tcq).

Does it make sense to allow different numbers of outstanding TCQ-reads
and TCQ-writes?

-- Jamie
