From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 13:50:03 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040329125003.GD4984@mail.shareable.org>
References: <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> <20040329080943.GR24370@suse.de> <20040329124147.GC4984@mail.shareable.org> <20040329124421.GB24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.shareable.org ([81.29.64.88]:25235 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262941AbUC2MuL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Mar 2004 07:50:11 -0500
Content-Disposition: inline
In-Reply-To: <20040329124421.GB24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> > Does it make sense to allow different numbers of outstanding TCQ-reads
> > and TCQ-writes?
> 
> Might not be a silly thing to experiment with, definitely something that
> should be tested (added to list...)

Then there's another question: when deciding whether you can issue
another TCQ-read, do you compare the number of outstanding TCQ-reads
against the TCQ-read limit, or compare the _total_ number of
outstanding TCQs against the TCQ-read limit?  Similarly for writes.

There are several other logical combinations that could be used.

Each condition will have a different effect on mean and peak latencies
under different load patterns.  I'm not sure which makes more sense,
or even if multiple conditions should be used together.

-- Jamie
