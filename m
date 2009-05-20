From: Tejun Heo <htejun@gmail.com>
Subject: Re: ibata: get rid of ATA_MAX_QUEUE loop in ata_qc_complete_multiple()
 v2
Date: Wed, 20 May 2009 16:46:27 +0900
Message-ID: <4A13B553.6010209@gmail.com>
References: <20090520074439.GJ11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:49779 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZETHqb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 03:46:31 -0400
Received: by pxi29 with SMTP id 29so252043pxi.33
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 00:46:32 -0700 (PDT)
In-Reply-To: <20090520074439.GJ11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Jens Axboe wrote:
> We very rarely (if ever) complete more than one command in the
> sactive mask at the time, even for extremely high IO rates. So
> looping over the entire range of possible tags is pointless,
> instead use __ffs() to just find the completed tags directly.
> 
> Updated to clear the tag from the done_mask instead of shifting
> done_mask down as suggested by From: Tejun Heo <htejun@gmail.com>
> Verified with a user space tester to produce the same results.
> 
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
