From: Christoph Hellwig <hch@lst.de>
Subject: Re: [libata]  a234f7395c:
        BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h
Date: Sat, 14 Jan 2017 08:32:21 +0100
Message-ID: <20170114073221.GA20029@lst.de>
References: <20170113222659.GA105338@inn.lkp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35258 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdANHcY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 14 Jan 2017 02:32:24 -0500
Content-Disposition: inline
In-Reply-To: <20170113222659.GA105338@inn.lkp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org

Ok, plain GFP_NOFS allocations obviously don't do it inside
->queuecommand context.  I'll cook up a fix later today.
