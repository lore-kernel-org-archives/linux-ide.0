From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata: add support for NCQ commands for SG interface
Date: Mon, 16 Nov 2015 10:31:33 -0500
Message-ID: <20151116153133.GA18894@mtj.duckdns.org>
References: <1445924955-11124-1-git-send-email-vinayak.kale@seagate.com>
 <5649DE67.7080509@start.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36521 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbbKPPbh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2015 10:31:37 -0500
Content-Disposition: inline
In-Reply-To: <5649DE67.7080509@start.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@start.ca>
Cc: vinayak.kale@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

On Mon, Nov 16, 2015 at 08:47:19AM -0500, Mark Lord wrote:
> On 15-10-27 01:49 AM, vinayak.kale@gmail.com wrote:
> >From: Vinayak Kale <vinayak.kale@seagate.com>
> >
> >This patch is needed to make NCQ commands with FPDMA protocol value
> >(eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.
> ..
> >+	/* For NCQ commands with FPDMA protocol, copy the tag value */
> >+	if (tf->protocol == ATA_PROT_NCQ)
> >+		tf->nsect = qc->tag << 3;
> >+
> 
> 
> What prevents the qc-tag value here from conflicting with in-flight I/O
> using the exact same qc-tag ??

The SG command doesn't set the tag, it's being set from an allocated
qc which can't otherwise be in-flight.

Thanks.

-- 
tejun
