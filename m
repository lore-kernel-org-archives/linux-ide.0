From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/4] libata: consolidate ata_dev_classify()
Date: Mon, 8 Sep 2014 01:02:34 +0900
Message-ID: <20140907160234.GA26367@mtj.dyndns.org>
References: <1406706911-79510-1-git-send-email-hare@suse.de>
 <1406706911-79510-2-git-send-email-hare@suse.de>
 <20140905234241.GH15723@mtj.dyndns.org>
 <540AC41F.8020506@suse.de>
 <20140906125227.GA29401@mtj.dyndns.org>
 <540C407F.5030305@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62058 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbaIGQCk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2014 12:02:40 -0400
Content-Disposition: inline
In-Reply-To: <540C407F.5030305@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, James Bottomley <jbottomley@parallels.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Sun, Sep 07, 2014 at 01:24:47PM +0200, Hannes Reinecke wrote:
> Which was actually my first attempt, but then I figured I'd be
> increasing the stacksize in doing so.
> But sure, if you're okay with it I'll be redoing the patch.

The struct is only 32 bytes.  I don't think it's gonna make any
meaningful difference.

Thanks.

-- 
tejun
