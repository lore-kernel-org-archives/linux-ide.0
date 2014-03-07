From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: end the r-word
Date: Fri, 7 Mar 2014 08:06:54 -0500
Message-ID: <20140307130654.GC30778@htj.dyndns.org>
References: <20140306032706.9641.99151.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:51701 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaCGNG6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2014 08:06:58 -0500
Received: by mail-qc0-f176.google.com with SMTP id m20so4561668qcx.35
        for <linux-ide@vger.kernel.org>; Fri, 07 Mar 2014 05:06:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140306032706.9641.99151.stgit@viggo.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

Hello, Dan.

On Wed, Mar 05, 2014 at 07:33:04PM -0800, Dan Williams wrote:
> We want our contributors to spend their anger, resentment, and
> frustration emotional resources on finding and fixing broken code.  We
> do not want those valuable resources wasted on unfortunately worded
> comments.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Hi Tejun,
> 
> Today is "Spread the Word to End the Word" day, so I thought it would be
> an interesting exercise to see how often the r-word is used in kernel
> code comments.  Suprisingly, to me at least, it's rare.  In fact it
> seems only libata uses it in code commentary.
> 
> Please consider applying this patch to call slow-to-reset devices
> outliers.

I lack the cultural context to evaluate whether this is necessary.
That said, there's no reason to cling onto it when an active
contributor cares enough to submit a patch about it.  Can you please
make the patch description a bit drier tho?

Thanks.

-- 
tejun
