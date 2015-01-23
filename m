From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 3/3] libata: use blk taging
Date: Fri, 23 Jan 2015 15:13:05 -0500
Message-ID: <20150123201305.GC23011@htj.dyndns.org>
References: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421371412.git.shli@fb.com>
 <92a8da78d57926f61e9050168499872d52066f1c.1421371412.git.shli@fb.com>
 <20150116082344.GA4913@infradead.org>
 <20150116221600.GA1099317@devbig257.prn2.facebook.com>
 <20150122211220.GA2123210@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:52897 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbbAWUNJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2015 15:13:09 -0500
Received: by mail-qa0-f51.google.com with SMTP id f12so7440858qad.10
        for <linux-ide@vger.kernel.org>; Fri, 23 Jan 2015 12:13:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150122211220.GA2123210@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, Kernel-team@fb.com, dan.j.williams@intel.com, Jens Axboe <axboe@fb.com>

On Thu, Jan 22, 2015 at 01:12:20PM -0800, Shaohua Li wrote:
> Hi Tejun,
> are you ok to pick up these patches?

Yeah, looks fine from libata side.  Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

and route as you see fit.  If these can go through libata, please let
me know.

Thanks.

-- 
tejun
