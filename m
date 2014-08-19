From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Use dev_name() for request_irq() to distinguish
 devices
Date: Tue, 19 Aug 2014 11:47:23 -0400
Message-ID: <20140819154723.GB16480@htj.dyndns.org>
References: <1408431064-6796-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44711 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaHSPrb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2014 11:47:31 -0400
Received: by mail-qc0-f170.google.com with SMTP id x3so6479247qcv.15
        for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2014 08:47:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408431064-6796-1-git-send-email-shc_work@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-ide@vger.kernel.org

On Tue, Aug 19, 2014 at 10:51:04AM +0400, Alexander Shiyan wrote:
> Use dev_name() instead of driver name for request_irq().
> This will help to distinguish between multiple identical devices.
> 
> Before:
>  CPU0
>  5:      34425  clps711x-intc   5  pata_of_platform
>  6:       6778  clps711x-intc   6  pata_of_platform
> 
> After:
>  CPU0
>  5:       2182  clps711x-intc   5  20000000.ide
>  6:      11024  clps711x-intc   6  20100000.ide
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to libata/for-3.18.

Thanks.

-- 
tejun
