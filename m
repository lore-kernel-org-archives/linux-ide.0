From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 14:51:24 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040328135124.GA32597@mail.shareable.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.shareable.org ([81.29.64.88]:54162 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261774AbUC1Nvd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 08:51:33 -0500
Content-Disposition: inline
In-Reply-To: <40662108.40705@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jeff Garzik wrote:
> TCQ-on-write for ATA disks is yummy because you don't really know what 
> the heck the ATA disk is writing at the present time.  By the time the 
> Linux disk scheduler gets around to deciding it has a nicely merged and 
> scheduled set of requests, it may be totally wrong for the disk's IO 
> scheduler.  TCQ gives the disk a lot more power when the disk integrates 
> writes into its internal IO scheduling.

Does TCQ-on-write allow you to do ordered write commits, as with barriers,
but without needing full cache flushes, and still get good performance?

In principle I think the answer is yes, but what is the answer with
real disks in practice?

-- Jamie
