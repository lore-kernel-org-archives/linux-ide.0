From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: do ata_qc_new inside host_set lock
Date: Sun, 26 Jun 2005 13:25:08 -0400
Message-ID: <42BEE4F4.90901@pobox.com>
References: <20050626143623.GC24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:5068 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261484AbVFZRZN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 13:25:13 -0400
In-Reply-To: <20050626143623.GC24968@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff.
>  Hello, Jens.
> 
>  This is the third of six misc updates to ncq.
> 
>  ata_qc_new() used to use atomic test_and_set_bit() to allocate qc.
> This makes grabbing host_set lock before calling ata_qc_new_init()
> unncessary, but in most cases (normal SCSI requests) we're holding the
> lock on entry anyway, so the optimization just adds expensive atomic
> bitops.  This patch makes qc allocation performed inside host_set lock
> and uses ffz() instead of atomic bitops.
> 
>  Signed-off-by: Tejun Heo <htejun@gmail.com>

hmmmm, I rather liked the old way.  I'll give this one some thought.


