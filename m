From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 10/10] libata-scsi: minor cleanup for
 ata_scsi_zbc_out_xlat
Date: Fri, 15 Jul 2016 08:09:37 -0400
Message-ID: <20160715120937.GG3078@mtj.duckdns.org>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-11-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36302 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932779AbcGOMJj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jul 2016 08:09:39 -0400
Received: by mail-yw0-f196.google.com with SMTP id y188so6542705ywf.3
        for <linux-ide@vger.kernel.org>; Fri, 15 Jul 2016 05:09:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468454751-12466-11-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

On Thu, Jul 14, 2016 at 09:05:51AM +0900, Christoph Hellwig wrote:
> From: Damien Le Moal <damien.lemoal@hgst.com>
> 
> The reset_all variable name is misleading as this bit is also applicable to
> open, close, and finish actions. So rename that variable to "all" and remove
> the unnecessary mask operation that's already done earlier.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
> [hch: split from the previous patch]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied 7-10 to libata/for-4.8.

So, I dropped 4 and applied the rest.  Can you please check whether
the tree looks okay just in case?

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.8

Thanks.

-- 
tejun
