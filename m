From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_rcar: clear STOP bit in bmdma_start() method
Date: Wed, 22 May 2013 08:41:28 +0900
Message-ID: <20130521234128.GD6985@mtj.dyndns.org>
References: <201305212307.55385.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:65420 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3EUXlc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 May 2013 19:41:32 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so1210917pab.32
        for <linux-ide@vger.kernel.org>; Tue, 21 May 2013 16:41:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305212307.55385.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

On Tue, May 21, 2013 at 11:07:54PM +0400, Sergei Shtylyov wrote:
> Iff bmdma_setup() has to stop a DMA transfer before starting a new one, then the
> STOP bit in the ATAPI_CONTROL1 register will remain set (it's only cleared when
> setting the START bit to 1) and then bmdma_start() method will set both START
> and STOP bits simultaneously which should abort the transfer being just started.
> Avoid that by explicitly clearing the STOP bit in bmdma_start() method (in this
> case it will be ignored on write).
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-3.10-fixes w/ stable cc'd.

Thanks.

-- 
tejun
