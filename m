From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: rewrite __ata_qc_complete
Date: Sun, 26 Jun 2005 13:27:47 -0400
Message-ID: <42BEE593.7050004@pobox.com>
References: <20050626144110.GD24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:6860 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261506AbVFZR1y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 13:27:54 -0400
In-Reply-To: <20050626144110.GD24968@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff.
>  Hello, Jens.
> 
>  This is the fource, no, fourth (dang, that starwars) of six misc
> updates to ncq.
> 
>  This patch rewrites __ata_qc_complete() to make it look more sane.
> Also, remove spurious clearing of ATA_QCFLAG_ACTIVE from
> ata_qc_complete().
> 
>  Signed-off-by: Tejun Heo <htejun@gmail.com>

I'll have to stare at this a bit more.  This has big potential for 
creating races if not perfect.


